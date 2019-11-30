//
//  UITabBar+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (AJKit)

/// 添加小红点
/// @param NSInteger tabbar索引
- (void (^)(NSInteger index))ajAddBadgeAtIndex;

/// 删除小红点
/// @param NSInteger tabbar索引
- (void (^)(NSInteger index))ajRemoveBadgeAtIndex;

@end

NS_ASSUME_NONNULL_END
