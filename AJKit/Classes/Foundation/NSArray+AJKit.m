//
//  NSArray+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import "NSArray+AJKit.h"

@implementation NSArray (AJKit)

+ (BOOL (^)(NSArray * _Nonnull))ajIsEmpty {
    BOOL (^block)(NSArray *) = ^(NSArray *array) {
        if (![array isKindOfClass:[NSArray class]]) {
            return YES;
        }
        if (array.count == 0) {
            return YES;
        }
        return NO;
    };
    return block;
}

+ (id  _Nonnull (^)(NSArray * _Nonnull, NSUInteger))ajObjectAtIndex {
    id (^block)(NSArray *, NSUInteger) = ^(NSArray *array, NSUInteger index) {
        id obj = nil;
        if (NSArray.ajIsEmpty(array)) {
            return obj;
        }
        if (index < array.count) {
            obj = [array objectAtIndex:index];
        }
        return obj;
    };
    return block;
}

@end

@implementation NSMutableArray (AJKit)

+ (BOOL (^)(NSMutableArray * _Nonnull))ajIsEmpty {
    BOOL (^block)(NSMutableArray *) = ^(NSMutableArray *array) {
        if (![array isKindOfClass:[NSMutableArray class]]) {
            return YES;
        }
        if (array.count == 0) {
            return YES;
        }
        return NO;
    };
    return block;
}

+ (void (^)(NSMutableArray * _Nonnull, id _Nonnull))ajAddObject {
    void (^block)(NSMutableArray *, id) = ^(NSMutableArray *array, id object) {
        if (![array isKindOfClass:[NSMutableArray class]]) {
            return ;
        }
        if (!object) {
            return;
        }
        [array addObject:object];
    };
    return block;
}

@end
