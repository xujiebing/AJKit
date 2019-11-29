//
//  UIViewController+BWTExt.m
//  BWTSH
//
//  Created by HuHao on 1/11/16.
//  Copyright © 2016 BWTon. All rights reserved.
//

#import "UIViewController+BWTExt.h"
#import "NSObject+BWTExt.h"
#import "BWTBaseUI.h"

@implementation UIViewController (BWTExt)

+ (UIViewController *)lastViewController {
    UIViewController *viewController = nil;

    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;

    if([vc isKindOfClass:[UITabBarController class]]) {
        viewController = ((UITabBarController *)vc).selectedViewController;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        viewController = ((UINavigationController *)vc).visibleViewController;
    } else {
        viewController = vc;
    }

    // 对BWTRootNavigationController特殊处理
    if ([viewController isKindOfClass:NSClassFromString(@"BWTRootNavigationController")]) {
        UIViewController *tempVC = [viewController valueForKeyPath:@"bwt_visibleViewController"];
        if (tempVC) {
            viewController = tempVC;
        }
    } else if ([viewController isKindOfClass:NSClassFromString(@"BWTContainerController")]) {
        UIViewController *tempVC = [viewController valueForKeyPath:@"contentViewController"];
        if (tempVC) {
            viewController = tempVC;
        }
    }
    if ([[viewController className] hasSuffix:@"DrawerController"]) {
        NSInteger openSide = [[viewController valueForKeyPath:@"openSide"] integerValue];
        if (openSide == 0) {
            UIViewController *tempVC = [viewController valueForKeyPath:@"centerViewController"];
            if (tempVC) {
                viewController = tempVC;
            }
        } else if (openSide == 1) {
            UIViewController *tempVC = [viewController valueForKeyPath:@"leftDrawerViewController"];
            if (tempVC) {
                viewController = tempVC;
            }
        } else if (openSide == 2) {
            UIViewController *tempVC = [viewController valueForKeyPath:@"rightDrawerViewController"];
            if (tempVC) {
                viewController = tempVC;
            }
        }
    }

    return viewController;
}


- (void)setNavigationBarTransparent {
    UIImage *image = BWTBaseImageName(@"nav_alphy");
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.navigationController.navigationBar setTranslucent:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

@end
