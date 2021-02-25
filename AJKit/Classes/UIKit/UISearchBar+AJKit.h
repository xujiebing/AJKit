//
//  UISearchBar+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISearchBar (AJKit)

/// 设置输入框背景颜色
/// @param color 颜色
- (void)ajSetTextFiledBackgroundColor:(UIColor *)color;

/// 设置输入框字体颜色
/// @param color 颜色
- (void)ajSetTextFiledTextColor:(UIColor *)color;

/// 设置输入框字体大小
/// @param font 字体大小
- (void)ajSetTextFieldTextFont:(CGFloat)font;

/// 设置输入框光标颜色
/// @param color 颜色
- (void)ajSetTextFieldFocusColor:(UIColor *)color;

/// 设置searchBar背景颜色
/// @param color 颜色
- (void)ajSetBarBackgroundColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
