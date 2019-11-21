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
+ (BOOL (^)(NSString *))ajIsEmpty;

/// urlUTF8编码
- (NSString *)ajUrlEncodeUTF8;

/// url编码
- (NSString * (^)(NSStringEncoding))ajUrlEncode;

/// url UTF8解码
- (NSString *)ajUrlDecodeUTF8;

/// url解码
- (NSString * (^)(NSStringEncoding))ajUrlDecode;

/// 字符串转对象
+ (id (^)(NSString *))ajJsonObject;

/// 将base64编码的字符串转换成NSData
- (NSData *)ajBase64Decoding;

/// 根据文件名（包含后缀）获取文件内容
- (NSData *)ajFileData;

/// 随机批次号，时间+随机数
+ (NSString *)ajSequence;

/// 生成随机数
+ (NSString *(^)(NSInteger length))ajRandom;

/// 16进制字符串转换成10进制字符串
- (NSString *)ajHexToDecimal;

/// 10进制字符串转换成16进制字符串
- (NSString *)ajDecimalToHex;

/// base64编码
- (NSString *)ajBase64Encoding;

/// base64解码
- (NSString *)ajBase64Decode;

/// 是否是中文
- (BOOL)ajIsChinese;

/// 正则匹配
- (BOOL (^)(NSString *))ajMatchesRegex;

/// 过滤空格
- (NSString *)ajClearWhiteSpace;

/// 过滤空格和换行
- (NSString *)ajClearWhiteSpaceAndNewLine;

/// 判断是否包含某个字符串
- (BOOL (^)(NSString *))ajContainsString;

/// 将字符串转成NSNumber
- (NSNumber *)ajNumberValue;

/// 将字符串转换成NSData类型
- (NSData *)ajDataValue;

/// 判断邮箱格式
- (BOOL)ajIsEmail;

/// 判断手机号格式
- (BOOL)ajIsMobileNumber;

/// 判断是否是纯数字格式
- (BOOL)ajIsNumber;

/// 判断是否是邮政编码格式
- (BOOL)ajIsPostalcode;

/// 判断是否是url格式
- (BOOL)ajIsUrl;

/// 判断是否是身份证号格式
- (BOOL)ajIsIDCardNumber;

/// 将 日期字符串 通过 格式化 转换成 时间对象
- (NSDate * (^)(NSString *format))ajDateValue;

@end

NS_ASSUME_NONNULL_END
