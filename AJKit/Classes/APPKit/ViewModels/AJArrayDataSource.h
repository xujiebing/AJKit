//
//  AJArrayDataSource.h
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import <Foundation/Foundation.h>

typedef void (^AJTableViewCellConfigureBlock)(id cell, id item, NSIndexPath *indexPath);
typedef void (^AJTableViewCellEditingBlock)(NSIndexPath *indexPath);

NS_ASSUME_NONNULL_BEGIN

@interface AJArrayDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, assign) NSUInteger sectionCount;  // 分组数

/// 初始化数据源类
/// @param anItems 数据源
/// @param aCellIdentifier cell identifier
/// @param aConfigureCellBlock 回调
- (id)initWithItems:(NSArray *)anItems
     cellIdentifier:(NSString *)aCellIdentifier
 configureCellBlock:(AJTableViewCellConfigureBlock)aConfigureCellBlock;

/// 初始化数据源类，此方法初始化有分组的 tableview
/// @param items 数据源
/// @param cellIdentifier cell identifier
/// @param block 回调
/// @param hasSection 是否有分组 yes-有 no-没有
/// @param sectionCount 总共有多少组
- (id)initWithItems:(NSArray *)items
     cellIdentifier:(NSString *)cellIdentifier
 configureCellBlock:(AJTableViewCellConfigureBlock)block
         hasSection:(BOOL)hasSection
       sectionCount:(NSInteger)sectionCount;

/// 替换所有的数据
/// @param array 数据源
- (void)changeItems:(NSArray *)array;

/// 设置cell侧滑删除后回调的block
/// @param block 回调
- (void)configureCellEditBlock:(AJTableViewCellEditingBlock)block;

/// 获取cell数据源
/// @param indexPath 索引
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
