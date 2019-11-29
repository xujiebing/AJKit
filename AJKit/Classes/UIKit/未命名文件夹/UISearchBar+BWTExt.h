//
//  UISearchBar+BWTExt.h
//  BWTon
//
//  Created by HuHao on 15/10/2.
//  Copyright © 2015年 BWTon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (BWTExt)

/**
 *  当 UISearchBar 被resignFirstResponsder 的时候，取消按钮也会失焦
 *  所以写这个方法再调用一次，使取消按钮再被得焦
 */
- (void)regetCancelButtonFocus;

/**
 设置输入框背景颜色

 @param color color
 */
- (void)textFileBackground:(UIColor *)color;

/**
 设置输入框字体颜色

 @param color COLOR
 */
- (void)setTextFieldTextcolor:(UIColor *)color;

/**
 设置输入框字体大小

 @param font font
 */
- (void)setTextFieldTextFont:(CGFloat)font;

/**
 设置输入框光标颜色

 @param color color
 */
- (void)setTextFieldFocusColor:(UIColor *)color;


/**
 设置searchBar背景颜色

 @param backgroundColor color
 */
- (void)setBarBackgroundColor:(UIColor *)backgroundColor;

@end
