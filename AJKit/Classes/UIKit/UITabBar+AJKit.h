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
/// @param index tabbar索引
- (void)ajAddBadgeAtIndex:(NSInteger)index;

/// 删除小红点
/// @param index tabbar索引
- (void)ajRemoveBadgeAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
