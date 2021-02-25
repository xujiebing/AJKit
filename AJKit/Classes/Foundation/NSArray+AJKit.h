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
+ (BOOL (^)(NSArray * _Nonnull))ajIsEmpty;

/// 根据数组下标获取对象值，此方法避免数组越界导致的crach
/// @param index 传入 index 大于数组的 count 时，程序返回 nil
- (id)ajObjectAtIndex:(NSUInteger)index;

/// 获取数组中对象的索引
/// @param anObject 对象
- (NSUInteger)ajIndexOfObject:(id)anObject;

@end

@interface NSMutableArray (AJKit)

/// 可变数组中添加对象
/// @param anObject 对象
- (void)ajInsertOfObject:(id)anObject;

/// 移除数组中第一个对象，如果数组为空，则忽略此操作
- (void)ajRemoveFirstObject;

@end


NS_ASSUME_NONNULL_END
