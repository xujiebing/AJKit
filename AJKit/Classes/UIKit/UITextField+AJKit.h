//
//  UITextField+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField ()

/// 设置最大输入长度限制
@property (nonatomic, assign, readwrite) NSInteger ajLimitInput;

@end

@interface UITextField (AJKit)

/// 获取光标选中区域
/// @return NSRange 当前光标选中区域
- (NSRange)ajSelectedRange;

/// 设置光标选中区域
/// @param range range区域
- (void)ajSetSelectedRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
