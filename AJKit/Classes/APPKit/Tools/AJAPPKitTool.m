//
//  AJAPPKitTool.m
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import "AJAPPKitTool.h"

@implementation AJAPPKitTool

+ (NSBundle *)bundleWithBundleName:(NSString *)bundleName className:(NSString *)className {
    NSBundle *podBundle = [NSBundle bundleForClass:NSClassFromString(className)];
    NSURL *bundleURL = [podBundle URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
    return bundle;
}



@end
