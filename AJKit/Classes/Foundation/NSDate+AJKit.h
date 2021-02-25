//
//  NSDate+AJKit.h
//  Base64
//
//  Created by 徐结兵 on 2020/4/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *AJMMDD = @"MM/dd";
static NSString *AJYYYYMMdd = @"yyyy-MM-dd";
static NSString *AJYYYYMMdd1 = @"yyyyMMdd";
static NSString *AJYYYYMMdd2 = @"yyyy年MM月dd日";
static NSString *AJYYYYMMddHHmm = @"yyyy-MM-dd HH:mm";
static NSString *AJYYYYMMddHHmm1 = @"yyyy/MM/dd HH:mm";
static NSString *AJYYYYMMddHHmmss = @"yyyy-MM-dd HH:mm:ss";
static NSString *AJYYYYMMddHHmmss1 = @"yyyy/MM/dd HH:mm:ss";

@interface NSDate (AJKit)

/// 当前日期  yyyy-MM-dd格式
@property (class, nonatomic, copy, readonly) NSString *ajCurrentDate;

/// 当前日期+时间  yyyy-MM-dd HH-mm-ss格式
@property (class, nonatomic, copy, readonly) NSString *ajCurrentDateTime;

/// 将日期以格式化的方式转化成字符串
/// @param format 格式化字符串
- (NSString *)ajToStringWithFormat:(NSString *)format;

/// 时间戳(秒)
- (NSString *)ajTimestamp;

/// 时间戳(毫秒)
- (NSString *)ajTimestampMillisecond;

/// 比较两个时间大小
/// @param aDate a时间
/// @param bDate b时间
+ (NSInteger)ajCompareDate:(NSString*)aDate withDate:(NSString*)bDate;

/// 比较两个时间大小
/// @param aDate a时间
/// @param bDate b时间
/// @param format 时间格式
+ (NSInteger)ajCompareDate:(NSString*)aDate withDate:(NSString*)bDate format:(NSString *)format;

/// 获取距离当天N天的日期，该日期为0点
/// @param day N天, 0表示当天, -1表示前一天  1表示后一天
+ (NSDate *)ajZeroTimeOfDay:(NSInteger)day;

@end

NS_ASSUME_NONNULL_END
