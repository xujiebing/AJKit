//
//  NSObject+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AJKit)

/// 判断对象是否是JSON对象
/// @param id 对象
/// @return BOOL 是否是JSON对象
+ (BOOL (^)(id ajSelf))ajIsJSONObject;

/// 获取Class类名
/// @param id 对象
/// @return NSString* 类名
+ (NSString *(^)(id ajSelf))ajClassName;

/// json格式化
/// @param id 对象
/// @return NSString* 格式化后的字符串
+ (NSString *(^)(id ajSelf))ajJsonString;

@end

NS_ASSUME_NONNULL_END
