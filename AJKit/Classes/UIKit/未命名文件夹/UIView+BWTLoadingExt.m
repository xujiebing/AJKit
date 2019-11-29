//
//  UIView+BWTLoadingExt.m
//  BWTKit
//
//  Created by ccc's MacBook Pro on 2018/7/4.
//

#import "UIView+BWTLoadingExt.h"
#import <objc/runtime.h>
#import "BWTLoadingView.h"

@interface UIView ()

@property (nonatomic, strong) BWTLoadingView *loadingView;

@end

NSString const *UIView_BWTLoadingViewKey    = @"UIView_BWTLoadingViewKey";

@implementation UIView (BWTLoadingExt)

/**
 开始加载中动画
 */
- (void)startLoading {
    [self addSubview:self.loadingView];
    [self bringSubviewToFront:self.loadingView];
}

/**
 停止加载中动画
 */
- (void)stopLoading {
    for (UIView *itemView in self.subviews) {
        if ([itemView isKindOfClass:[BWTLoadingView class]]) {
            [itemView removeFromSuperview];
        }
    }
}

- (BWTLoadingView *)loadingView {
    BWTLoadingView *loadingView = objc_getAssociatedObject(self, &UIView_BWTLoadingViewKey);
    if (!loadingView) {
        loadingView = [[BWTLoadingView alloc] initWithFrame:self.bounds];
    }
    return loadingView;
}

@end
