//
//  NSData+AJKit.h
//  Base64
//
//  Created by 徐结兵 on 2020/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (AJKit)

/// 将NSData对象转换为md5的字符串
- (NSString *)ajToMd5String;

/// 将NSData对象转换为十六进制的字符串
- (NSString *)ajToHexString;

/// 将NSData转换成一个base64格式的字符串
- (NSString *)ajBase64Encoding;

@end

NS_ASSUME_NONNULL_END
