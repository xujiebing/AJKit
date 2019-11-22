//
//  NSObject+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import "NSObject+AJKit.h"

@implementation NSObject (AJKit)

+ (BOOL (^)(id _Nonnull))ajIsJSONObject {
    BOOL (^block)(id) = ^(id obj){
        BOOL isJaon = [NSJSONSerialization isValidJSONObject:obj];
        return isJaon;
    };
    return block;
}

+ (NSString *(^)(id _Nonnull))ajClassName {
    NSString * (^block)(id) = ^(id obj){
        NSString *className = [NSString stringWithUTF8String:class_getName([obj class])];
        return className;
    };
    return block;
}

+ (NSString *(^)(id _Nonnull))ajJsonString {
    NSString * (^block)(id) = ^(id obj){
        if (!NSObject.ajIsJSONObject(obj)) {
            return AJEmptyString;
        }
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    };
    return block;
}

@end
