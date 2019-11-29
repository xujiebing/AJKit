//
//  BWTRACTableViewController.m
//  BWTBaseFramework
//
//  Created by gaoyang on 2019/7/3.
//

#import "BWTRACTableViewPage.h"
#import <BWTBaseFramework/BWTKit.h>
#import <BWTBaseUI/BWTBaseUI.h>

@interface BWTRACTableViewPage ()

@property (nonatomic, strong) UIView *emptyView;

@end

@implementation BWTRACTableViewPage

- (BOOL)bwt_useTableView {
    return YES;
}

- (BOOL)bwt_useLoadMoreFooter {
    return YES;
}

- (void)headerRefresh:(GYTableBaseView *)tableView {
    RACSignal *requestSignal = [self.tableViewModel start:YES];
    kRACWeakSelf
    [requestSignal subscribeNext:^(NSArray *dataSource) {
        kRACStrongSelf
        [self configTableViewSource:dataSource lastSectionNode:nil];
        BOOL hasData = dataSource && dataSource.count > 0;
        [self.tableView headerEndRefresh:hasData];
        [self p_checkEmptyView:hasData];
    } error:^(NSError * _Nullable error) {
        kRACStrongSelf
        [self.tableView headerEndRefresh:NO];
        [self p_checkEmptyView:NO];
        [self handlerError:error];
    }];
}

- (void)footerLoadMore:(GYTableBaseView *)tableView lastSectionNode:(SectionNode *)lastSectionNode {
    RACSignal *requestSignal = [self.tableViewModel start:NO];
    kRACWeakSelf
    [requestSignal subscribeNext:^(NSArray *dataSource) {
        kRACStrongSelf
        [self configTableViewSource:dataSource lastSectionNode:lastSectionNode];
        [self.tableView footerEndLoadMore:dataSource && dataSource.count > 0];
    } error:^(NSError * _Nullable error) {
        kRACStrongSelf
        [self.tableView footerEndLoadMore:NO];
        [self handlerError:error];
    }];
}

- (void)configTableViewSource:(NSArray *)dataSource lastSectionNode:(SectionNode *)lastSectionNode {
    //子类重写
}

- (void)handlerError:(NSError *)error {
    //子类重写
}

- (void)p_checkEmptyView:(BOOL)hasData {
    if (self.hideEmptyView) {
        self.emptyView.hidden = YES;
        return;
    }
    // 添加为空时显示的View
    if (!hasData) {
        [self.tableView addSubview:self.emptyView];
        self.emptyView.hidden = NO;
    } else {
        [self.emptyView removeFromSuperview];
        self.emptyView.hidden = YES;
    }
}

- (void)changeEmptyView:(UIView *)view {
    if (_emptyView && _emptyView.superview) {
        [_emptyView removeFromSuperview];
    }
    self.emptyView = view;
    [self.tableView gy_reloadData];
}

/**
 必须重写，子类必须提供ViewModel实例
 */
- (BWTRACTableViewModel *)tableViewModel {
    DAssert(0);
    return nil;
}

/* 目前基本可以兼容有表头的tableView
 * 无表头的话  请在所使用的类里加上self.emptyView.frame = self.tableView.frame;
 */
- (UIView *)emptyView {
    if (!_emptyView) {
        
        CGFloat posY = self.tableView.tableHeaderView.frame.size.height;
        CGFloat height = 0.0;
        
        if (self.tableView.tableHeaderView.frame.size.height != 0.0) {
            height = self.tableView.frame.size.height - self.tableView.tableHeaderView.frame.size.height;
        } else {
            height = self.tableView.frame.size.height;
        }
        
        _emptyView = [[UIView alloc]initWithFrame:CGRectMake(0.0, posY, self.tableView.frame.size.width, height)];
        
        UIImage *image = BWTBaseImageName(@"list_empty");
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        CGFloat centerY = 0.0;
        if (self.tableView.tableHeaderView.frame.size.height != 0.0) {
            centerY = _emptyView.center.y - 120.0;
        } else {
            centerY = _emptyView.center.y - 90.0;
        }
        
        imageView.size = CGSizeMake(188, 165);
        imageView.center = CGPointMake(_emptyView.center.x, centerY);
        // imageView.center = view.center;
        _emptyView.hidden = YES;
        _emptyView.backgroundColor = [UIColor clearColor];
        [_emptyView addSubview:imageView];
        
        UILabel *emptyLbl = [[UILabel alloc] initWithFrame:CGRectMake(16, imageView.frame.origin.y + imageView.frame.size.height + 8, BWTScreenWidth-32, 30)];
        
        if (self.emptyTitle.length == 0) {
            self.emptyTitle = BWTBaseUILocalizedString(@"BWTTableViewController_Empty_Title");
        }
        
        emptyLbl.text = self.emptyTitle;
        emptyLbl.textAlignment = NSTextAlignmentCenter;
        emptyLbl.font = [UIFont systemFontOfSize:16];
        emptyLbl.textColor = UIColorFrom16RGB(0x787878);
        [_emptyView addSubview:emptyLbl];
    }
    
    return _emptyView;
}

@end
