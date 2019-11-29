//
//  UIViewController+BWTTableView.m
//  BWTHome
//
//  Created by gaoyang on 2019/4/13.
//

#import "UIViewController+BWTTableView.h"
#import <BWTBaseFramework/NSObject+MethodSwizzlingCategory.h>

@implementation UIViewController (BWTTableView)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(gy_useTableView) withMethod:@selector(bwttable_useTableView)];
        [self swizzleMethod:@selector(gy_useRefreshHeader) withMethod:@selector(bwttable_useRefreshHeader)];
        [self swizzleMethod:@selector(gy_useLoadMoreFooter) withMethod:@selector(bwttable_useLoadMoreFooter)];
        [self swizzleMethod:@selector(gy_useAutoRefreshHeader) withMethod:@selector(bwttable_useAutoRefreshHeader)];
        [self swizzleMethod:@selector(gy_useAutoRestOffset) withMethod:@selector(bwttable_useAutoRestOffset)];
        [self swizzleMethod:@selector(gy_getTableViewFrame) withMethod:@selector(bwttable_getTableViewFrame)];
        [self swizzleMethod:@selector(gy_getTableViewParent) withMethod:@selector(bwttable_getTableViewParent)];
        [self swizzleMethod:@selector(gy_getRefreshHeader) withMethod:@selector(bwttable_getRefreshHeader)];
        [self swizzleMethod:@selector(gy_getRefreshFooter) withMethod:@selector(bwttable_getRefreshFooter)];
    });
}

- (BOOL)bwttable_useTableView {
    return self.bwt_useTableView;
}

- (BOOL)bwttable_useRefreshHeader {
    return self.bwt_useRefreshHeader;
}

- (BOOL)bwttable_useLoadMoreFooter {
    return self.bwt_useLoadMoreFooter;
}

- (BOOL)bwttable_useAutoRefreshHeader {
    return self.bwt_useAutoRefreshHeader;
}

- (BOOL)bwttable_useAutoRestOffset {
    return self.bwt_useAutoRestOffset;
}

- (CGRect)bwttable_getTableViewFrame {
    return self.bwt_getTableViewFrame;
}

- (UIView *)bwttable_getTableViewParent {
    return self.bwt_getTableViewParent;
}

- (MJRefreshHeader *)bwttable_getRefreshHeader {
    return self.bwt_getRefreshHeader;
}

- (MJRefreshFooter *)bwttable_getRefreshFooter {
    return self.bwt_getRefreshFooter;
}

/** 设置是否使用该控件 默认false;请在引入头文件后重写该方法返回true **/
- (BOOL)bwt_useTableView {
    return NO;
}

/** 同 @property isShowHeader */
- (BOOL)bwt_useRefreshHeader {
    return YES;
}

/** 同 @property isShowFooter */
- (BOOL)bwt_useLoadMoreFooter {
    return NO;
}

/** 同 @property autoRefreshHeader */
- (BOOL)bwt_useAutoRefreshHeader {
    return NO;
}

/** 同 @property autoRestOffset */
- (BOOL)bwt_useAutoRestOffset {
    return NO;
}

- (CGRect)bwt_getTableViewFrame {
    return self.view.bounds;
}

- (UIView *)bwt_getTableViewParent {
    return self.view;
}

- (MJRefreshHeader *)bwt_getRefreshHeader {
    return nil;
}

- (MJRefreshFooter *)bwt_getRefreshFooter {
    return nil;
}

@end
