//
//  AJTableViewController.m
//  AJKit
//
//  Created by 徐结兵 on 2019/12/12.
//

#import "AJTableViewController.h"

@interface AJTableViewController ()<UITableViewDelegate>

@property (nonatomic, strong) AJTableViewDataSource *ajDataSource;

@end

@implementation AJTableViewController

#pragma mark - 生命周期方法

- (void)dealloc {
    self.ajDataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self aj_initData];
    [self aj_initView];
}

#pragma mark - 公共方法

- (void)setAutoLoad:(BOOL)autoLoad {
    _autoLoad = autoLoad;
}

- (void)reloadTableView {
    if (self.ajDataSource.itemsArray.count == 0) {
        [self.tableView addSubview:self.emptyView];
        self.emptyView.hidden = NO;
    } else {
        [self.emptyView removeFromSuperview];
        self.emptyView.hidden = YES;
    }
    [self.tableView reloadData];
    
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}

- (void)endRefreshing {
    if (self.ajDataSource.currentPage > 1 && self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
        return;
    }

    if(self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
}

- (void)headerRefreshViewHidden:(BOOL)hidden {
    self.tableView.mj_header.hidden = hidden;
}

- (void)footerRefreshViewHidden:(BOOL)hidden {
    self.tableView.mj_header.hidden = hidden;
}

#pragma mark - 对内方法

- (void)aj_initView {
    self.view.backgroundColor = AJUIColorFrom10RGB(248, 248, 248);
    [self.view addSubview:self.tableView];
    if (!self.closeRefresh) {
        [self p_addHeader];
        [self p_addFooter];
    }
}

- (void)aj_initData {
    // 初始化默认数据
    _autoLoad = YES;
    _closeRefresh = NO;
    [self configTableViewSource];
    // 数据更新后刷新视图
    kAJRACWeakSelf
    [RACObserve(self.ajDataSource, itemsArray) subscribeNext:^(id x) {
        kAJRACStrongSelf
        [self endRefreshing];
        [self reloadTableView];
    }];

    // 绑定上拉分页是否可用
    [[RACObserve(self.ajDataSource, hasNextPage) distinctUntilChanged] subscribeNext:^(NSNumber *hasNextPage) {
        kAJRACStrongSelf
        self.tableView.mj_footer.hidden = !hasNextPage.boolValue;
    }];
    
}

- (void)p_addHeader {
    kAJWeakSelf
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [ajSelf p_headerWithRefreshing];
    }];

    if (self.autoLoad) {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (void)p_addFooter {
    kAJWeakSelf
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [ajSelf p_footerWithRefreshing];
    }];
    self.tableView.mj_footer.automaticallyHidden = NO; // 关闭自动分页刷新
    self.tableView.mj_footer.hidden = YES;
}

- (void)p_headerWithRefreshing {
    self.ajDataSource.currentPage = 1;
    [self requestDataSourceWithPage:1];
}

- (void)p_footerWithRefreshing {
    self.ajDataSource.currentPage++;
    [self requestDataSourceWithPage:self.ajDataSource.currentPage];
}

#pragma mark - 懒加载方法

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.ajWidth, UIScreen.ajViewHeight) style:self.tableViewStyle];
        tableView.backgroundColor = AJUIColorFrom10RGB(237,246,255);
        tableView.backgroundView = nil;
        tableView.delegate = self;
        tableView.dataSource = self.ajDataSource;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.rowHeight = 70.f;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        _tableView = tableView;
    }
    return _tableView;
}

- (UIView *)emptyView {
    if (!_emptyView) {
        CGFloat posY = self.tableView.tableHeaderView.frame.size.height;
        CGFloat height = 0.0;
        
        if (self.tableView.tableHeaderView.frame.size.height != 0.0) {
            height = self.tableView.ajHeight - self.tableView.tableHeaderView.ajHeight;
        } else {
            height = self.tableView.ajHeight;
        }
        
        _emptyView = [[UIView alloc]initWithFrame:CGRectMake(0.0, posY, self.tableView.ajWidth, height)];
    }
    return _emptyView;
}

- (AJTableViewDataSource *)ajDataSource {
    if (!_ajDataSource) {
        _ajDataSource = AJTableViewDataSource.new;
    }
    return _ajDataSource;
}

- (UITableViewStyle)tableViewStyle {
    if (!_tableViewStyle) {
        _tableViewStyle = UITableViewStylePlain;
    }
    return _tableViewStyle;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self selectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self heightForFooterInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerFooterView = [UITableViewHeaderFooterView.alloc initWithFrame:CGRectMake(0, 0, tableView.ajWidth, [self heightForHeaderInSection:section])];
    [self viewForHeaderInSection:section headerView:headerFooterView];
    return headerFooterView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerFooterView = [UITableViewHeaderFooterView.alloc initWithFrame:CGRectMake(0, 0, tableView.ajWidth, [self heightForHeaderInSection:section])];
    [self viewForFooterInSection:section footerView:headerFooterView];
    return headerFooterView;
}

#pragma mark - 以下方法子类需要重写

/// 配置TableView的数据源
- (void)configTableViewSource {
    NSAssert(0, @"");
}

- (void)requestDataSourceWithPage:(NSInteger)page {
    NSAssert(0, @"子类重写");
}

- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)viewForHeaderInSection:(NSInteger)section headerView:(UITableViewHeaderFooterView *)headerView {
    
}

- (void)viewForFooterInSection:(NSInteger)section footerView:(UITableViewHeaderFooterView *)footerView {
    
}

@end
