//
//  AJAES+AJKit.m
//  Base64
//
//  Created by 徐结兵 on 2020/4/9.
//

#import "AJAES+AJKit.h"

@implementation AJAES (AJKit)

+ (NSString *)encrypt256:(NSString *)key message:(NSString *)message {
    if (NSString.ajIsEmpty(key) || NSString.ajIsEmpty(key)) {
        return nil;
    }
    NSData *result = [self encrype256:message key:key];
    return result.ajToHexString;
}

+ (NSString *)decrypt256:(NSString *)key message:(NSString *)message {
    if (NSString.ajIsEmpty(key) || NSString.ajIsEmpty(key)) {
        return nil;
    }
    NSData *data = [self p_dataForHexString:message];
    return [self decrype256:data key:key];
}

+ (NSString *)encrypt128:(NSString *)key message:(NSString *)message {
    if (NSString.ajIsEmpty(key) || NSString.ajIsEmpty(key)) {
        return nil;
    }
    NSData *encrypeData = [self encrype128:message key:key];
    if (!encrypeData) {
        return nil;
    }
    return [self p_hexString:encrypeData];
}

+ (NSString *)decrypt128:(NSString *)key message:(NSString *)message {
    NSData *data = [self p_dataForHexString:message];
    return [self decrype128:data key:key];
}

+ (NSString *)encrypt128Base64:(NSString *)key message:(NSString *)message {
    if (NSString.ajIsEmpty(key) || NSString.ajIsEmpty(key)) {
        return nil;
    }
    NSData *encrypeData = [self encrype128:message key:key];
    if (!encrypeData) {
        return nil;
    }
    return [encrypeData ajBase64Encoding];
}

+ (NSString *)decrypt128Base64:(NSString *)key message:(NSString *)message {
    NSData *data = message.ajBase64EncodingData;
    return [self decrype128:data key:key];
}

+ (NSString *)p_hexString:(NSData *)data {
    NSUInteger length = data.length;
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    const unsigned char *byte = data.bytes;
    for (int i = 0; i < length; i++, byte++) {
        [result appendFormat:@"%02X", *byte];
    }
    return result;
}

+ (NSData *)p_dataForHexString:(NSString *)string {
    
    NSString *hexString = string;
    const char *ch = [[hexString lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *data = [NSMutableData data];
    while (*ch) {
        if (*ch == ' ') {
            continue;
        }
        char byte = 0;
        if ('0' <= *ch && *ch <= '9') {
            byte = *ch - '0';
        } else if ('a' <= *ch && *ch <= 'f') {
            byte = *ch - 'a' + 10;
        } else if ('A' <= *ch && *ch <= 'F') {
            byte = *ch - 'A' + 10;
        }
        ch++;
        byte = byte << 4;
        
        if (*ch) {
            if ('0' <= *ch && *ch <= '9') {
                byte += *ch - '0';
            } else if ('a' <= *ch && *ch <= 'f') {
                byte += *ch - 'a' + 10;
            } else if('A' <= *ch && *ch <= 'F') {
                byte += *ch - 'A' + 10;
            }
            ch++;
        }
        [data appendBytes:&byte length:1];
    }
    return data;
}

@end
