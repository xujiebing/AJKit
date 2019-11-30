//
//  NSBundle+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "NSBundle+AJKit.h"

@implementation NSBundle (AJKit)

+ (NSString *)ajAppBundleName {
    return [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleName"];
}

+ (NSString *)ajAppBundleID {
    return [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

+ (NSString *)ajAppVersion {
    return [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)ajAppBuildVersion {
    return [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleVersion"];
}

@end
