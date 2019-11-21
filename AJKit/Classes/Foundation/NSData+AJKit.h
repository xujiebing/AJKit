//
//  NSData+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (AJKit)

/// 将NSData对象转换为十六进制的字符串
- (NSString *)ajHexString;

/// 将NSData对象转换为十六进制的字符串
- (NSString *)ajConvertDataToHexString;

/// 将NSData转换成一个base64格式的字符串
- (NSString *)ajBase64Encoding;

/// 返回一个json格式的对象，如果不是json格式，则返回nil
- (id)ajJsonValueDecoded;

/// 将NSData转换utf8格式的字符串
- (NSString *)ajUtf8String;

@end

NS_ASSUME_NONNULL_END
