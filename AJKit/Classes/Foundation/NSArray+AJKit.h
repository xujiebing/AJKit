//
//  NSArray+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (AJKit)

/// 判断数组是否为空
/// @param NSArray* 数组对象
/// @return BOOL 是否为空
+ (BOOL (^)(NSArray *ajSelf))ajIsEmpty;

/// 获取数组中对象
/// @param NSArray* 数组对象
/// @param NSUInteger 索引
/// @return NSArray*数组对象
+ (id (^)(NSArray *ajSelf, NSUInteger index))ajObjectAtIndex;

@end

@interface NSMutableArray (AJKit)

/// 判断数组是否为空
/// @param NSMutableArray* 数组对象
/// @return BOOL 是否为空
+ (BOOL (^)(NSMutableArray *ajSelf))ajIsEmpty;

/// 可变数组中添加对象
/// @param NSMutableArray* 数组对象
/// @param id 对象
/// @return NSMutableArray* 数组对象
+ (void (^)(NSMutableArray *ajSelf, id object))ajAddObject;

@end

NS_ASSUME_NONNULL_END
