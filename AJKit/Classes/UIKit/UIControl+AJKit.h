//
//  UIControl+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2020/7/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (AJKit)

/// 显示点击透明度变化效果
@property(nonatomic,assign) BOOL ajShowTouchEffect;

/// 防止重复点击时间间隔
@property(nonatomic,assign) NSTimeInterval ajAcceptEventInterval;

/// 设置按钮扩大响应区域的范围
/// @param size 扩大的宽和高
- (void)ajSetEnlargeEdge:(CGFloat)size;

/// 详细设置按钮扩大响应区域的范围
/// @param top 按钮上方扩展的范围
/// @param right 按钮右方扩展的范围
/// @param bottom 按钮下方扩展的范围
/// @param left 按钮左方扩展的范围
- (void)ajSetEnlargeEdgeWithTop:(CGFloat)top
                          right:(CGFloat)right
                         bottom:(CGFloat)bottom
                           left:(CGFloat)left;

@end

NS_ASSUME_NONNULL_END
