//
//  UITabBarController+BWTExt.h
//  BWTKit
//
//  Created by gaoyang on 2018/6/19.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (BWTExt)

-(void)showBadgeValueOnItemIndex:(NSInteger)badge index:(NSInteger)index;

-(void)showBadgeOnItemIndex:(NSInteger)index;

-(void)hideBadgeOnItemIndex:(NSInteger)index;

@end
