//
//  NSDate+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import "NSDate+AJKit.h"

@implementation NSDate (AJKit)

+ (BOOL (^)(NSDate * _Nonnull))ajIsEmpty {
    BOOL (^block)(NSDate *) = ^(NSDate *ajSelf) {
        if (![ajSelf isKindOfClass:NSDate.class]) {
            return YES;
        }
        return NO;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSDate * _Nonnull, NSString * _Nonnull))ajStringValue {
    NSString * (^block)(NSDate *, NSString *) = ^(NSDate *ajSelf, NSString *format){
        if (NSDate.ajIsEmpty(ajSelf) || NSString.ajIsEmpty(format)) {
            return AJEmptyString;
        }
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        [formatter setLocale:[NSLocale currentLocale]];
        NSString *string = [formatter stringFromDate:ajSelf];
        return string;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSDate * _Nonnull))ajDateString {
    NSString * (^block)(NSDate *) = ^(NSDate *ajSelf){
        if (NSDate.ajIsEmpty(ajSelf)) {
            return AJEmptyString;
        }
        NSString *string = NSDate.ajStringValue(ajSelf, AJYYYYMMDD1);
        return string;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSDate * _Nonnull))ajDateTimeString {
    NSString * (^block)(NSDate *) = ^(NSDate *ajSelf){
        if (NSDate.ajIsEmpty(ajSelf)) {
            return AJEmptyString;
        }
        NSString *string = NSDate.ajStringValue(ajSelf, AJYYYYMMDDHHMMSS1);
        return string;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSDate * _Nonnull))ajTimestamp {
    NSString * (^block)(NSDate *) = ^(NSDate *ajSelf){
        if (NSDate.ajIsEmpty(ajSelf)) {
            return AJEmptyString;
        }
        NSTimeInterval interval = ajSelf.timeIntervalSince1970;
        NSString *string = [NSString stringWithFormat:@"%.0f",interval];
        return string;
    };
    return block;
}

+ (NSString * _Nonnull (^)(NSDate * _Nonnull))ajTimestampMillisecond {
    NSString * (^block)(NSDate *) = ^(NSDate *ajSelf){
        if (NSDate.ajIsEmpty(ajSelf)) {
            return AJEmptyString;
        }
        NSTimeInterval interval = ajSelf.timeIntervalSince1970;
        NSString *string = [NSString stringWithFormat:@"%.0f",(interval * 1000)];
        return string;
    };
    return block;
}

+ (NSDate * (^)(NSTimeInterval))ajTimestampMillisecondToDate {
    NSDate * (^block)(NSTimeInterval) = ^(NSTimeInterval timestamp){
        NSString *intervalStr = [NSString stringWithFormat:@"%f",timestamp];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[intervalStr doubleValue]/1000];
        return date;
    };
    return block;
}

@end
