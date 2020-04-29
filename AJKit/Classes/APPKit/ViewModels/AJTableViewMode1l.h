//
//  AJTableViewModel.h
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import "AJViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJTableViewMode1l : AJViewModel

/**
 TableView数据源
 */
@property (nonatomic, strong, readonly) NSArray * _Nullable dataSource;


/**
 是否有下一页 YES-有 NO-无
 */
@property (nonatomic, assign) BOOL hasNextPage;


/**
 当前页
 */
@property (nonatomic, assign) NSInteger currentPage;


/**
 总页
 */
@property (nonatomic, assign) NSInteger totalPage;


/**
 每页显示数量
 */
@property (nonatomic, assign) NSInteger pageSize;


/**
 搜索关键字
 */
@property (nonatomic, copy) NSString * _Nullable keyword;


/**
 网络请求
 */
@property (nonatomic, strong, readonly) RACCommand * _Nonnull  requestRemoteDataCommand;


#pragma mark - 子类需要重写的方法

/**
 请求网络数据

 @param page 当前页
 @return 信号类
 */
- (RACSignal *_Nonnull)requestRemoteDataSignalWithPage:(NSUInteger)page;


/**
 解析返回包

 @param response 网络返回包
 */
- (void)handlerResponse:(NSDictionary * _Nonnull )response;



/**
 异常处理

 @param error 异常类
 */
- (void)handlerError:(NSError * _Nullable )error;



/**
 添加数据源

 @param items 添加数据源
 */
- (void)addDataSource:(NSArray * _Nullable )items;



/**
 清空数据源
 */
- (void)clearDataSource;

@end

NS_ASSUME_NONNULL_END
