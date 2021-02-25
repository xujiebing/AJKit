//
//  NSBundle+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (AJKit)

/// 获取Bundle
/// @param bundleName bundle名
/// @param className 类名
+ (NSBundle *)ajBundleWithBundleName:(nonnull NSString *)bundleName
                           className:(nonnull NSString *)className;

@end

NS_ASSUME_NONNULL_END
