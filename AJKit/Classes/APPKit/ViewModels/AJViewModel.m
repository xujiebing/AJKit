//
//  AJViewModel.m
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import "AJViewModel.h"

@implementation AJViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self ajInit];
    }
    return self;
}

- (void)ajInit {
    
}

- (void)dealloc {
    AJLog(@"%@对象已销毁", self);
}

@end
