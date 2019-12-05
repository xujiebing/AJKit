//
//  NSString+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AJKit)

/// 判断对象是否为空
/// @return BOOL 是否为空  YES-不为空 NO-为空
- (BOOL)ajNonEmpty;

/// Documents Path
+ (NSString *)ajDocumentsPath;

/// Library Path
+ (NSString *)ajLibraryPath;

/// Caches Path
+ (NSString *)ajCachesPath;

/// url UTF8编码
/// @param NSString* 字符串对象
/// @return NSString* 字符串对象
- (NSString *)ajEncodeUTF8;

/// url编码
/// @param NSStringEncoding 编码方式
/// @return NSString* 字符串对象
- (NSString * (^)(NSStringEncoding encoding))ajEncode;

/// url UTF8解码
/// @return NSString* 字符串对象
- (NSString *)ajDecodeUTF8;

/// url解码
/// @param NSStringEncoding 编码方式
/// @return NSString* 字符串对象
- (NSString * (^)(NSStringEncoding encoding))ajDecode;

/// 字符串转对象
/// @return id 对象
- (id)ajJsonObject;

/// 将base64编码的字符串转换成NSData
/// @return NSData* data对象
- (NSData *)ajBase64DecodeToData;

/// base64编码
/// @return NSString* 编码后的字符串
- (NSString *)ajBase64Encode;

/// base64解码
/// @return NSString* 解码后的字符串
- (NSString *)ajBase64Decode;

/// 根据文件名（包含后缀）获取文件内容
/// @return NSData* data对象
- (NSData *)ajFileData;

/// 随机批次号，时间+随机数
/// @return NSString* 随机批次号
+ (NSString *)ajSequence;

/// 生成随机数
/// @param NSInteger 长度
/// @return NSString* 随机批次号
+ (NSString *(^)(NSInteger length))ajRandom;

/// 16进制字符串转换成10进制字符串
/// @return NSString* 10进制字符串
- (NSString *)ajHexToDecimal;

/// 10进制字符串转换成16进制字符串
/// @return NSString* 16进制字符串
- (NSString *)ajDecimalToHex;

/// 是否是中文
/// @return BOOL 是否是中文
- (BOOL)ajIsChinese;

/// 正则匹配
/// @return BOOL 是否匹配
- (BOOL (^)(NSString *regex))ajMatchesRegex;

/// 过滤空格
/// @return NSString* 过滤后的字符串
- (NSString *)ajClearWhiteSpace;

/// 过滤空格和换行
/// @return NSString* 过滤后的字符串
- (NSString *)ajClearWhiteSpaceAndNewLine;

/// 判断是否包含某个字符串
/// @param NSString* 被包含字符串
/// @return BOOL 是否包含
- (BOOL (^)(NSString *containsString))ajContainsString;

/// 将字符串转成NSNumber
/// @return NSNumber* number
- (NSNumber *)ajNumberValue;

/// 将字符串转换成NSData类型
/// @return NSData* data
- (NSData *)ajDataValue;

/// 将 日期字符串 通过 格式化 转换成 时间对象
/// @param NSString* 时间格式
/// @return NSDate* date对象
- (NSDate * (^)(NSString *format))ajDateValue;

/// 颜色hexString转成UIColor
/// @return UIColor* color对象
- (UIColor *)ajColorValue;

/// 判断邮箱格式
/// @return BOOL 是否是邮箱格式
- (BOOL)ajIsEmail;

/// 判断手机号格式
/// @return BOOL 是否是手机号格式
- (BOOL)ajIsMobileNumber;

/// 判断是否是纯数字格式
/// @return BOOL 是否是纯数字格式
- (BOOL)ajIsNumber;

/// 判断是否是邮政编码格式
/// @return BOOL 是否是邮政编码格式
- (BOOL)ajIsPostalcode;

/// 判断是否是url格式
/// @return BOOL 是否是url格式
- (BOOL)ajIsUrl;

/// 判断是否是身份证号格式
/// @return BOOL 是否是身份证号格式
- (BOOL)ajIsIDCardNumber;

@end

NS_ASSUME_NONNULL_END
