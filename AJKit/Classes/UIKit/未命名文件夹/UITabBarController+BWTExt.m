//
//  UITabBarController+BWTExt.m
//  BWTKit
//
//  Created by gaoyang on 2018/6/19.
//

#import "UITabBarController+BWTExt.h"

@implementation UITabBarController (BWTExt)

-(void)showBadgeValueOnItemIndex:(NSInteger)badge index:(NSInteger)index{
    NSLog(@"child override this function");
}

-(void)showBadgeOnItemIndex:(NSInteger)index{
    NSLog(@"child override this function");
}

-(void)hideBadgeOnItemIndex:(NSInteger)index{
    NSLog(@"child override this function");
}

@end
