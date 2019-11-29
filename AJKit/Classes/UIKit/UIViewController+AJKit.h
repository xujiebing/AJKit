//
//  UIViewController+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AJKit)

/// 获取当前viewController
/// @return UIViewController* 当前控制器
+ (UIViewController *)ajCurrentViewController;

@end

NS_ASSUME_NONNULL_END
