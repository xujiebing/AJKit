//
//  AJAES128.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import "AJAES128.h"

@implementation AJAES128

+ (NSString *)AES128Encrype:(NSString *)text key:(NSString *)key {
    NSData *encrypeData = [self encrype:text key:key];
    if (!encrypeData) {
        return nil;
    }
    return [self hexString:encrypeData];
}

+ (NSString *)AES128EncrypeBase64:(NSString *)text key:(NSString *)key {
    NSData *encrypeData = [self encrype:text key:key];
    if (!encrypeData) {
        return nil;
    }
    return [encrypeData base64EncodedStringWithOptions:0];
}

+ (NSData *)encrype:(NSString *)text key:(NSString *)key {
    
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          0x0000 | kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return resultData;
    }
    
    free(buffer);
    return nil;
}

+ (NSString *)AES128Decrype:(NSString *)encrypeText key:(NSString *)key {
    NSData *data = [self dataWithHexString:encrypeText];
    return [self decrype:data key:key];
}

+ (NSString *)AES128DecrypeBase64:(NSString *)encrypeText key:(NSString *)key {
    NSData *data = NSString.ajBase64DecodeToData(encrypeText);
    return [self decrype:data key:key];
}

+ (NSString *)decrype:(NSData *)data key:(NSString *)key {
    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
//    NSData *data = [self dataWithHexString:encrypeText];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return   [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
        
    }
    free(buffer);
    return nil;
}

+ (NSString *)hexString:(NSData *)data {
    NSUInteger length = data.length;
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    const unsigned char *byte = data.bytes;
    for (int i = 0; i < length; i++, byte++) {
        [result appendFormat:@"%02X", *byte];
    }
    return result;
}

+ (NSData *)dataWithHexString:(NSString *)hexStr {
    hexStr = [hexStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    hexStr = [hexStr lowercaseString];
    NSUInteger len = hexStr.length;
    if (!len) return nil;
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) return nil;
    [hexStr getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableData *result = [NSMutableData data];
    unsigned char bytes;
    char str[3] = { '\0', '\0', '\0' };
    int i;
    for (i = 0; i < len / 2; i++) {
        str[0] = buf[i * 2];
        str[1] = buf[i * 2 + 1];
        bytes = strtol(str, NULL, 16);
        [result appendBytes:&bytes length:1];
    }
    free(buf);
    return result;
}
@end
