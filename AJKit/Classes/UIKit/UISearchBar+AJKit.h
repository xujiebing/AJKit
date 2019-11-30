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
/// @param UIColor* 颜色
- (void (^)(UIColor *color))ajSetTextFiledBackgroundColor;

/// 设置输入框字体颜色
/// @param UIColor* 颜色
- (void (^)(UIColor *color))ajSetTextFiledTextColor;

/// 设置输入框字体大小
/// @param CGFloat 字体大小
- (void (^)(CGFloat font))ajSetTextFieldTextFont;

/// 设置输入框光标颜色
/// @param UIColor* 颜色
- (void (^)(UIColor *color))ajSetTextFieldFocusColor;

/// 设置searchBar背景颜色
/// @param UIColor* 颜色
- (void (^)(UIColor *color))ajSetBarBackgroundColor;

@end

NS_ASSUME_NONNULL_END
