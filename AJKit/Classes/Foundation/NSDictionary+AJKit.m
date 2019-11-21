//
//  NSDictionary+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import "NSDictionary+AJKit.h"

@implementation NSDictionary (AJKit)

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

+ (id  _Nonnull (^)(NSDictionary * _Nonnull, NSString * _Nonnull))ajObjectForKey {
    id (^block)(NSDictionary *, NSString *) = ^(NSDictionary *dic, NSString *key) {
        id value = nil;
        if (NSDictionary.ajIsEmpty(dic)) {
            return value;
        }
        if (NSString.ajIsEmpty(key)) {
            return value;
        }
        NSArray *array = [dic allKeys];
        if (![array containsObject:key]) {
            return value;
        }
        value = [dic objectForKey:key];
        return value;
    };
    return block;
}

- (NSString *)ajJsonString {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

- (BOOL (^)(NSString * _Nonnull))ajContainsObjectForKey {
    BOOL (^block)(NSString *) = ^(NSString *key) {
        NSArray *array = [self allKeys];
        BOOL contains = [array containsObject:key];
        return contains;
    };
    return block;
}

@end

@implementation NSMutableDictionary (AJKit)

+ (BOOL (^)(NSMutableDictionary * _Nonnull))ajIsEmpty {
    BOOL (^block)(NSMutableDictionary *) = ^(NSMutableDictionary *dic) {
        if (![dic isKindOfClass:[NSMutableDictionary class]]) {
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

+ (void (^)(NSMutableDictionary * _Nonnull, NSString * _Nonnull, id _Nonnull))ajSetValueForKey {
    void (^block)(NSMutableDictionary *, NSString *, id) = ^(NSMutableDictionary *dic, NSString *key, id value) {
        if (![dic isKindOfClass:[NSMutableDictionary class]]) {
            return ;
        }
        if (NSString.ajIsEmpty(key)) {
            return ;
        }
        if (!value) {
            return ;
        }
        [dic setValue:value forKey:key];
    };
    return block;
}

+ (void (^)(NSMutableDictionary * _Nonnull, NSString * _Nonnull, id _Nonnull))ajSetObjectForKey {
    void (^block)(NSMutableDictionary *, NSString *, id) = ^(NSMutableDictionary *dic, NSString *key, id object) {
        if (![dic isKindOfClass:[NSMutableDictionary class]]) {
            return ;
        }
        if (NSString.ajIsEmpty(key)) {
            return ;
        }
        if (!object) {
            return ;
        }
        [dic setObject:object forKey:key];
    };
    return block;
}

@end
