//
//  UINavigationBar+BWTExt.m
//  BWTKit 修复iOS11导航栏按钮偏移
//
//  Created by ccc's MacBook Pro on 2017/11/15.
//

#import "UINavigationBar+BWTExt.h"
#import "UIViewController+BWTExt.h"
#import <BWTBaseFramework/BWTKit.h>

@implementation UINavigationBar (BWTExt)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ //!OCLINT
        [self swizzleMethod:@selector(layoutSubviews) withMethod:@selector(bwtext_layoutSubviews)];
    });
}

- (void)bwtext_layoutSubviews {
    [self bwtext_layoutSubviews];
    
    if (IOS11 && [[NSProcessInfo processInfo] operatingSystemVersion].majorVersion < 13) {
        self.layoutMargins = UIEdgeInsetsZero;
        CGFloat space = -8;
        for (UIView *subview in self.subviews) {
            if ([NSStringFromClass(subview.class) containsString:@"ContentView"]) {
                subview.layoutMargins = UIEdgeInsetsMake(0, space, 0, -space);//可修正iOS11之后的偏移
                break;
            }
        }
    }
}


@end
