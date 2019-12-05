//
//  NSDictionary+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import "NSDictionary+AJKit.h"

@implementation NSDictionary (AJKit)

+ (BOOL (^)(NSDictionary *))ajIsEmpty {
    BOOL (^block)(NSDictionary *) = ^(NSDictionary *ajSelf) {
        if (![ajSelf isKindOfClass:NSDictionary.class]) {
            return YES;
        }
        NSArray *array = ajSelf.allKeys;
        if (array.count == 0) {
            return YES;
        }
        return NO;
    };
    return block;
}

- (id  _Nonnull (^)(NSString * _Nonnull))ajObjectForKey {
    kAJWeakSelf
    id (^block)(NSString *) = ^(NSString *key) {
        id value = nil;
        if (!ajSelf.ajContainsObjectForKey(key)) {
            return value;
        }
        value = [ajSelf objectForKey:key];
        return value;
    };
    return block;
}

- (BOOL (^)(NSString * _Nonnull))ajContainsObjectForKey {
    kAJWeakSelf
    BOOL (^block)(NSString *) = ^(NSString *key) {
        if (ajSelf.ajIsEmpty || NSString.ajIsEmpty(key)) {
            return NO;
        }
        NSArray *array = ajSelf.allKeys;
        BOOL contains = [array containsObject:key];
        return contains;
    };
    return block;
}

@end

@implementation NSMutableDictionary (AJKit)

+ (BOOL (^)(NSMutableDictionary * _Nonnull))ajIsEmpty {
    BOOL (^block)(NSMutableDictionary *) = ^(NSMutableDictionary *ajSelf) {
        if (![ajSelf isKindOfClass:NSMutableDictionary.class]) {
            return YES;
        }
        NSArray *array = ajSelf.allKeys;
        if (array.count == 0) {
            return YES;
        }
        return NO;
    };
    return block;
}

- (void (^)(NSString * _Nonnull, id _Nonnull))ajSetValueForKey {
    kAJWeakSelf
    void (^block)(NSString *, id) = ^(NSString *key, id value) {
        if (![ajSelf isKindOfClass:[NSMutableDictionary class]]) {
            return ;
        }
        if (NSString.ajIsEmpty(key)) {
            return ;
        }
        if (!value) {
            return ;
        }
        [ajSelf setValue:value forKey:key];
    };
    return block;
}

@end
