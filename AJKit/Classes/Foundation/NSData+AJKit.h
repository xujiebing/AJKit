//
//  NSData+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (AJKit)

/// 判断NSData是否为空
+ (BOOL (^)(NSData *))ajIsEmpty;

/// 将NSData对象转换为十六进制的字符串
+ (NSString *(^)(NSData *))ajHexString;

/// 将NSData转换成一个base64格式的字符串
+ (NSString *(^)(NSData *))ajBase64Encoding;

/// 将NSData转换成json对象，如果不是json格式，则返回nil
+ (id (^)(NSData *))ajJsonValueDecoded;

/// 将NSData转换成字符串（UTF8格式）
+ (NSString *(^)(NSData *))ajStringValue;

@end

NS_ASSUME_NONNULL_END
