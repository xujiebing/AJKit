//
//  NSObject+AJRuntime.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AJRuntime)

/**
 交换实例方法
 origMethod:原有的方法
 withMethod:替换的方法
 */
+ (BOOL (^)(SEL origMethod, SEL withMethod))ajSwizzleMethod;

/**
 交换类方法
 origClassMethod:原有的类方法
 withClassMethod:替换的类方法
 */
+ (BOOL (^)(SEL origClassMethod, SEL withClassMethod))ajSwizzleClassMethod;

/**
 交换方法
 origMethod:原有的方法
 withClassName:替换的类名
 withMethod:替换的方法
 */
+ (void (^)(SEL origMethod, NSString *withClassName, SEL withMethod))ajSwizzleMethodWithClassName;

/**
 交换方法
 origClass:原有的类
 origMethod:原有的方法
 withClass:替换的类
 withMethod:替换的方法
 */
+ (void (^)(Class origClass, SEL origMethod, Class withClass, SEL withMethod))ajSwizzleMethodWithClass;

@end

NS_ASSUME_NONNULL_END
