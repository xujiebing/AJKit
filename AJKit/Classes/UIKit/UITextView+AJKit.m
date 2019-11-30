//
//  UITextView+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "UITextView+AJKit.h"

static NSString * const AJUITextViewLimitInput = @"AJUITextViewLimitInput";

@implementation UITextView (AJKit)

- (void (^)(NSInteger))ajLimitInpiut {
    kAJWeakSelf
    void (^block)(NSInteger) = ^(NSInteger limit) {
        [NSNotificationCenter.defaultCenter addObserver:ajSelf
                                               selector:@selector(p_textViewDidChange:)
                                                   name:UITextViewTextDidChangeNotification
                                                 object:nil];
    };
    return block;
}

#pragma mark - 内部方法

- (void)p_textViewDidChange:(NSNotification *)notificaiton {
    UITextView *textView = notificaiton.object;
    NSNumber *number = [textView valueForKey:@""];
    if (number && textView.text.length > [number integerValue] && textView.markedTextRange == nil) {
        textView.text = [textView.text substringWithRange: NSMakeRange(0, [number integerValue])];
    }
}

#pragma mark - 动态属性

- (void)setLimitInput:(NSInteger)limitInput {
    NSNumber *number = [NSNumber numberWithInteger:limitInput];
    objc_setAssociatedObject(self, &AJUITextViewLimitInput, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)limitInput {
    NSNumber *number = objc_getAssociatedObject(self, &AJUITextViewLimitInput);
    return number.integerValue;
}

@end
