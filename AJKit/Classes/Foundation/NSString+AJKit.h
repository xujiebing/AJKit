//
//  NSString+AJKit.h
//  AJAD
//
//  Created by 徐结兵 on 2020/4/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AJKit)

/// 设备唯一标识 UUID 存放到系统，App卸载后再次安装也能获取到此UUID
@property(class, nonatomic, copy, readonly) NSString *ajDeviceUUID;

/// 随机生成一个UUID
@property(class, nonatomic, copy, readonly) NSString *ajStringWithUUID;

/// 序列号
@property(class, nonatomic, copy, readonly) NSString *ajSequence;

/// 判断字符串是否为空
+ (BOOL (^)(NSString *))ajIsEmpty;

/// url中参数转换成字典
- (NSDictionary *)ajQueryToDictionary;

/// int类型转NSString类型
+ (NSString * (^)(int))ajStringFromInt;

/// NSInteger类型转NSString类型
+ (NSString * (^)(NSInteger))ajStringFromInteger;

/// NSString -> NSData
- (NSData *)ajToData;

/// 将字符串MD5加密
- (NSString *)ajToMd5String;

/// 16进制字符串转换成10进制字符串
- (NSString *)ajToDecimal;

/// 10进制字符串转换成16进制字符串
- (NSString *)ajToHex;

/// 将字符串以base64编码
- (NSString *)ajBase64Encoding;

/// 将base64编码的字符串转换成NSData
- (NSData *)ajBase64EncodingData;

/// 将base64编码格式的字符串还原成明文字符串
- (NSString *)ajBase64Decoding;

/// 将字符串base64解码后转16进制
- (NSString *)ajBase64DecodingToHex;

/// 将字符串以URL编码, 编码格式为UTF8
- (NSString *)ajURLEncode;

/// 将字符串以URL解码成UTF8
- (NSString *)ajURLDecoding;

/// 判断是否纯汉字
- (BOOL)ajIsChinese;

/// 判断是否符合姓名规则
- (BOOL)ajIsNameRule;

/// 正则匹配
/// @param regex 正则表达式
- (BOOL)ajMatchesRegex:(NSString *)regex;

/// 将字符串过滤空格
- (NSString *)ajStringByTrimming;

/// 判断是否包含某个字符串
- (BOOL (^)(NSString *))ajContainsString;

/// 将字符串转成NSNumber
- (NSNumber *)ajToNumber;

/// 验证手机号码格式是否正确
- (BOOL)ajIsMobileNumber;

/// 验证是否为纯数字
- (BOOL)ajIsNumber;

/// 验证是否是money类型
- (BOOL)ajIsMoney;

/// 校验是否为邮箱
- (BOOL)ajIsEmailAddress;

/// 精确的身份证号码有效性检测
- (BOOL)ajAccurateVerifyIDCardNumber;

/// sha1加密方式
- (NSString *)ajSha1;

/// 根据字符串内容、字体大小、视图最大范围、lineBreakMode（换行模型） 计算出当前字符串所对应的视图大小
- (CGSize (^)(UIFont *, CGSize, NSLineBreakMode))ajSize;

/// 根据字体大小，宽度 计算出 视图高度
- (CGFloat (^)(UIFont *, CGFloat))ajSizeHeight;

/// 将 日期字符串 通过 格式化 转换成 时间对象
- (NSDate * (^)(NSString *))ajToDate;

/// 去除一个String里面的空格跟换行
- (NSString *)ajClearWhiteSpaceAndNewLine;

/// 在safari中打开url链接
- (void)ajOpenInSafari;

/// 颜色hexString转成UIColor
/// @return UIColor* color对象
- (UIColor *)ajToColor;

/// 富文本处理
/// @param targetString 目标文本
/// @param color 目标文本字体颜色
/// @param font 目标文本字体大小
- (NSMutableAttributedString *)ajAttributedString:(NSString *)targetString
                                            color:(UIColor *)color
                                             font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
