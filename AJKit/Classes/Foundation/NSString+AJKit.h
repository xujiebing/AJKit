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
/// @param NSString* 字符串对象
/// @return BOOL 是否为空
+ (BOOL (^)(NSString *ajSelf))ajIsEmpty;

/// url UTF8编码
/// @param NSString* 字符串对象
/// @return NSString* 字符串对象
+ (NSString * (^)(NSString *ajSelf))ajEncodeUTF8;

/// url编码
/// @param NSString* 字符串对象
/// @param NSStringEncoding 编码方式
/// @return NSString* 字符串对象
+ (NSString * (^)(NSString *ajSelf, NSStringEncoding encoding))ajEncode;

/// url UTF8解码
/// @param NSString* 字符串对象
/// @return NSString* 字符串对象
+ (NSString * (^)(NSString *ajSelf))ajDecodeUTF8;

/// url解码
/// @param NSString* 字符串对象
/// @param NSStringEncoding 编码方式
/// @return NSString* 字符串对象
+ (NSString * (^)(NSString *ajSelf, NSStringEncoding encoding))ajDecode;

/// 字符串转对象
/// @param NSString* 字符串对象
/// @return id 对象
+ (id (^)(NSString *ajSelf))ajJsonObject;

/// 将base64编码的字符串转换成NSData
/// @param NSString* 字符串对象
/// @return NSData* data对象
+ (NSData * (^)(NSString *ajSelf))ajBase64DecodeToData;

/// 根据文件名（包含后缀）获取文件内容
/// @param NSString* 字符串对象
/// @return NSData* data对象
+ (NSData * (^)(NSString *ajSelf))ajFileData;

/// 随机批次号，时间+随机数
/// @return NSString* 随机批次号
+ (NSString *)ajSequence;

/// 生成随机数
/// @param NSInteger 长度
/// @return NSString* 随机批次号
+ (NSString *(^)(NSInteger length))ajRandom;

/// 16进制字符串转换成10进制字符串
/// @param NSString* 16进制字符串
/// @return NSString* 10进制字符串
+ (NSString * (^)(NSString *ajSelf))ajHexToDecimal;

/// 10进制字符串转换成16进制字符串
/// @param NSString* 10进制字符串
/// @return NSString* 16进制字符串
+ (NSString * (^)(NSString *ajSelf))ajDecimalToHex;

/// base64编码
/// @param NSString* 字符串
/// @return NSString* 编码后的字符串
+ (NSString * (^)(NSString *ajSelf))ajBase64Encode;

/// base64解码
/// @param NSString* 字符串
/// @return NSString* 解码后的字符串
+ (NSString * (^)(NSString *ajSelf))ajBase64Decode;

/// 是否是中文
/// @param NSString* 字符串对象
/// @return BOOL 是否是中文
+ (BOOL (^)(NSString *ajSelf))ajIsChinese;

/// 正则匹配
/// @param NSString* 正则
/// @return BOOL 是否匹配
+ (BOOL (^)(NSString *ajSelf, NSString *regex))ajMatchesRegex;

/// 过滤空格
/// @param NSString* 字符串
/// @return NSString* 过滤后的字符串
+ (NSString * (^)(NSString *ajSelf))ajClearWhiteSpace;

/// 过滤空格和换行
/// @param NSString* 字符串
/// @return NSString* 过滤后的字符串
+ (NSString * (^)(NSString *ajSelf))ajClearWhiteSpaceAndNewLine;

/// 判断是否包含某个字符串
/// @param NSString* 目标字符串
/// @param NSString* 被包含字符串
/// @return BOOL 是否包含
+ (BOOL (^)(NSString *ajSelf, NSString *containsString))ajContainsString;

/// 将字符串转成NSNumber
/// @param NSString* 字符串
/// @return NSNumber* number
+ (NSNumber * (^)(NSString *ajSelf))ajNumberValue;

/// 将字符串转换成NSData类型
/// @param NSString* 字符串
/// @return NSData* data
+ (NSData * (^)(NSString *ajSelf))ajDataValue;

/// 判断邮箱格式
/// @param NSString* 字符串
/// @return BOOL 是否是邮箱格式
+ (BOOL (^)(NSString *ajSelf))ajIsEmail;

/// 判断手机号格式
/// @param NSString* 字符串
/// @return BOOL 是否是手机号格式
+ (BOOL (^)(NSString *ajSelf))ajIsMobileNumber;

/// 判断是否是纯数字格式
/// @param NSString* 字符串
/// @return BOOL 是否是纯数字格式
+ (BOOL (^)(NSString *ajSelf))ajIsNumber;

/// 判断是否是邮政编码格式
/// @param NSString* 字符串
/// @return BOOL 是否是邮政编码格式
+ (BOOL (^)(NSString *ajSelf))ajIsPostalcode;

/// 判断是否是url格式
/// @param NSString* 字符串
/// @return BOOL 是否是url格式
+ (BOOL (^)(NSString *ajSelf))ajIsUrl;

/// 判断是否是身份证号格式
/// @param NSString* 字符串
/// @return BOOL 是否是身份证号格式
+ (BOOL (^)(NSString *ajSelf))ajIsIDCardNumber;

/// 将 日期字符串 通过 格式化 转换成 时间对象
/// @param NSString* 字符串
/// @param NSString* 时间格式
/// @return NSDate* date对象
+ (NSDate * (^)(NSString *ajSelf, NSString *format))ajDateValue;

@end

NS_ASSUME_NONNULL_END
