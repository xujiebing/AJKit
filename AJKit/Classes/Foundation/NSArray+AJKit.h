//
//  NSArray+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (AJKit)

/// 判断对象是否为空
/// @return BOOL 是否为空  YES-不为空 NO-为空
- (BOOL)ajNonEmpty;

/// 获取数组中对象
/// @param NSUInteger 索引
/// @return NSArray*数组对象
- (id (^)(NSUInteger index))ajObjectAtIndex;

@end

@interface NSMutableArray (AJKit)

/// 可变数组中添加对象
/// @param id 对象
/// @return NSMutableArray* 数组对象
- (void (^)(id object))ajAddObject;

@end

NS_ASSUME_NONNULL_END
