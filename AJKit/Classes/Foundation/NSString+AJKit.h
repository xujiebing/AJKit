//
//  NSString+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AJKit)

/// 判断字符串是否为空
/// - Parameters: NSString *
+ (BOOL (^)(NSString *))ajIsEmpty;

/// urlUTF8编码
/// - Parameters: NSString *
+ (NSString * (^)(NSString *))ajEncodeUTF8;

/// url编码
/// - Parameters: NSString *,NSStringEncoding
+ (NSString * (^)(NSString *string, NSStringEncoding encoding))ajEncode;

/// url UTF8解码
/// - Parameters: NSString *
+ (NSString * (^)(NSString *))ajDecodeUTF8;

/// url解码
/// - Parameters: NSString *,NSStringEncoding
+ (NSString * (^)(NSString *string, NSStringEncoding encoding))ajDecode;

/// 字符串转对象
/// - Parameters: NSString *
+ (id (^)(NSString *))ajJsonObject;

/// 将base64编码的字符串转换成NSData
/// - Parameters: NSString *
+ (NSData * (^)(NSString *))ajBase64DecodeToData;

/// 根据文件名（包含后缀）获取文件内容
/// - Parameters: NSString *
+ (NSData * (^)(NSString *))ajFileData;

/// 随机批次号，时间+随机数
/// - Parameters: NSString *
+ (NSString * (^)(NSString *))ajSequence;

/// 生成随机数
/// - Parameters: NSInteger
+ (NSString *(^)(NSInteger length))ajRandom;

/// 16进制字符串转换成10进制字符串
/// - Parameters: NSString *
+ (NSString * (^)(NSString *))ajHexToDecimal;

/// 10进制字符串转换成16进制字符串
/// - Parameters: NSString *
+ (NSString * (^)(NSString *))ajDecimalToHex;

/// base64编码
/// - Parameters: NSString *
+ (NSString * (^)(NSString *))ajBase64Encode;

/// base64解码
/// - Parameters: NSString *
+ (NSString * (^)(NSString *))ajBase64Decode;

/// 是否是中文
/// - Parameters: NSString *
+ (BOOL (^)(NSString *))ajIsChinese;

/// 正则匹配
/// - Parameters: NSString *, NSString *
+ (BOOL (^)(NSString *string, NSString *regex))ajMatchesRegex;

/// 过滤空格
/// - Parameters: NSString *
+ (NSString * (^)(NSString *))ajClearWhiteSpace;

/// 过滤空格和换行
/// - Parameters: NSString *
+ (NSString * (^)(NSString *))ajClearWhiteSpaceAndNewLine;

/// 判断是否包含某个字符串
/// - Parameters: NSString *
+ (BOOL (^)(NSString *))ajContainsString;

/// 将字符串转成NSNumber
/// - Parameters: NSString *
+ (NSNumber * (^)(NSString *))ajNumberValue;

/// 将字符串转换成NSData类型
/// - Parameters: NSString *
+ (NSData * (^)(NSString *))ajDataValue;

/// 判断邮箱格式
/// - Parameters: NSString *
+ (BOOL (^)(NSString *))ajIsEmail;

/// 判断手机号格式
/// - Parameters: NSString *
+ (BOOL (^)(NSString *))ajIsMobileNumber;

/// 判断是否是纯数字格式
/// - Parameters: NSString *
+ (BOOL (^)(NSString *))ajIsNumber;

/// 判断是否是邮政编码格式
/// - Parameters: NSString *
+ (BOOL (^)(NSString *))ajIsPostalcode;

/// 判断是否是url格式
/// - Parameters: NSString *
+ (BOOL (^)(NSString *))ajIsUrl;

/// 判断是否是身份证号格式
/// - Parameters: NSString *
+ (BOOL (^)(NSString *))ajIsIDCardNumber;

/// 将 日期字符串 通过 格式化 转换成 时间对象
/// - Parameters: NSString *，NSString *
+ (NSDate * (^)(NSString *string, NSString *format))ajDateValue;

@end

NS_ASSUME_NONNULL_END
