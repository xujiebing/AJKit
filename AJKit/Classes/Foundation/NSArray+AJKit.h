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
+ (BOOL (^)(NSArray *))ajIsEmpty;

/// 获取数组中对象
+ (id (^)(NSArray *array, NSUInteger index))ajObjectAtIndex;

/// json格式化
- (NSString *)ajJsonString;

@end

@interface NSMutableArray (AJKit)

/// 判断数组是否为空
+ (BOOL (^)(NSMutableArray *))ajIsEmpty;

/// 可变数组中添加对象
+ (void (^)(NSMutableArray *array, id object))ajAddObject;

@end

NS_ASSUME_NONNULL_END
