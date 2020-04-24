//
//  AJSSKeychain+AJExt.h
//  AJKit 存储最常用的数据, 数据是存储在系统密钥中
//
//  Created by xujiebing on 2017/6/9.
//
//

#import "AJSSKeychain.h"

@interface AJSSKeychain (AJKit)

/**
 登录Token

 @return 返回当前用户登录信息
 */
+ (NSString *)accessToken;

/**
 登录账号名
 
 @return 返回登录账户名
 */
+ (NSString *)accountName;

/**
 设置token

 @param accessToken 用户token
 @return 设置是否成功
 */
+ (BOOL)setAccessToken:(NSString *)accessToken;

/**
 设置账号名

 @param name 账户名
 @return 是否保存成功
 */
+ (BOOL)setAccountName:(NSString *)name;

@end
