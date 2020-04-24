//
//  UISearchBar+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "UISearchBar+AJKit.h"

@implementation UISearchBar (AJKit)

- (void)ajSetTextFiledBackgroundColor:(UIColor *)color {
    for (UIView *view in self.subviews) {
      for (id subview in view.subviews) {
        if ([subview isKindOfClass:UITextField.class] ){
          [(UITextField *)subview setBackgroundColor:color];
          break;
        }
      }
    }
}

- (void)ajSetTextFiledTextColor:(UIColor *)color {
    for (UIView *view in self.subviews) {
        for (id subview in view.subviews) {
            if ([subview isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *)subview;
                textField.textColor = color;
            }
        }
    }
}

- (void)ajSetTextFieldTextFont:(CGFloat)font {
    for (UIView *view in self.subviews) {
        for (id subview in view.subviews) {
            if ([subview isKindOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *)subview;
                textField.font = [UIFont systemFontOfSize:font];
            }
        }
    }
}

- (void)ajSetTextFieldFocusColor:(UIColor *)color {
    [[[self.subviews objectAtIndex:0].subviews objectAtIndex:1] setTintColor:color];
}

- (void)ajSetBarBackgroundColor:(UIColor *)color {
    for (UIView *view in self.subviews) {
      for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
          [subview removeFromSuperview];
          
          UIView *bgview = [[UIView alloc] initWithFrame:self.frame];
          view.backgroundColor = color;
          [subview.superview addSubview:bgview];
          break;
        }
      }
    }
}

@end
