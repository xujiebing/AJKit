//
//  RACTuple+AJKit.h
//  AJAD
//
//  Created by 徐结兵 on 2020/4/15.
//

#import "RACTuple.h"

NS_ASSUME_NONNULL_BEGIN

@interface RACTuple (AJKit)

@property (nonatomic, copy, readonly) NSString *errorCode;

@property (nonatomic, copy, readonly) NSString *errorMessage;

@end

NS_ASSUME_NONNULL_END
