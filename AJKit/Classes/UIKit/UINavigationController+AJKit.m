//
//  UINavigationController+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "UINavigationController+AJKit.h"

@implementation UINavigationController (AJKit)

- (void (^)(UIViewController * _Nonnull))ajReplaceLastViewController {
    kAJWeakSelf
    void (^block)(UIViewController *) = ^(UIViewController *newVC){
        NSMutableArray *array = [NSMutableArray arrayWithArray:ajSelf.viewControllers];
        [array removeLastObject];
        [array addObject:newVC];
        ajSelf.viewControllers = array;
    };
    return block;
}

- (void (^)(UIViewController * _Nonnull))ajAddViewController {
    kAJWeakSelf
    void (^block)(UIViewController *) = ^(UIViewController *newVC){
        NSMutableArray *array = [NSMutableArray arrayWithArray:ajSelf.viewControllers];
        [array addObject:newVC];
        [newVC addChildViewController:newVC];
        ajSelf.viewControllers = array;
    };
    return block;
}


@end
