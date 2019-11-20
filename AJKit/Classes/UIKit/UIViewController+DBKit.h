//
//  UIViewController+DBKit.h
//  DBKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (DBKit)

/// 获取当前viewController
+ (UIViewController *)currentViewController;

@end

NS_ASSUME_NONNULL_END
