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
/// @param NSData* data对象
/// @return BOOL 是否为空
+ (BOOL (^)(NSData *ajSelf))ajIsEmpty;

/// 将NSData对象转换为十六进制的字符串
/// @return NSString* 十六进制的字符串或nil
- (NSString *)ajHexString;

/// 将NSData转换成一个base64格式的字符串
/// @return NSString* base64格式的字符串或nil
- (NSString *)ajBase64Encode;

/// 将NSData转换成json对象
/// @return id json对象或nil
- (id)ajJsonValueDecoded;

/// 将NSData转换成字符串（UTF8格式）
/// @return NSString* 字符串或nil
- (NSString *)ajStringValue;

@end

NS_ASSUME_NONNULL_END
