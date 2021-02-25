//
//  NSBundle+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "NSBundle+AJKit.h"

@implementation NSBundle (AJKit)

- (BOOL)ajMethodUndefinedCrash {
    return NO;
}

+ (NSBundle *)ajBundleWithBundleName:(nonnull NSString *)bundleName
                           className:(nonnull NSString *)className {
    NSBundle *podBundle = [NSBundle bundleForClass:NSClassFromString(className)];
    NSURL *bundleURL = [podBundle URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
    return bundle;
}

@end
