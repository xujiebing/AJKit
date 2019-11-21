//
//  NSString+AJAlgorithm.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import "NSString+AJAlgorithm.h"

@implementation NSString (AJAlgorithm)

- (NSString *)ajMd5String {
    NSData *data = self.ajDataValue;
    NSString *md5String = data.ajMd5String;
    return md5String;
}

- (NSString * (^)(NSString *))ajAes128Encrypt {
    NSString * (^block)(NSString *) = ^(NSString *key){
        NSString *encrypt = [AJAES128 AES128Encrype:self key:key];
        return encrypt;
    };
    return block;
}

- (NSString * (^)(NSString *))ajAes128Decrypt {
    NSString * (^block)(NSString *) = ^(NSString *key){
        NSString *decrype = [AJAES128 AES128Decrype:self key:key];
        return decrype;
    };
    return block;
}

- (NSString * (^)(NSString *))ajAes128EncryptBase64 {
    NSString * (^block)(NSString *) = ^(NSString *key){
        NSString *encrypt = [AJAES128 AES128EncrypeBase64:self key:key];
        return encrypt;
    };
    return block;
}

- (NSString * (^)(NSString *))ajAes128DecryptBase64 {
    NSString * (^block)(NSString *) = ^(NSString *key){
        NSString *decrype = [AJAES128 AES128DecrypeBase64:self key:key];
        return decrype;
    };
    return block;
}







@end
