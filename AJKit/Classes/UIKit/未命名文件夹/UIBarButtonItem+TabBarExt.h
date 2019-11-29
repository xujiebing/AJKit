//
//  UIBarButtonItem+TabBarExt.h
//  CustomTabbar
//
//  Created by ccc's MacBook Pro on 2017/8/7.
//  Copyright © 2017年 BWT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (TabBarExt)

+ (UIBarButtonItem *)itemWithTargat:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
