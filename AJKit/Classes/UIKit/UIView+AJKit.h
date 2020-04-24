//
//  UIView+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (AJKit)

@property (nonatomic, assign, readwrite) CGFloat ajX;
@property (nonatomic, assign, readwrite) CGFloat ajY;
@property (nonatomic, assign, readwrite) CGFloat ajCenterX;
@property (nonatomic, assign, readwrite) CGFloat ajCenterY;
@property (nonatomic, assign, readwrite) CGFloat ajWidth;
@property (nonatomic, assign, readwrite) CGFloat ajHeight;
@property (nonatomic, assign, readwrite) CGSize ajSize;
@property (nonatomic, assign, readwrite) CGPoint ajOrigin;

/// 添加圆角
/// @param radius 半径
- (void)ajAddCorners:(CGFloat)radius;

/// @param radius 半径
/// @param rectCorners rectCorners
- (void)ajAddRectCorners:(CGFloat)radius rectCorners:(UIRectCorner)rectCorners;

/// 添加边框
/// @param width 边框宽度
/// @param color 颜色
- (void)ajAddBorder:(CGFloat)width rectCorners:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
