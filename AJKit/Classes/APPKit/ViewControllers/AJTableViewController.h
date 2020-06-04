//
//  AJTableViewController.h
//  AJKit
//
//  Created by 徐结兵 on 2019/12/12.
//

#import "AJViewController.h"
#import "AJArrayDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface AJTableViewController : AJViewController

/// 列表视图样式
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

/// 列表视图
@property (nonatomic, strong) UITableView *tableView;

/// 无数据时显示的视图
@property (nonatomic, strong) UIView *emptyView;

/// 开启自动加载数据 YES-开启 NO-关闭 默认开启
@property (nonatomic, assign) BOOL autoLoad;

/// 关闭上/下拉刷新 YES-关闭 NO-开启 默认开启
@property (nonatomic, assign) BOOL closeRefresh;

@property (nonatomic, strong, readonly) AJArrayDataSource *ajDataSource;

/// 设置头部下拉刷新组件是否隐藏
/// @param hidden
- (void)headerRefreshViewHidden:(BOOL)hidden;

/// 设置尾部上拉刷新组件是否隐藏
/// @param hidden
- (void)footerRefreshViewHidden:(BOOL)hidden;

/// 重新刷新表格
- (void)reloadTableView;

/// 开始刷新视图
- (void)beginRefreshing;

/// 结束刷新视图, 下拉刷新/上拉分页 都可调用此方法
- (void)endRefreshing;

#pragma mark - 以下方法子类需要重写

/// 配置TableView的数据源
- (void)configTableViewSource;

/// 获取数据源
/// @param page 当前页面
- (void)requestDataSourceWithPage:(NSInteger)page;

/// 选中单个cell时回调的方法
/// @param indexPath indexPath
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath;

/// 设置cell高度
/// @param indexPath indexPath
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/// 设置header高度
/// @param section 索引
- (CGFloat)heightForHeaderInSection:(NSInteger)section;

/// 设置footer高度
/// @param section 索引
- (CGFloat)heightForFooterInSection:(NSInteger)section;

/// 注册headerView
/// @param section 索引
- (NSString *)registerViewForHeaderInSection:(NSInteger)section;

/// 注册footerView
/// @param section 索引
- (NSString *)registeriewForFooterInSection:(NSInteger)section;

/// 设置headerView
/// @param section 索引
/// @param headerView headerView
- (void)viewForHeaderInSection:(NSInteger)section headerView:(UITableViewHeaderFooterView *)headerView;

/// 设置footerView
/// @param section 索引
/// @param footerView footerView
- (void)viewForFooterInSection:(NSInteger)section footerView:(UITableViewHeaderFooterView *)footerView;

@end

NS_ASSUME_NONNULL_END
