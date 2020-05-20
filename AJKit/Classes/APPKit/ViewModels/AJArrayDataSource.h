//
//  AJArrayDataSource.h
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import <Foundation/Foundation.h>

typedef void (^AJCellConfigureCallback)(id cell, id item, NSIndexPath *indexPath);
typedef void (^AJCellEditingCallback)(NSIndexPath *indexPath);

NS_ASSUME_NONNULL_BEGIN

@interface AJArrayDataSource : NSObject <UITableViewDataSource>

/// tableView数据源
@property (nonatomic, strong, readonly) NSArray *dataSource;

/// 当前页
@property (nonatomic, assign) NSInteger currentPage;

/// 分组数
@property (nonatomic, assign) NSUInteger sectionCount;

/// 初始化数据源类
/// @param dataSource 数据源
/// @param cellIdentifier cell identifier
/// @param callback 回调
- (AJArrayDataSource *)initWithDataSourcce:(NSArray *)dataSource
                            cellIdentifier:(NSString *)cellIdentifier
                                  callback:(AJCellConfigureCallback)callback;

/// 初始化数据源类，此方法初始化有分组的 tableview
/// @param dataSource 数据源
/// @param cellIdentifier cell identifier
/// @param hasSection 是否有分组 yes-有 no-没有
/// @param sectionCount 总共有多少组
/// @param callback 回调
- (AJArrayDataSource *)initWithDataSourcce:(NSArray *)dataSource
                            cellIdentifier:(NSString *)cellIdentifier
                                hasSection:(BOOL)hasSection
                              sectionCount:(NSInteger)sectionCount
                                  callback:(AJCellConfigureCallback)callback;

/// 替换所有的数据
/// @param array 数据源
- (void)changeItems:(NSArray *)array;

/// 设置cell侧滑删除后回调的block
/// @param block 回调
- (void)configureCellEditBlock:(AJCellEditingCallback)block;

/// 获取cell数据源
/// @param indexPath 索引
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
