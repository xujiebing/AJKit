//
//  UITableViewCell+AJKit.m
//  AJKit
//
//  Created by 山鹰 on 2021/2/25.
//

#import "UITableViewCell+AJKit.h"

@implementation UITableViewCell (AJKit)


- (void)ajAddCellBottomLineWithTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath
                                    left:(CGFloat)left
                               lineColor:(UIColor *)color {
    [self ajAddCellBottomLineWithTableView:tableView indexPath:indexPath left:left heigh:1 lineColor:color];
}

- (void)ajAddCellBottomLineWithTableView:(UITableView *)tableView
                               indexPath:(NSIndexPath *)indexPath
                                    left:(CGFloat)left
                                   heigh:(CGFloat)heigh
                               lineColor:(UIColor *)color {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (!tableView) {
        AJLog(@"**********  tableView参数未传  **********");
        return;
    }
    if (!indexPath) {
        AJLog(@"**********  indexPath参数未传  **********");
        return;
    }
    if (!left) {
        left = 0;
    }
    if (!heigh) {
        heigh = 1;
    }
    
    CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(left, rect.size.height - heigh, UIScreen.mainScreen.bounds.size.width, heigh)];
    UIColor *lineColor = color;
    if (!lineColor) {
        lineColor = UIColor.lightGrayColor;
    }
    lineView.backgroundColor = lineColor;
    
    [self addSubview:lineView];
}


@end
