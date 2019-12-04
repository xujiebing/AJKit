//
//  NSArray+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import "NSArray+AJKit.h"

@implementation NSArray (AJKit)

- (BOOL)ajIsEmpty {
    if (self.count == 0) {
        return YES;
    }
    return NO;
}

- (id  _Nonnull (^)(NSUInteger))ajObjectAtIndex {
    kAJWeakSelf
    id (^block)(NSUInteger) = ^(NSUInteger index) {
        id obj = nil;
        if (self.ajIsEmpty) {
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

- (void (^)(id _Nonnull))ajAddObject {
    kAJWeakSelf
    void (^block)(id) = ^(id object) {
        if (!object) {
            return;
        }
        [ajSelf addObject:object];
    };
    return block;
}

@end
