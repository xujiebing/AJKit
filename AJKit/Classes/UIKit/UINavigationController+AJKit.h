//
//  UINavigationController+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (AJKit)

/// 替换最后一个ViewController
/// @param viewController 新的ViewController
- (void)ajReplaceLastViewController:(UIViewController *)viewController;

/// 在最后一个ViewController上在增加一个ViewController
/// @param viewController 新的ViewController
- (void)ajAddViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
