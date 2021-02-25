//
//  AJAlert.m
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import "AJAlert.h"

@implementation AJAlert

+ (void)alertWithTitle:(NSString *)title
              content:(NSString *)content
                 done:(NSString *)done
               cancel:(NSString *)cancel
              handler:(AJAlertHandler)handler {
    UIAlertController *alertController = nil;
    alertController = [UIAlertController alertControllerWithTitle:title
                                                          message:content
                                                   preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             if (!handler) {
                                                                 return ;
                                                             }
                                                             handler(AJAlertCancel, action.title);
                                                         }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:done
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       if (!handler) {
                                                           return ;
                                                       }
                                                       handler(AJAlertDone, action.title);
                                                   }];
    [alertController addAction:action];
    UIViewController *lastVC = UIViewController.ajCurrentViewController;
    [lastVC presentViewController:alertController animated:YES completion:nil];
}


+ (void)alertWithTitle:(NSString *)title
              content:(NSString *)content
                 done:(NSString *)done
              handler:(AJAlertHandler)handler {
    UIAlertController *alertController = nil;
    alertController = [UIAlertController alertControllerWithTitle:title
                                                          message:content
                                                   preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:done
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       if (!handler) {
                                                           return ;
                                                       }
                                                       handler(AJAlertDone, action.title);
                                                   }];
    [alertController addAction:action];
    UIViewController *lastVC = UIViewController.ajCurrentViewController;
    [lastVC presentViewController:alertController animated:YES completion:nil];
}

@end
