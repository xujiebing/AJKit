//
//  AJAES+AJKit.h
//  Base64
//
//  Created by 徐结兵 on 2020/4/9.
//

NS_ASSUME_NONNULL_BEGIN

@interface AJAES (AJKit)

/// 对字符串进行aes256加密 , 256的服务端解析失败，暂时用128
/// @param key 加密key
/// @param message 加密信息
+ (NSString *)encrypt256:(NSString *)key message:(NSString *)message;

/// 进行aes256解密, 256的服务端解析失败，暂时用128
/// @param key 加密key
/// @param message 解密信息
+ (NSString *)decrypt256:(NSString *)key message:(NSString *)message;

/// 对字符串进行aes128加密,加密后的字符串为16进制
/// @param key 加密key
/// @param message 加密信息
+ (NSString *)encrypt128:(NSString *)key message:(NSString *)message;

/// 进行aes128解密,待解密的字符串为16进制
/// @param key 加密key
/// @param message 解密信息
+ (NSString *)decrypt128:(NSString *)key message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
