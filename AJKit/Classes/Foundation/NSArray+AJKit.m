//
//  NSArray+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import "NSArray+AJKit.h"

@implementation NSArray (AJKit)

- (BOOL)ajMethodUndefinedCrash {
    return NO;
}

+ (BOOL (^)(NSArray * _Nonnull))ajIsEmpty {
    BOOL (^block)(NSArray *) = ^(NSArray *array) {
        if (![array isKindOfClass:NSArray.class]) {
            return YES;
        }
        if (array.count == 0) {
            return YES;
        }
        return NO;
    };
    return block;
}

- (id)ajObjectAtIndex:(NSUInteger)index {
    return index < self.count ? self[index] : nil;
}

- (NSUInteger)ajIndexOfObject:(id)anObject {
    NSParameterAssert(self.count);
    if ([self containsObject:anObject]) {
        return [self indexOfObject:anObject];
    }
    return 0;
}

@end

@implementation NSMutableArray (AJKit)

- (void)ajInsertOfObject:(id)anObject {
    if (!anObject) {
        return;
    }
    [self addObject:anObject];
}

- (void)ajRemoveFirstObject {
    if (self.count == 0) {
        return;
    }
    [self removeObjectAtIndex:0];
}

@end
