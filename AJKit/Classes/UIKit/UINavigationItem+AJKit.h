//
//  UINavigationItem+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AJNavigationItemCallback)(void);

@interface UINavigationItem (AJKit)

/// 设置导航栏左侧按钮
/// @param image 按钮图片
/// @param callback 回调
- (void)ajAddLeftButtonWithImage:(UIImage *)image callback:(AJNavigationItemCallback)callback;

/// 设置导航栏左侧按钮
/// @param title title
/// @param callback 回调
- (void)ajAddLeftButtonWithTitle:(NSString *)title callback:(AJNavigationItemCallback)callback;

/// 移除左侧返回按钮
- (void)ajRemoveLeftButton;

/// 设置导航栏右侧按钮
/// @param image 按钮图片
/// @param callback 回调
- (void)ajAddRightButtonWithImage:(UIImage *)image callback:(AJNavigationItemCallback)callback;

/// 设置导航栏右侧按钮
/// @param title title
/// @param callback 回调
- (void)ajAddRightButtonWithTitle:(NSString *)title callback:(AJNavigationItemCallback)callback;

/// 移除右侧返回按钮
- (void)ajRemoveRightButton;

/// 小菊花开始旋转啦
- (void)ajStartAnimating;

/// 小菊花停止旋转
- (void)ajStopAnimating;

@end

@interface AJTitleStackView : UIStackView

@end

NS_ASSUME_NONNULL_END
