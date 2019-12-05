//
//  NSArray+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import "NSArray+AJKit.h"

@implementation NSArray (AJKit)

- (BOOL)ajNonEmpty {
    if (self.count == 0) {
        return NO;
    }
    return YES;
}

- (id  _Nonnull (^)(NSUInteger))ajObjectAtIndex {
    kAJWeakSelf
    id (^block)(NSUInteger) = ^(NSUInteger index) {
        id obj = nil;
        if (!ajSelf.ajNonEmpty) {
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
