//
//  UITextField+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "UITextField+AJKit.h"
#import <objc/runtime.h>

static NSString * const AJUITextFieldLimitInput = @"AJUITextFieldLimitInput";

@implementation UITextField (AJKit)

- (NSRange)ajSelectedRange {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}

- (void)ajSetSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

#pragma mark - 内部方法

- (void)p_textFieldViewDidChange:(NSNotification*)notification {
    NSInteger limit = self.ajLimitInput;
    if (limit && self.text.length > limit && self.markedTextRange == nil) {
        self.text = [self.text substringWithRange:NSMakeRange(0, limit)];
    }
}

#pragma mark - 动态属性

- (void)setLimitInput:(NSInteger)limitInput {
    [NSNotificationCenter.defaultCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(p_textFieldViewDidChange:)
                                               name:UITextFieldTextDidChangeNotification
                                             object:nil];
    NSNumber *number = [NSNumber numberWithInteger:limitInput];
    objc_setAssociatedObject(self, &AJUITextFieldLimitInput, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)limitInput {
    NSNumber *number = objc_getAssociatedObject(self, &AJUITextFieldLimitInput);
    return number.integerValue;
}

@end
