//
//  NSBundle+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (AJKit)

+ (NSString *)ajAppBundleName;

+ (NSString *)ajAppBundleID;

+ (NSString *)ajAppVersion;

+ (NSString *)ajAppBuildVersion;

@end

NS_ASSUME_NONNULL_END
