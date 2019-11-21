//
//  AJAES128.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJAES128 : NSObject

/**
 AES128 加密,加密后的字符串为16进制
 @param text 明文
 @param key 加密密钥
 @reture 密文
 */
+ (NSString *)AES128Encrype:(NSString *)text key:(NSString *)key;

/**
 AES128 解密,待解密的字符串为16进制
 @param encrypeText 密文
 @param key 解密密钥
 @reture 明文
 */
+ (NSString *)AES128Decrype:(NSString *)encrypeText key:(NSString *)key;

/**
 AES128 加密,加密后的字符串为base64
 @param text 明文
 @param key 加密密钥
 @reture 密文
 */
+ (NSString *)AES128EncrypeBase64:(NSString *)text key:(NSString *)key;

/**
 AES128 解密,待解密的字符串为base64
 @param encrypeText 密文
 @param key 解密密钥
 @reture 明文
 */
+ (NSString *)AES128DecrypeBase64:(NSString *)encrypeText key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
