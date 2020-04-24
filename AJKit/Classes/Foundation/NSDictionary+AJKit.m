//
//  NSDictionary+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import "NSDictionary+AJKit.h"

@implementation NSDictionary (AJKit)

- (BOOL)ajMethodUndefinedCrash {
    return NO;
}

+ (BOOL (^)(NSDictionary *))ajIsEmpty {
    BOOL (^block)(NSDictionary *) = ^(NSDictionary *dic) {
        if (![dic isKindOfClass:[NSDictionary class]]) {
            return YES;
        }
        NSArray *array = [dic allKeys];
        if (array.count == 0) {
            return YES;
        }
        return NO;
    };
    return block;
}

- (id)ajObjectForKey:(NSString *)key {
    if (![self ajContainsObjectForKey:key]) {
        return nil;
    }
    id aValue = self[key];
    if (aValue == [NSNull null]) {
        return nil;
    }
    return aValue;
}

- (BOOL)ajContainsObjectForKey:(id)key {
    return [[self allKeys] containsObject:key];
}

@end

@implementation NSMutableDictionary (AJKit)

- (void)ajSetValue:(id)value key:(NSString *)key {
    if (![self isKindOfClass:[NSMutableDictionary class]]) {
        return ;
    }
    if (![key isKindOfClass:NSString.class]) {
        return;
    }
    if (!value) {
        return ;
    }
    [self setValue:value forKey:key];
}

@end
