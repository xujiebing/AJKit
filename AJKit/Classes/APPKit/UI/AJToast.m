//
//  AJToast.m
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import "AJToast.h"

@implementation AJToast

+ (void)load {
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

// HUD 异常信息弹窗
+ (void)showError:(NSString *)message {
    if (!message || message.length == 0) {
        AJLog(@"HUD 信息为空");
        return;
    }
    [SVProgressHUD showErrorWithStatus:message];
}

// HUD 信息提示弹窗
+ (void)showInfo:(NSString *)message {
    if (!message || message.length == 0) {
        AJLog(@"HUD 信息为空");
        return;
    }
    [SVProgressHUD showInfoWithStatus:message];
}

// HUD 成功信息弹窗
+ (void)showSuccess:(NSString *)message {
    if (!message || message.length == 0) {
        AJLog(@"HUD 信息为空");
        return;
    }
    [SVProgressHUD showSuccessWithStatus:message];
}

@end
