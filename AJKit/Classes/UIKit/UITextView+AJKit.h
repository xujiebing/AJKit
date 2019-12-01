//
//  UITextView+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView ()

/// 设置最大输入长度限制
@property (nonatomic, assign, readwrite) NSInteger ajLimitInput;

@end

@interface UITextView (AJKit)

@end

NS_ASSUME_NONNULL_END
