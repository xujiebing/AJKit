//
//  NSUserDefaults+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2020/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (AJKit)

/// 缓存存储, 公共存储区
/// @param value value
/// @param key key
+ (void)ajSetValue:(id _Nonnull)value forKey:(NSString *_Nonnull)key;

/// 获取缓存值, 公共存储区
/// @param key key
+ (id _Nonnull)ajObjectForKey:(NSString *_Nonnull)key;

/// 根据key清除对应的值, 公共存储区
/// @param key key
+ (void)ajRemoveObjectForKey:(NSString *_Nonnull)key;

/// 缓存存储
/// @param value value
/// @param key key
/// @param moduleName 模块名
+ (void)ajSetValue:(id _Nonnull)value
            forKey:(NSString *_Nonnull)key
        moduleName:(NSString *_Nullable)moduleName;

/// 获取缓存值
/// @param key key
/// @param moduleName 模块名
+ (id _Nonnull)ajObjectForKey:(NSString *_Nonnull)key
                   moduleName:(NSString *_Nullable)moduleName;

/// 根据key清除对应的值
/// @param key key
/// @param moduleName 模块名
+ (void)ajRemoveObjectForKey:(NSString *_Nonnull)key
                  moduleName:(NSString *_Nullable)moduleName;

/// 根据模块名清除对应的值
/// @param moduleName 模块名
+ (void)ajRemoveObjectWithModuleName:(NSString *_Nullable)moduleName;

@end

NS_ASSUME_NONNULL_END
