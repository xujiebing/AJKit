//
//  NSData+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import "NSData+AJKit.h"

static const char base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSData (AJKit)

+ (BOOL (^)(NSData * _Nonnull))ajIsEmpty {
    BOOL (^block)(NSData *) = ^(NSData *ajSelf) {
        if (![ajSelf isKindOfClass:NSData.class]) {
            return YES;
        }
        if (ajSelf.length == 0) {
            return YES;
        }
        return NO;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSData * _Nonnull))ajHexString {
    NSString * (^block)(NSData *) = ^(NSData *ajSelf){
        if (NSData.ajIsEmpty(ajSelf)) {
            return AJEmptyString;
        }
        Byte *bytes = (Byte *)[ajSelf bytes];
        NSString *hexStr = @"";
        for(int i=0; i<[ajSelf length]; i++) {
            NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i] & 0xff]; //16进制数
            newHexStr = [newHexStr uppercaseString];
            if([newHexStr length] == 1) {
                newHexStr = [NSString stringWithFormat:@"0%@",newHexStr];
            }
            hexStr = [hexStr stringByAppendingString:newHexStr];
        }
        return hexStr;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSData * _Nonnull))ajBase64Encode {
    NSString * (^block)(NSData *) = ^(NSData *ajSelf){
        if (NSData.ajIsEmpty(ajSelf)) {
            return AJEmptyString;
        }
        NSUInteger length = ajSelf.length;
        NSUInteger out_length = ((length + 2) / 3) * 4;
        uint8_t *output = malloc(((out_length + 2) / 3) * 4);
        if (output == NULL) {
            return AJEmptyString;
        }
        const char *input = ajSelf.bytes;
        NSInteger i, value;
        for (i = 0; i < length; i += 3) {
            value = 0;
            for (NSInteger j = i; j < i + 3; j++) {
                value <<= 8;
                if (j < length) {
                    value |= (0xFF & input[j]);
                }
            }
            NSInteger index = (i / 3) * 4;
            output[index + 0] = base64EncodingTable[(value >> 18) & 0x3F];
            output[index + 1] = base64EncodingTable[(value >> 12) & 0x3F];
            output[index + 2] = ((i + 1) < length)
            ? base64EncodingTable[(value >> 6) & 0x3F]
            : '=';
            output[index + 3] = ((i + 2) < length)
            ? base64EncodingTable[(value >> 0) & 0x3F]
            : '=';
        }
        NSString *base64 = [[NSString alloc] initWithBytes:output
                                                    length:out_length
                                                  encoding:NSASCIIStringEncoding];
        free(output);
        return base64;
    };
    return block;
}

+ (id _Nonnull (^)(NSData * _Nonnull))ajJsonValueDecoded {
    id (^block)(NSData *) = ^(NSData *ajSelf){
        id value = nil;
        if (NSData.ajIsEmpty(ajSelf)) {
            return value;
        }
        NSError *error = nil;
        value = [NSJSONSerialization JSONObjectWithData:ajSelf options:kNilOptions error:&error];
        if (error) {
            AJLog(@"jsonValueDecoded error:%@", error);
        }
        return value;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSData * _Nonnull))ajStringValue {
    NSString * (^block)(NSData *) = ^(NSData *ajSelf){
        if (NSData.ajIsEmpty(ajSelf)) {
            return AJEmptyString;
        }
        NSString *utf8String = [[NSString alloc] initWithData:ajSelf encoding:NSUTF8StringEncoding];
        return utf8String;
    };
    return block;
}

@end
