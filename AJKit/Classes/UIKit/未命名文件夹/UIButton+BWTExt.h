//
//  UIButton+BWTExt.h
//  BWTon 
//
//  Created by 小广 on 15/11/24.
//  Copyright © 2015年 BWTon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TimerBlock) (dispatch_source_t timer, NSInteger time);

typedef void (^TimerCancel) (dispatch_source_t timer);

@interface UIButton (BWTExt)


/**
 按钮禁用一段时间后 再启用,只返回timer

 @param time 时间单位s
 @param block 回调
 */
- (void)disableButton:(NSInteger)time block:(TimerCancel)block;


/**
 按钮禁用一段时间后 再启用,返回timer和秒数

 @param time 时间单位s
 @param block 回调
 */
- (void)disableButton:(NSInteger)time timeBlock:(TimerBlock)block;


/**
 设置button图片和标题相对位置

 @param padding 图片和标题垂直方向间距
 @param btn 待处理button
 */
- (void)centerVerticallyWithPadding:(float)padding button:(UIButton *)btn;

@end


@interface UIButton (BWTBadge)

@property (strong, nonatomic) UILabel *badge;

// Badge value to be display
@property (nonatomic) NSString *badgeValue;
// Badge background color
@property (nonatomic) UIColor *badgeBGColor;
// Badge text color
@property (nonatomic) UIColor *badgeTextColor;
// Badge font
@property (nonatomic) UIFont *badgeFont;
// Padding value for the badge
@property (nonatomic) CGFloat badgePadding;
// Minimum size badge to small
@property (nonatomic) CGFloat badgeMinSize;
// Values for offseting the badge over the BarButtonItem you picked
@property (nonatomic) CGFloat badgeOriginX;
@property (nonatomic) CGFloat badgeOriginY;
// In case of numbers, remove the badge when reaching zero
@property BOOL shouldHideBadgeAtZero;
// Badge has a bounce animation when value changes
@property BOOL shouldAnimateBadge;

@end
