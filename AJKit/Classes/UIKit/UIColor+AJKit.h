//
//  UIColor+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (AJKit)

/// UIColor对象转hexString
/// @return NSString* hexString
- (NSString *)toHexString;

/// 颜色转换成图片
/// @return 图片
- (UIImage *)ajImage;

/// 颜色转换成图片
/// @param CGSize 大小
/// @return 图片
- (UIImage * (^)(CGSize size))ajImageWithSize;

@end

NS_ASSUME_NONNULL_END
