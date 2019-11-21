//
//  NSData+AJAlgorithm.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import "NSData+AJAlgorithm.h"

@implementation NSData (AJAlgorithm)

- (NSString *)ajMd5String {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    NSString *md5String = [NSString stringWithFormat:
    @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
    result[0], result[1], result[2], result[3],
    result[4], result[5], result[6], result[7],
    result[8], result[9], result[10], result[11],
    result[12], result[13], result[14], result[15]];
    return md5String;
}

- (NSData *)ajMd5Data {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    NSData *md5Data = [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
    return md5Data;
}

@end
