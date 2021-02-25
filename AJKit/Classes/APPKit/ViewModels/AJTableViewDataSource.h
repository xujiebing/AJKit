//
//  AJTableViewDataSource.h
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import <Foundation/Foundation.h>

typedef NSString * (^AJRegisterCellCallback)(NSIndexPath *indexPath);
typedef void (^AJConfigCellCallback)(id cell, id item, NSIndexPath *indexPath);
typedef void (^AJEditingCellCallback)(NSIndexPath *indexPath);

NS_ASSUME_NONNULL_BEGIN

@interface AJTableViewDataSource : NSObject <UITableViewDataSource>

/// tableView数据源
@property (nonatomic, strong, readonly) NSArray *itemsArray;

/// 当前页
@property (nonatomic, assign) NSInteger currentPage;

/// 分组数
@property (nonatomic, assign) NSUInteger sectionCount;

/// 是否有下一页 YES-有 NO-无
@property (nonatomic, assign) BOOL hasNextPage;

/// 总页
@property (nonatomic, assign) NSInteger totalPage;

/// 每页显示数量
@property (nonatomic, assign) NSInteger pageSize;

/// 注册cell
/// @param callback 回调
- (void)registerCellCallback:(AJRegisterCellCallback)callback;

/// 设置cell侧滑删除后回调的block
/// @param callback 回调
- (void)editCellCallback:(AJEditingCellCallback)callback;

/// 设置cell content
/// @param callback 回调
- (void)configCellCallback:(AJConfigCellCallback)callback;

/// 获取cell数据源
/// @param indexPath 索引
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

/// 添加数据源
/// @param items 数据
- (void)addItems:(NSArray *)items;

/// 重置数据源
/// @param items 数据
- (void)resetItems:(NSArray *)items;

/// 删除数据源
- (void)removeItems;

@end

NS_ASSUME_NONNULL_END
