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
+ (BOOL (^_Nonnull)(NSDictionary *))ajIsEmpty;

/// 此方法避免字典越界导致的crach
/// @param key 传入 key 不存在时，程序返回 nil
- (id)ajObjectForKey:(NSString *)key;

/// 是否包含某个key对象
/// @param key key
- (BOOL)ajContainsObjectForKey:(id)key;

@end

@interface NSMutableDictionary (AJKit)

/// 设置key value
/// @param value value
/// @param key key
- (void)ajSetValue:(id)value key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
