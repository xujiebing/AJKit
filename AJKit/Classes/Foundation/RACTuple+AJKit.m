//
//  RACTuple+AJKit.m
//  AJAD
//
//  Created by 徐结兵 on 2020/4/15.
//

#import "RACTuple+AJKit.h"

@implementation RACTuple (AJKit)

- (BOOL)ajMethodUndefinedCrash {
    return NO;
}

- (NSString *)errorCode {
    RACTupleUnpack(NSString *message, NSString *code) = self;
    AJLog(@"message ==== %@, code ===== %@", message, code);
    return code;
}

- (NSString *)errorMessage {
    RACTupleUnpack(NSString *message) = self;
    AJLog(@"message ==== %@", message);
    return message;
}

@end
