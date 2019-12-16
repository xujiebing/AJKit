//
//  AJCacheTool.h
//  AJKit
//
//  Created by 徐结兵 on 2019/12/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJCacheTool : NSObject

/**
 缓存存储, 公共存储区

 @param value the value
 @param key the key
 */
+ (void)setValue:(id _Nonnull)value forKey:(NSString *_Nonnull)key;


/**
 获取缓存值, 公共存储区

 @param key the key
 @return the value
 */
+ (id _Nonnull)objectForKey:(NSString *_Nonnull)key;



/**
 根据key清除对应的值, 公共存储区

 @param key the key
 */
+ (void)removeObjectWithKey:(NSString *_Nonnull)key;


/**
 缓存存储
 
 @param value the value
 @param key the key
 @param moduleName 模块名
 */
+ (void)setValue:(id _Nonnull)value
          forKey:(NSString *_Nonnull)key
      moduleName:(NSString *_Nullable)moduleName;


/**
 获取缓存值

 @param key the key
 @param moduleName 模块名
 @return value
 */
+ (id _Nonnull)objectForKey:(NSString *_Nonnull)key
                 moduleName:(NSString *_Nullable)moduleName;


/**
 根据key清除对应的值
 
 @param key the key
 @param moduleName 模块名
 */
+ (void)removeObjectWithKey:(NSString *_Nonnull)key
                 moduleName:(NSString *_Nullable)moduleName;

/**
 根据模块名清除对应的值

 @param moduleName 模块名
 */
+ (void)removeObjectWithModuleName:(NSString *_Nullable)moduleName;

@end

NS_ASSUME_NONNULL_END
