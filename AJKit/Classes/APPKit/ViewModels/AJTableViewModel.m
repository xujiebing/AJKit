//
//  AJTableViewModel.m
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import "AJTableViewModel.h"

@interface AJTableViewModel ()

@property (nonatomic, strong, readwrite) NSArray *items;
@property (nonatomic, strong, readwrite) RACCommand *requestRemoteDataCommand;

@end

@implementation AJTableViewModel

#pragma mark - 重写父类方法

- (void)ajInit {

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

@end
