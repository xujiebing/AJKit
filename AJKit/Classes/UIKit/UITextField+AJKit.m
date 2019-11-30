//
//  UITextField+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "UITextField+AJKit.h"

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

- (void (^)(NSRange))ajSetSelectedRange {
    kAJWeakSelf
    void (^block)(NSRange) = ^(NSRange range){
        UITextPosition *beginning = ajSelf.beginningOfDocument;
        UITextPosition *startPosition = [ajSelf positionFromPosition:beginning offset:range.location];
        UITextPosition *endPosition = [ajSelf positionFromPosition:beginning offset:range.location + range.length];
        UITextRange *selectionRange = [ajSelf textRangeFromPosition:startPosition toPosition:endPosition];
        [ajSelf setSelectedTextRange:selectionRange];
    };
    return block;
}

#pragma mark - 内部方法

- (void)p_textFieldViewDidChange:(NSNotification*)notification {
    UITextField *textField = notification.object;
    NSNumber *number = [textField valueForKey:@""];
    if (number && textField.text.length > [number integerValue] && textField.markedTextRange == nil) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, [number integerValue])];
    }
}

#pragma mark - 动态属性

- (void)setLimitInput:(NSInteger)limitInput {
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
