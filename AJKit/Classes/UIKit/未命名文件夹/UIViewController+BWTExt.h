//
//  UIViewController+BWTExt.h
//  MSX
//
//  Created by HuHao on 1/11/16.
//  Copyright © 2016 BWTon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BWTExt)


/**
 获取当前页面VC

 @return 当前页面vc
 */
+ (UIViewController *)lastViewController;


/**
 设置vc导航栏透明
 */
- (void)setNavigationBarTransparent;

@end
