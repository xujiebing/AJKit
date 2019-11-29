//
//  NSObject+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import "NSObject+AJKit.h"

@implementation NSObject (AJKit)

+ (BOOL (^)(id _Nonnull))ajIsJSONObject {
    BOOL (^block)(id) = ^(id ajSelf){
        BOOL isJaon = [NSJSONSerialization isValidJSONObject:ajSelf];
        return isJaon;
    };
    return block;
}

+ (NSString *(^)(id _Nonnull))ajClassName {
    NSString * (^block)(id) = ^(id ajSelf){
        NSString *className = [NSString stringWithUTF8String:class_getName([ajSelf class])];
        return className;
    };
    return block;
}

+ (NSString *(^)(id _Nonnull))ajJsonString {
    NSString * (^block)(id) = ^(id ajSelf){
        if (!NSObject.ajIsJSONObject(ajSelf)) {
            return AJEmptyString;
        }
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:ajSelf options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    };
    return block;
}

@end
