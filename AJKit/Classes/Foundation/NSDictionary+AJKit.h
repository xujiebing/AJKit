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
/// @param NSDictionary* 字典对象
/// @return BOOL 是否为空
+ (BOOL (^)(NSDictionary *ajSelf))ajIsEmpty;

/// 获取字典value，防止越界crash
/// @param NSString* 字典key
/// @return id 对象
- (id (^)(NSString *key))ajObjectForKey;

/// 判断是否包含某个key对应的对象
/// @param NSString* 字典key
/// @return BOOL 是否包含
- (BOOL (^)(NSString *key))ajContainsObjectForKey;

@end

@interface NSMutableDictionary (AJKit)

/// 判断字典是否为空
/// @param NSMutableDictionary* 字典对象
/// @return BOOL 是否为空
+ (BOOL (^)(NSMutableDictionary *ajSelf))ajIsEmpty;

/// 字典设置key value
/// @param NSString* 字符串
/// @param id 对象
- (void (^)(NSString *key, id value))ajSetValueForKey;

@end

NS_ASSUME_NONNULL_END
