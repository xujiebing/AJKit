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
/// - Parameters: NSData *
+ (BOOL (^)(NSData *))ajIsEmpty;

/// 将NSData对象转换为十六进制的字符串
/// - Parameters: NSData *
+ (NSString *(^)(NSData *))ajHexString;

/// 将NSData转换成一个base64格式的字符串
/// - Parameters: NSData *
+ (NSString *(^)(NSData *))ajBase64Encode;

/// 将NSData转换成json对象，如果不是json格式，则返回nil
/// - Parameters: NSData *
+ (id (^)(NSData *))ajJsonValueDecoded;

/// 将NSData转换成字符串（UTF8格式）
/// - Parameters: NSData *
+ (NSString *(^)(NSData *))ajStringValue;

@end

NS_ASSUME_NONNULL_END
