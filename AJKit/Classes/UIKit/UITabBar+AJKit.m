//
//  UITabBar+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "UITabBar+AJKit.h"

@implementation UITabBar (AJKit)

- (void)ajAddBadgeAtIndex:(NSInteger)index {
    //移除之前的小红点
    [self ajRemoveBadgeAtIndex:index];
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 4.0f;
    badgeView.backgroundColor = UIColor.redColor;
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
    badgeView.frame = CGRectMake(x, y, 8.0, 8.0);
    badgeView.clipsToBounds = YES;
    [self addSubview:badgeView];
}

- (void)ajRemoveBadgeAtIndex:(NSInteger)index {
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
