//
//  UISearchBar+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "UISearchBar+AJKit.h"

@implementation UISearchBar (AJKit)

- (void (^)(UIColor * _Nonnull))ajSetTextFiledBackgroundColor {
    kAJWeakSelf
    void (^block)(UIColor *) = ^(UIColor *color){
        for (UIView *view in ajSelf.subviews) {
          for (id subview in view.subviews) {
            if ([subview isKindOfClass:UITextField.class] ){
              [(UITextField *)subview setBackgroundColor:color];
              break;
            }
          }
        }
    };
    return block;
}

- (void (^)(UIColor * _Nonnull))ajSetTextFiledTextColor {
    kAJWeakSelf
    void (^block)(UIColor *) = ^(UIColor *color){
        for (UIView *view in ajSelf.subviews) {
            for (id subview in view.subviews) {
                if ([subview isKindOfClass:[UITextField class]]) {
                    UITextField *textField = (UITextField *)subview;
                    textField.textColor = color;
                }
            }
        }
    };
    return block;
}

- (void (^)(CGFloat))ajSetTextFieldTextFont {
    kAJWeakSelf
    void (^block)(CGFloat) = ^(CGFloat font){
        for (UIView *view in ajSelf.subviews) {
            for (id subview in view.subviews) {
                if ([subview isKindOfClass:[UITextField class]]) {
                    UITextField *textField = (UITextField *)subview;
                    textField.font = [UIFont systemFontOfSize:font];
                }
            }
        }
    };
    return block;
}

- (void (^)(UIColor * _Nonnull))ajSetTextFieldFocusColor {
    kAJWeakSelf
    void (^block)(UIColor *) = ^(UIColor *color){
        [[[ajSelf.subviews objectAtIndex:0].subviews objectAtIndex:1] setTintColor:color];
    };
    return block;
}

- (void (^)(UIColor * _Nonnull))ajSetBarBackgroundColor {
    kAJWeakSelf
    void (^block)(UIColor *) = ^(UIColor *color){
        for (UIView *view in ajSelf.subviews) {
          for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
              [subview removeFromSuperview];
              
              UIView *bgview = [[UIView alloc] initWithFrame:ajSelf.frame];
              view.backgroundColor = color;
              [subview.superview addSubview:bgview];
              break;
            }
          }
        }
    };
    return block;
}

@end
