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
/// - Parameters: NSArray *
+ (BOOL (^)(NSArray *))ajIsEmpty;

/// 获取数组中对象
/// - Parameters: NSArray *, NSUInteger
+ (id (^)(NSArray *array, NSUInteger index))ajObjectAtIndex;

@end

@interface NSMutableArray (AJKit)

/// 判断数组是否为空
/// - Parameters: NSMutableArray *
+ (BOOL (^)(NSMutableArray *))ajIsEmpty;

/// 可变数组中添加对象
/// - Parameters: NSMutableArray *, id
+ (void (^)(NSMutableArray *array, id object))ajAddObject;

@end

NS_ASSUME_NONNULL_END
