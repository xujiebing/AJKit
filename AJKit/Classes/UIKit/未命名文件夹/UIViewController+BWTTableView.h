//
//  UIViewController+BWTTableView.h
//  BWTHome
//
//  Created by gaoyang on 2019/4/13.
//

#import <UIKit/UIKit.h>
#import <GYTableViewController/UIViewController+GYTableView.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BWTTableView)

/**
 设置是否使用该控件 默认false;请在引入头文件后重写该方法返回true
 @return 是否使用
 */
- (BOOL)bwt_useTableView;
/**
 设置是否显示上拉加载更多控件
 @return 是否显示
 */
- (BOOL)bwt_useRefreshHeader;
/**
 设置是否显示下拉刷新控件
 @return 是否显示
 */
- (BOOL)bwt_useLoadMoreFooter;
/**
 是否自动开始下拉刷新
 @return 是否自动
 */
- (BOOL)bwt_useAutoRefreshHeader;
/**
 设置每次进入该页面自动滚动到列表顶部
 @return 是否自动
 */
- (BOOL)bwt_useAutoRestOffset;
/**
 设置TableView的布局位置，默认铺满Controller
 @return 位置
 */
- (CGRect)bwt_getTableViewFrame;
/**
 设置TableView的父容器，默认当前view
 @return 父容器
 */
- (UIView *)bwt_getTableViewParent;
/**
 设置自定义下拉刷新控件实例
 @return 下拉刷新控件
 */
- (MJRefreshHeader *)bwt_getRefreshHeader;
/**
 设置自定义上拉加载控件实例 useLoadMoreFooter启用有效
 @return 上拉加载控件
 */
- (MJRefreshFooter *)bwt_getRefreshFooter;

@end

NS_ASSUME_NONNULL_END
