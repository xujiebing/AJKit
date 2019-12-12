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

typedef void(^AJAlertHandler)(AJAlertTag buttonTag, NSString *buttonTitle);

NS_ASSUME_NONNULL_BEGIN

@interface AJAlert : NSObject

/**
 一个按钮的alert(包含title、content)

 @param title 标题
 @param content 内容
 @param buttonTitle 按钮
 @param handler 回调
 */
+ (void)alertWithTitle:(NSString * _Nonnull )title
               content:(NSString * _Nonnull )content
                  done:(NSString * _Nonnull )done
                cancel:(NSString * _Nonnull )cancel
               handler:(AJAlertHandler _Nullable )handler;

@end

NS_ASSUME_NONNULL_END
