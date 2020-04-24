//
//  AJAES.h
//  Base64
//
//  Created by 徐结兵 on 2020/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJAES : NSObject

/// 加密
/// @param text 原文
/// @param key 秘钥
+ (NSData *)encrype256:(NSString *)text key:(NSString *)key;

/// 解密
/// @param data 密文data
/// @param key 秘钥
+ (NSString *)decrype256:(NSData *)data key:(NSString *)key;

/// 加密
/// @param text 原文
/// @param key 秘钥
+ (NSData *)encrype128:(NSString *)text key:(NSString *)key;

/// 解密
/// @param data 密文data
/// @param key 秘钥
+ (NSString *)decrype128:(NSData *)data key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
