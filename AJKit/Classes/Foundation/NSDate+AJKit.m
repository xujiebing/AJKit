//
//  NSDate+AJKit.m
//  Base64
//
//  Created by 徐结兵 on 2020/4/13.
//

#import "NSDate+AJKit.h"

@implementation NSDate (AJKit)

- (BOOL)ajMethodUndefinedCrash {
    return NO;
}

+ (NSString *)ajCurrentDate {
    NSDate *currentDate = [NSDate date];
    NSString *date = [currentDate ajToStringWithFormat:@"yyyy-MM-dd"];
    return date;
}

+ (NSString *)ajCurrentDateTime {
    NSDate *currentDate = [NSDate date];
    NSString *date = [currentDate ajToStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    return date;
}

- (NSString *)ajToStringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

- (NSString *)ajTimestamp {
    NSTimeInterval interval = [self timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",interval];
}

- (NSString *)ajTimestampMillisecond {
    NSTimeInterval interval = [self timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",(interval * 1000)];
}

+ (NSInteger)ajCompareDate:(NSString*)aDate withDate:(NSString*)bDate{
    return [self ajCompareDate:aDate withDate:bDate format:@"yyyy-MM-dd"];
}

+ (NSInteger)ajCompareDate:(NSString*)aDate withDate:(NSString*)bDate format:(NSString *)format {
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:format];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    NSInteger a;
    if (result == NSOrderedSame) {
        // bDate = aDate
        a = 0;
    } else if (result == NSOrderedAscending) {
        // bDate比aDate大
        a = 1;
    } else {
        // bDate比aDate小
        a = 2;
    }
    return a;
}

+ (NSDate *)ajZeroTimeOfDay:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GTM"]];
    NSDate *now = [NSDate new];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSDate *today = [calendar dateFromComponents:components];
    NSDate *date = [calendar dateByAddingUnit:NSCalendarUnitDay value:day toDate:today options:0];
    return date;
}

@end
