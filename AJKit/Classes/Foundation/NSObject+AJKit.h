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
/// - Parameters: id
+ (BOOL (^)(id))ajIsJSONObject;

/// 获取Class类名
/// - Parameters: id
+ (NSString *(^)(id))ajClassName;

/// json格式化
/// - Parameters: id
+ (NSString *(^)(id))ajJsonString;

@end

NS_ASSUME_NONNULL_END