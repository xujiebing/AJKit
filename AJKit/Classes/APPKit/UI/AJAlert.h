//
//  AJAlert.h
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    AJAlertDone,
    AJAlertCancel,
} AJAlertTag;

typedef void(^AJAlertHandler)(AJAlertTag buttonTag, NSString * _Nullable buttonTitle);

NS_ASSUME_NONNULL_BEGIN

@interface AJAlert : NSObject

/// alert
/// @param title 标题
/// @param content 内容
/// @param done 确定按钮
/// @param cancel 取消按钮
/// @param handler 回调
+ (void)alertWithTitle:(NSString * _Nullable )title
               content:(NSString * _Nullable )content
                  done:(NSString * _Nullable )done
                cancel:(NSString * _Nullable )cancel
               handler:(AJAlertHandler _Nullable )handler;

@end

NS_ASSUME_NONNULL_END
