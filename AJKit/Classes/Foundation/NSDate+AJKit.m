//
//  NSDate+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import "NSDate+AJKit.h"

@implementation NSDate (AJKit)

- (NSString * (^)(NSString *))ajStringValue {
    NSString * (^block)(NSString *) = ^(NSString *format){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:format];
        [formatter setLocale:[NSLocale currentLocale]];
        NSString *string = [formatter stringFromDate:self];
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
    NSTimeInterval interval = [self timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",interval];
}

- (NSString *)ajTimestampMillisecond {
    NSTimeInterval interval = [self timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",(interval * 1000)];
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
