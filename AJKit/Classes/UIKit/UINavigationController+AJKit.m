//
//  UINavigationController+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "UINavigationController+AJKit.h"

@implementation UINavigationController (AJKit)

- (void)ajReplaceLastViewController:(UIViewController *)viewController {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.viewControllers];
    [array removeLastObject];
    [array addObject:viewController];
    self.viewControllers = array;
}

- (void)ajAddViewController:(UIViewController *)viewController {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.viewControllers];
    [array addObject:viewController];
    [viewController addChildViewController:viewController];
    self.viewControllers = array;
}


@end
