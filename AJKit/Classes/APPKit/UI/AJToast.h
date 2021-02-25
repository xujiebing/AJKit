//
//  AJToast.h
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJToast : NSObject

/**
 HUD 异常信息弹窗

 @param message 异常信息
 */
+ (void)showError:(NSString * _Nonnull )message;

/**
 HUD 信息提示弹窗

 @param message 提示信息
 */
+ (void)showInfo:(NSString * _Nonnull )message;

/**
 HUD 成功信息弹窗

 @param message 成功信息
 */
+ (void)showSuccess:(NSString * _Nonnull )message;

@end

NS_ASSUME_NONNULL_END
