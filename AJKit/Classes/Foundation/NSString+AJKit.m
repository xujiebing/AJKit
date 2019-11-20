//
//  NSString+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import "NSString+AJKit.h"

@implementation NSString (AJKit)

+ (BOOL (^)(NSString * _Nonnull))ajIsEmpty {
    BOOL (^block)(NSString *) = ^(NSString *string) {
        if (![string isKindOfClass:NSString.class]) {
            return YES;
        }
        if (string.length == 0) {
            return YES;
        }
        return NO;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSString * _Nonnull))ajUrlDecodeString {
    NSString *(^block)(NSString *) = ^(NSString *string) {
        NSString *decodeString = nil;
        if (NSString.ajIsEmpty(string)) {
            return decodeString;
        }
        decodeString = (__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)string, CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
        return decodeString;
    };
    return block;
}

+ (id  _Nonnull (^)(NSString * _Nonnull))ajJsonObject {
    id (^block)(NSString *) = ^(NSString *string) {
        id complete = nil;
        if (NSString.ajIsEmpty(string)) {
            return complete;
        }
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        complete = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) {
            AJLog(@"error:%@", error);
        }
        return complete;
    };
    return block;
}

@end
