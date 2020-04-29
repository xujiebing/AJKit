//
//  AJTableViewModel.m
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import "AJTableViewMode1l.h"

@interface AJTableViewMode1l ()

@property (nonatomic, strong, readwrite) NSArray *items;
@property (nonatomic, strong, readwrite) RACCommand *requestRemoteDataCommand;
@property (nonatomic, strong, readwrite) NSArray *dataSource;

@end

@implementation AJTableViewMode1l

#pragma mark - 重写父类方法

- (void)ajInit {

    self.currentPage = 1;
    self.pageSize = 10;

    @weakify(self)
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber *page) {
        @strongify(self)
        return [[self requestRemoteDataSignalWithPage:page.unsignedIntegerValue] takeUntil:self.rac_willDeallocSignal];
    }];

    [[self.requestRemoteDataCommand.executionSignals switchToLatest]
        subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            [self handlerResponse:x];
        }];

    [self.requestRemoteDataCommand.errors  subscribeNext:^(NSError *error) {
        @strongify(self)
        [self handlerError:error];
    }];

}

#pragma mark - 内部方法


- (RACSignal *)requestRemoteDataSignalWithPage:(NSUInteger)page {
    return [RACSignal empty];
}

- (void)handlerResponse:(NSDictionary *)response {
    NSAssert(0, @"子类需要重写");
}


- (void)handlerError:(NSError *)error {
    AJLog(@"error ===== %@", error);
}

- (void)addDataSource:(NSArray *)items {
    if (!items || items.count == 0) {
        return;
    }
    

    if (self.dataSource == nil) {
        self.dataSource = items;
        return;
    }

    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.dataSource];
    if (self.currentPage == 1) {
        [tempArray removeAllObjects];
    }
    [tempArray addObjectsFromArray:items];

    self.dataSource = tempArray;
}

- (void)clearDataSource {
    self.dataSource = @[];
}

@end
