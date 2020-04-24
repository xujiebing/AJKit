//
//  NSError+AJKit.h
//  AJAD
//
//  Created by 徐结兵 on 2020/4/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AJErrorCode) {
    AJNormalError = 80001,             // Toast提醒，显示错误之后自动隐藏
    AJNormalSuccess = 80002,           // Toast提醒，显示成功之后自动隐藏
    AJAlertAndLoginError = 80003,      // Alert提醒, 点击确定之后需要跳转登录, 不可取消
    AJAppUpdatePrompt = 80004,         // Alert提醒, 点击确定之后需要跳转到升级页面, 可取消
    AJAlertError = 80005,              // Alert提醒, 点击确定无操作
    AJNeedLogin = 80006,               // 不给提示, 直接跳转到登录页面
    AJNotNetwork = 80007,              // Alert提醒 无网络, 需要弹出提示, 用户需要点击重试
    AJNotError = 90035,                // 不给提示，无异常，正常状态
    AJOtherError = 90045,              // 不给提示，其他错误, 其他错误需要自行处理
};

static NSString *AJErrorDomain = @"com.bwtonon.app";

static NSError *AJError(AJErrorCode code, NSString *message) {
    return [NSError errorWithDomain:AJErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey: AJNil(message)}];
}

@interface NSError (AJKit)

@property (nonatomic, copy, readonly) NSString *errorCode;

@property (nonatomic, copy, readonly) NSString *errorMessage;

@end

NS_ASSUME_NONNULL_END
