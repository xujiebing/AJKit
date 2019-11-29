//
//  BWTRACTableViewController.h
//  BWTBaseFramework
//
//  Created by gaoyang on 2019/7/3.
//

#import "BWTRACBaseViewController.h"
#import <BWTBaseBusiness/BWTRACTableViewModel.h>
#import "UIViewController+BWTTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWTRACTableViewPage : BWTRACBaseViewController

@property (nonatomic, strong) BWTRACTableViewModel *tableViewModel; //业务层
@property (nonatomic, assign) BOOL hideEmptyView;           // 隐藏空白页
@property (nonatomic, copy) NSString *emptyTitle;           // 为空内容提示

- (void)configTableViewSource:(NSArray *)dataSource lastSectionNode:(SectionNode * _Nullable)lastSectionNode;

/**
 异常处理
 
 @param error 异常类
 */
- (void)handlerError:(NSError * _Nullable)error;

/**
 替换无数据时显示的View
 
 @param view 自定义View
 */
- (void)changeEmptyView:(UIView * _Nullable)view;

@end

NS_ASSUME_NONNULL_END
