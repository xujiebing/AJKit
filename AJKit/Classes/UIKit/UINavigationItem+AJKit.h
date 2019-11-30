//
//  UINavigationItem+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationItem (AJKit)

/// 设置导航栏返回按钮
/// @param NSString* 按钮title
- (void (^)(NSString *title))ajAddBackButtonWithTitle;

/// 设置导航栏左侧按钮
/// @param UIImage* 按钮图片
/// @param id target
/// @param SEL selector
- (void (^)(UIImage *image, id target, SEL selector))ajAddLeftButtonWithImage;

/// 设置导航栏左侧按钮
/// @param NSString* 按钮title
/// @param id target
/// @param SEL selector
- (void (^)(NSString *title, id target, SEL selector))ajAddLeftButtonWithTitle;

/// 移除左侧返回按钮
- (void)ajRemoveLeftButton;

/// 设置导航栏右侧按钮
/// @param UIImage* 按钮图片
/// @param id target
/// @param SEL selector
- (void (^)(UIImage *image, id target, SEL selector))ajAddRightButtonWithImage;

/// 设置导航栏右侧按钮
/// @param NSString* 按钮title
/// @param id target
/// @param SEL selector
- (void (^)(NSString *title, id target, SEL selector))ajAddRightButtonWithTitle;

/// 移除右侧返回按钮
- (void)ajRemoveRightButton;

/// 小菊花开始旋转啦
/// @param NSString* 自定义title
- (void (^)(NSString *title))ajStartAnimatingWithTitle;

/// 小菊花开始旋转啦
- (void)ajStartAnimating;

/// 小菊花停止旋转
- (void)ajStopAnimating;

@end

NS_ASSUME_NONNULL_END
