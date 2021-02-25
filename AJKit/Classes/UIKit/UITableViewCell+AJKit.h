//
//  UITableViewCell+AJKit.h
//  AJKit
//
//  Created by 山鹰 on 2021/2/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (AJKit)

/// 设置cell分割线，分割线高度默认为1
/// @param tableView tableView
/// @param indexPath indexPath
/// @param left 距离左边的距离
/// @param color color
- (void)ajAddCellBottomLineWithTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath
                                    left:(CGFloat)left
                               lineColor:(UIColor *)color;

/// 设置cell分割线,可自定义分割线高度
/// @param tableView tableView
/// @param indexPath indexPath
/// @param left 距离左边距离
/// @param heigh 分割线高度
/// @param color color
- (void)ajAddCellBottomLineWithTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath
                                    left:(CGFloat)left
                                   heigh:(CGFloat)heigh
                               lineColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
