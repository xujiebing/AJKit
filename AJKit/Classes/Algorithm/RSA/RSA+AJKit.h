//
//  RSA+AJKit.h
//  Base64
//
//  Created by 徐结兵 on 2020/4/9.
//

NS_ASSUME_NONNULL_BEGIN

@interface RSA (AJKit)

/// 加密
+ (NSString *)ajEncrypt:(NSDictionary *)params;

/// 解密
+ (NSString *)ajDecrypt:(NSString *)encrypt;

@end

NS_ASSUME_NONNULL_END
