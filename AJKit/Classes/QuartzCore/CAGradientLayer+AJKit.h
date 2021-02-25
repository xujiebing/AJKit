//
//  CAGradientLayer+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2020/8/6.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAGradientLayer (AJKit)

/// 水平方向添加渐变色
/// @param view 对象
/// @param startColor 开始颜色
/// @param endColor 结束颜色
+ (void)ajHorizontalGradientLayer:(UIView *)view
                       startColor:(UIColor *)startColor
                         endColor:(UIColor *)endColor;

@end

NS_ASSUME_NONNULL_END
