//
//  UITextView+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "UITextView+AJKit.h"

static NSString * const AJUITextViewLimitInput = @"AJUITextViewLimitInput";

@implementation UITextView (AJKit)

#pragma mark - 内部方法

- (void)p_textViewDidChange:(NSNotification *)notificaiton {
    NSInteger limit = self.ajLimitInput;
    if (limit && self.text.length > limit && self.markedTextRange == nil) {
        self.text = [self.text substringWithRange: NSMakeRange(0, limit)];
    }
}

#pragma mark - 动态属性

- (void)setLimitInput:(NSInteger)limitInput {
    [NSNotificationCenter.defaultCenter removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(p_textViewDidChange:)
                                               name:UITextViewTextDidChangeNotification
                                             object:nil];
    NSNumber *number = [NSNumber numberWithInteger:limitInput];
    objc_setAssociatedObject(self, &AJUITextViewLimitInput, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)limitInput {
    NSNumber *number = objc_getAssociatedObject(self, &AJUITextViewLimitInput);
    return number.integerValue;
}

@end
