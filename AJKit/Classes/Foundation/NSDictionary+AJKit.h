//
//  NSDictionary+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (AJKit)

/**
 判断字典是否为空
 */
+ (BOOL (^)(NSDictionary *))ajIsEmpty;

/**
 获取字典value，防止越界crash
 */
+ (id (^)(NSDictionary *dic, NSString *key))ajObjectForKey;

@end

@interface NSMutableDictionary (AJKit)

/**
 判断字典是否为空
 */
+ (BOOL (^)(NSMutableDictionary *))ajIsEmpty;

/**
 字典设置key value
 */
+ (void (^)(NSMutableDictionary *dic, NSString *key, id value))ajSetValueForKey;

/**
 字典设置key object
 */
+ (void (^)(NSMutableDictionary *dic, NSString *key, id object))ajSetObjectForKey;

@end

NS_ASSUME_NONNULL_END
