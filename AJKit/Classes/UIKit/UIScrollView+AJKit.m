//
//  UIScrollView+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "UIScrollView+AJKit.h"

@implementation UIScrollView (AJKit)

- (void (^)(BOOL))ajScrollToTopAnimated {
    kAJWeakSelf
    void (^block)(BOOL) = ^(BOOL animated){
        CGPoint off = ajSelf.contentOffset;
        off.y = 0 - ajSelf.contentInset.top;
        [ajSelf setContentOffset:off animated:animated];
    };
    return block;
}

- (void (^)(BOOL))ajScrollToBottomAnimated {
    kAJWeakSelf
    void (^block)(BOOL) = ^(BOOL animated){
        CGPoint off = ajSelf.contentOffset;
        off.y = ajSelf.contentSize.height - ajSelf.bounds.size.height + ajSelf.contentInset.bottom;
        [ajSelf setContentOffset:off animated:animated];
    };
    return block;
}

- (void (^)(BOOL))ajScrollToLeftAnimated {
    kAJWeakSelf
    void (^block)(BOOL) = ^(BOOL animated){
        CGPoint off = ajSelf.contentOffset;
        off.x = 0 - ajSelf.contentInset.left;
        [ajSelf setContentOffset:off animated:animated];
    };
    return block;
}

- (void (^)(BOOL))ajScrollToRightAnimated {
    kAJWeakSelf
    void (^block)(BOOL) = ^(BOOL animated){
        CGPoint off = ajSelf.contentOffset;
        off.x = ajSelf.contentSize.width - ajSelf.bounds.size.width + ajSelf.contentInset.right;
        [ajSelf setContentOffset:off animated:animated];
    };
    return block;
}

@end
