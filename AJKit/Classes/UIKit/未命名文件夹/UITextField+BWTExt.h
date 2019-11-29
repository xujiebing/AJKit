//
//  UITextField+BWTExt.h
//  Pods
//
//  Created by BWTon. on 2017/7/16.
//
//

#import <UIKit/UIKit.h>

@interface UITextField (BWTExt)


/**
 获取光标选中区域

 @return 当前光标选中区域
 */
- (NSRange)selectedRange;


/**
 设置光标选中区域

 @param range 区域
 */
- (void)setSelectedRange:(NSRange)range;

@end
