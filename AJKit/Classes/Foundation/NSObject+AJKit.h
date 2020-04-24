//
//  NSObject+AJKit.h
//  Base64
//
//  Created by 徐结兵 on 2020/4/13.
//

#import <Foundation/Foundation.h>

#define AJ_TRY_BODY(__target) \
@try {\
{__target}\
}\
@catch (NSException *exception) {\
 NSLog(@"exception ===== %@", [exception description]);\
}\
@finally {\
\
}

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AJKit)

/// 获取对象名
- (NSString *)ajClassName;

/// 交换方法
/// @param origMethod 原有的方法
/// @param withMethod 替换的方法
+ (BOOL)ajSwizzleMethod:(SEL)origMethod withMethod:(SEL)withMethod;

/// 交换类方法
/// @param origClassMethod 原有的类方法
/// @param withClassMethod 替换的类方法
+ (BOOL)ajSwizzleClassMethod:(SEL)origClassMethod withClassMethod:(SEL)withClassMethod;

/// 交换方法
/// @param origMethod 原有的方法
/// @param withClassName 替换的类名
/// @param withMethod 替换的方法
+ (void)ajSwizzleMethod:(SEL)origMethod withClassName:(NSString *)withClassName withMethod:(SEL)withMethod;

/// 交换方法
/// @param origClass 原有的类
/// @param origMethod 原有的方法
/// @param withClass 替换的类
/// @param withMethod 替换的方法
+ (void)ajSwizzleMethod:(Class)origClass origMethod:(SEL)origMethod withClass:(Class)withClass withMethod:(SEL)withMethod;

@end

NS_ASSUME_NONNULL_END
