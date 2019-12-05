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

- (NSString * _Nonnull (^)(NSString * _Nonnull))ajStringValue {
    kAJWeakSelf
    NSString * (^block)(NSString *) = ^(NSString *format){
        if (NSString.ajIsEmpty(format)) {
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

- (NSString *)ajDateString {
    return self.ajStringValue(AJYYYYMMDD1);
}

- (NSString *)ajDateTimeString {
    return self.ajStringValue(AJYYYYMMDDHHMMSS1);
}

- (NSString *)ajTimestamp {
    NSTimeInterval interval = self.timeIntervalSince1970;
    NSString *string = [NSString stringWithFormat:@"%.0f",interval];
    return string;
}

- (NSString *)ajTimestampMillisecond {
    NSTimeInterval interval = self.timeIntervalSince1970;
    NSString *string = [NSString stringWithFormat:@"%.0f",(interval * 1000)];
    return string;
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
