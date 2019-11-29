//
//  UIControl+TouchEffect.h
//
//  Created by admin on 16/12/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (TouchEffect)

/**
 显示点击透明度变化效果
 */
@property(nonatomic,assign) BOOL showTouchEffect;

/**
 防止重复点击时间间隔
 */
@property(nonatomic,assign) NSTimeInterval acceptEventInterval;

/**
 设置按钮扩大响应区域的范围
 @param size 扩大的宽和高
 */
- (void)setEnlargeEdge:(CGFloat)size;

/**
 详细设置按钮扩大响应区域的范围
 
 @param top 按钮上方扩展的范围
 @param right 按钮右方扩展的范围
 @param bottom 按钮下方扩展的范围
 @param left 按钮左方扩展的范围
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                       bottom:(CGFloat)bottom
                         left:(CGFloat)left;


@end
