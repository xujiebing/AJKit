//
//  UITabBar+BWTExt.m
//  BWTon
//
//  Created by 小广 on 15/11/28.
//  Copyright © 2015年 BWTon. All rights reserved.
//

#import "UITabBar+BWTExt.h"

#define TabbarItemNums  3.0    //tabbar的数量 如果是5个设置为5

@implementation UITabBar (BWTExt)

//显示小红点
- (void)showBadgeOnItemIndex:(NSInteger)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 4.0f;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    NSInteger tabCount = 0;
    for (UIView *itemView in self.subviews) {
        if ([itemView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            tabCount ++ ;
        }
    }
    CGFloat percentX = (index + 0.6) / (tabCount);
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 8.0, 8.0);//圆形大小为8
    badgeView.clipsToBounds = YES;
    [self addSubview:badgeView];
}

//隐藏小红点
- (void)hideBadgeOnItemIndex:(NSInteger)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

//移除小红点
- (void)removeBadgeOnItemIndex:(NSInteger)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
