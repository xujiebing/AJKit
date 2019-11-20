//
//  NSString+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AJKit)

/// 判断字符串是否为空
+ (BOOL (^)(NSString *))ajIsEmpty;

/// url编码
+ (NSString * (^)(NSString *))ajUrlDecodeString;

/// 字符串转对象
+ (id (^)(NSString *))ajJsonObject;

@end

NS_ASSUME_NONNULL_END
