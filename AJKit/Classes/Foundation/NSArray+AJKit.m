//
//  NSArray+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import "NSArray+AJKit.h"

@implementation NSArray (AJKit)

+ (BOOL (^)(NSArray * _Nonnull))ajIsEmpty {
    BOOL (^block)(NSArray *) = ^(NSArray *ajSelf) {
        if (![ajSelf isKindOfClass:[NSArray class]]) {
            return YES;
        }
        if (ajSelf.count == 0) {
            return YES;
        }
        return NO;
    };
    return block;
}

+ (id  _Nonnull (^)(NSArray * _Nonnull, NSUInteger))ajObjectAtIndex {
    id (^block)(NSArray *, NSUInteger) = ^(NSArray *ajSelf, NSUInteger index) {
        id obj = nil;
        if (NSArray.ajIsEmpty(ajSelf)) {
            return obj;
        }
        if (index < ajSelf.count) {
            obj = [ajSelf objectAtIndex:index];
        }
        return obj;
    };
    return block;
}

@end

@implementation NSMutableArray (AJKit)

+ (BOOL (^)(NSMutableArray * _Nonnull))ajIsEmpty {
    BOOL (^block)(NSMutableArray *) = ^(NSMutableArray *ajSelf) {
        if (![ajSelf isKindOfClass:[NSMutableArray class]]) {
            return YES;
        }
        if (ajSelf.count == 0) {
            return YES;
        }
        return NO;
    };
    return block;
}

+ (void (^)(NSMutableArray * _Nonnull, id _Nonnull))ajAddObject {
    void (^block)(NSMutableArray *, id) = ^(NSMutableArray *ajSelf, id object) {
        if (![ajSelf isKindOfClass:[NSMutableArray class]]) {
            return ;
        }
        if (!object) {
            return;
        }
        [ajSelf addObject:object];
    };
    return block;
}

@end
