//
//  AJTools.h
//  AJon
//
//  Created by HuHao on 15/9/28.
//  Copyright © 2015年 AJon. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kIPAddress @"kIPAddress"        // IP地址，如果空则取宏
#define kIPIdentification @"##%%"       // 识别切换IP的标识


static inline uint64_t CurrentTimeMillis() {
    return (uint64_t)([[NSDate date] timeIntervalSince1970] * 1000);
}

@interface AJTools : NSObject


+ (NSString *)p_encryptForPlainText:(NSString *)plainText;

/**
 跳转到系统设置-定位设置
 */
+ (void)openLocationSettingPage;

/**
 跳转到系统设置-麦克风设置
 */
+ (void)openMicrophoneSettingPage;

/**
 打开WiFi设置
 */
+ (void)openWiFiSettingPage;

/**
 打开设置
 */
+ (void)openSettingPage;

/**
 URL处理

 @param url 其他App发起的URL
 */
+ (void)handleURL:(nullable NSString *)url;

/**
 根据文件名读取plist文件的内容

 @param fileName 文件名
 @return 返回字典类型的数据
 */
+ (nullable NSDictionary *)plistContentWithName:(nonnull NSString *)fileName;

/**
判断IPA二进制文件是否被篡改(破解)
IPA完整性检测
注:如果替换资源文件，比如图片、plist文件等是没有SignerIdentity这个值的
@return YES-是 NO-否
*/
+ (BOOL)checkSimpleCracking;

/**
 获取跳转设置页面的url
 
 @param keyName key
 @return 设置页面url
 */
+ (NSString * _Nonnull)getPrefskeyWith:(NSString *_Nonnull)keyName;

@end





