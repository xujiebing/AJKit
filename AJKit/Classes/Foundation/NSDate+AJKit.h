//
//  NSDate+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import <Foundation/Foundation.h>

/// yyyy-MM-dd
static NSString * _Nonnull const AJYYYYMMDD1 = @"yyyy-MM-dd";
/// yyyy/MM/dd
static NSString * _Nonnull const AJYYYYMMDD2 = @"yyyy/MM/dd";
/// yyyy.MM.dd
static NSString * _Nonnull const AJYYYYMMDD3 = @"yyyy.MM.dd";
/// yyyy年MM月dd日
static NSString * _Nonnull const AJYYYYMMDD4 = @"yyyy年MM月dd日";
/// yyyyMMdd
static NSString * _Nonnull const AJYYYYMMDD5 = @"yyyyMMdd";
/// yyyy-MM-dd HH:mm
static NSString * _Nonnull const AJYYYYMMDDHHMM1 = @"yyyy-MM-dd HH:mm";
/// yyyy/MM/dd HH:mm
static NSString * _Nonnull const AJYYYYMMDDHHMM2 = @"yyyy/MM/dd HH:mm";
/// yyyy.MM.dd HH:mm
static NSString * _Nonnull const AJYYYYMMDDHHMM3 = @"yyyy.MM.dd HH:mm";
/// yyyy年MM月dd日 HH:mm
static NSString * _Nonnull const AJYYYYMMDDHHMM4 = @"yyyy年MM月dd日 HH:mm";
/// yyyyMMddHHmm
static NSString * _Nonnull const AJYYYYMMDDHHMM5 = @"yyyyMMddHHmm";
/// yyyy-MM-dd HH:mm:ss
static NSString * _Nonnull const AJYYYYMMDDHHMMSS1 = @"yyyy-MM-dd HH:mm:ss";
/// yyyy/MM/dd HH:mm:ss
static NSString * _Nonnull const AJYYYYMMDDHHMMSS2 = @"yyyy/MM/dd HH:mm:ss";
/// yyyy.MM.dd HH:mm:ss
static NSString * _Nonnull const AJYYYYMMDDHHMMSS3 = @"yyyy.MM.dd HH:mm:ss";
/// yyyy年MM月dd日 HH:mm:ss
static NSString * _Nonnull const AJYYYYMMDDHHMMSS4 = @"yyyy年MM月dd日 HH:mm:ss";
/// yyyyMMddHHmmss
static NSString * _Nonnull const AJYYYYMMDDHHMMSS5 = @"yyyyMMddHHmmss";

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (AJKit)

/// 判断NSDate是否为空
/// - Parameters: NSDate *
+ (BOOL (^)(NSDate * _Nonnull))ajIsEmpty;

/// 将日期以格式化的方式转化成字符串
/// - Parameters: NSDate *, NSString *
+ (NSString * (^)(NSDate *date, NSString *format))ajStringValue;

/// 当前日期  返回一个yyyy-MM-dd格式的日期
/// - Parameters: NSDate *
+ (NSString * (^)(NSDate *date))ajDateString;

/// 当前日期+时间  返回一个yyyy-MM-dd HH:mm:ss格式的日期+时间
/// - Parameters: NSDate *
+ (NSString * (^)(NSDate *date))ajDateTimeString;

/// 时间戳(秒)
/// - Parameters: NSDate *
+ (NSString * (^)(NSDate *date))ajTimestamp;

/// 时间戳(毫秒)
/// - Parameters: NSDate *
+ (NSString * (^)(NSDate *date))ajTimestampMillisecond;

/// 根据时间戳（毫秒）转换成日期格式
/// - Parameters: NSTimeInterval
+ (NSDate * (^)(NSTimeInterval))ajTimestampMillisecondToDate;

@end


NS_ASSUME_NONNULL_END
