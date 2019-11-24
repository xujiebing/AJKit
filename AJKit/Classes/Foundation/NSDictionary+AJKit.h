//
//  NSDictionary+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (AJKit)

/// 判断字典是否为空
/// - Parameters: NSDictionary *
+ (BOOL (^)(NSDictionary *))ajIsEmpty;

/// 获取字典value，防止越界crash
/// - Parameters: NSDictionary *, NSString *
+ (id (^)(NSDictionary *dic, NSString *key))ajObjectForKey;

/// 判断是否包含某个key对应的对象
/// - Parameters: NSDictionary *, NSString *
+ (BOOL (^)(NSDictionary *dic, NSString *key))ajContainsObjectForKey;

@end

@interface NSMutableDictionary (AJKit)

/// 判断字典是否为空
/// - Parameters: NSMutableDictionary *
+ (BOOL (^)(NSMutableDictionary *))ajIsEmpty;

/// 字典设置key value
/// - Parameters: NSMutableDictionary *, NSString *, id
+ (void (^)(NSMutableDictionary *dic, NSString *key, id value))ajSetValueForKey;

/// 字典设置key object
/// - Parameters: NSMutableDictionary *, NSString *, id
+ (void (^)(NSMutableDictionary *dic, NSString *key, id object))ajSetObjectForKey;

@end

NS_ASSUME_NONNULL_END
