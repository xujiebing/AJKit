//
//  AJTableViewModel.h
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import "AJViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJTableViewModel : AJViewModel

@property (nonatomic, strong, readonly) NSArray * _Nullable dataSource;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL hasNextPage;
@property (nonatomic, assign) NSInteger totalPage;
@property (nonatomic, assign) NSInteger pageSize;


@property (nonatomic, strong, readonly) RACCommand * _Nonnull  requestRemoteDataCommand;


#pragma mark - 子类需要重写的方法

/// 请求网络数据
/// @param page 当前页
- (RACSignal *_Nonnull)requestRemoteDataSignalWithPage:(NSUInteger)page;

/// 解析返回包
/// @param response 网络返回包
- (void)handlerResponse:(NSDictionary * _Nonnull )response;

/// 异常处理
/// @param error 异常
- (void)handlerError:(NSError * _Nullable )error;

/// 添加数据源
/// @param items 数据源
- (void)addDataSource:(NSArray * _Nullable )items;

/// 清空数据源
- (void)clearDataSource;

@end

NS_ASSUME_NONNULL_END
