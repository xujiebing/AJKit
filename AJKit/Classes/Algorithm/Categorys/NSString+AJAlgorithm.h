//
//  NSString+AJAlgorithm.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AJAlgorithm)

/// 将字符串MD5加密
- (NSString *)ajMd5String;

/// 对字符串进行aes128加密,加密后的字符串为16进制
- (NSString * (^)(NSString *key))ajAes128Encrypt;

/// 进行aes128解密,待解密的字符串为16进制
- (NSString * (^)(NSString *key))ajAes128Decrypt;

/// 对字符串进行aes128加密,加密后的字符串为base64
- (NSString * (^)(NSString *key))ajAes128EncryptBase64;

/// 进行aes128解密,待解密的字符串为base64
- (NSString * (^)(NSString *key))ajAes128DecryptBase64;

@end

NS_ASSUME_NONNULL_END
