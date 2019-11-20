//
//  UIViewController+DBKit.m
//  DBKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import "UIViewController+DBKit.h"

@implementation UIViewController (DBKit)

+ (UIViewController *)currentViewController {
    UIViewController *viewController = nil;
    
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if([vc isKindOfClass:[UITabBarController class]]) {
        viewController = ((UITabBarController *)vc).selectedViewController;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        viewController = ((UINavigationController *)vc).visibleViewController;
    } else {
        viewController = vc;
    }
    if (viewController.presentedViewController) {
        viewController = viewController.presentedViewController;
    }
    return viewController;
}

@end
