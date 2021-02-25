//
//  CALayer+AJKit.h
//  AJAD
//
//  Created by 徐结兵 on 2020/4/15.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (AJKit)

/// 创建一个叉叉 "x" 号图层
/// @param size 尺寸
/// @param color 颜色
/// @param strokeWidth 线条粗细
+ (CAShapeLayer *)ajCreateCloseLayer:(CGSize)size
                                color:(UIColor *)color
                          strokeWidth:(CGFloat)strokeWidth;

/// 创建一个 "+" or "-" 号图层
/// @param size 尺寸
/// @param color 颜色
/// @param strokeWidth 线条粗细
/// @param isAdd 是否"+"号
+ (CAShapeLayer *)ajCreatePlusLayer:(CGSize)size
                               color:(UIColor *)color
                         strokeWidth:(CGFloat)strokeWidth
                               isAdd:(BOOL)isAdd;

@end

NS_ASSUME_NONNULL_END
