//
//  UIViewController+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import "UIViewController+AJKit.h"

@implementation UIViewController (AJKit)

+ (UIViewController *)ajCurrentViewController {
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

- (void)ajSetNavigationBarTransparent {
    UIImage *image = UIColor.clearColor.ajImage;
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.navigationController.navigationBar setTranslucent:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

@end
