//
//  NSObject+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AJKit)

+ (BOOL (^)(SEL _Nonnull, SEL _Nonnull))ajKitSwizzleMethod;

/// 判断对象是否是JSON对象
/// @return BOOL 是否是JSON对象
- (BOOL)ajIsJSONObject;

/// json格式化
/// @return NSString* 格式化后的字符串
- (NSString *)ajJsonValue;

/// 获取Class类名
/// @return NSString* 类名
- (NSString *)ajClassName;

/// 获取Class类名
/// @return NSString* 类名
+ (NSString *)ajClassName;

@end

NS_ASSUME_NONNULL_END
