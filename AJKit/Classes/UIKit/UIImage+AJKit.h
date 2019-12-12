//
//  UIImage+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (AJKit)

/// 根据CGRect、contentMode 画对应的图片
/// @param CGRect 大小
/// @param UIViewContentMode contentMode
- (void (^)(CGRect rect, UIViewContentMode contentMode))ajDrawInRectAndContentMode;

/// 生成一张圆角图片
/// @param CGRect 大小
/// @param NSInteger 圆角弧度
/// @return UIImage* 圆角图片
- (UIImage * (^)(CGRect rect, NSInteger radius))ajRoundImageWithFrameAndRadius;

/// 图片压缩到指定大小
/// @param CGSize 大小
/// @return UIImage* 压缩后的图片
- (UIImage * (^)(CGSize size))ajCompressToSize;

/// 图片压缩到指定大小（不失真）
/// @param CGSize 大小
/// @return UIImage* 压缩后的图片
- (UIImage * (^)(CGSize size))ajRealCompressToSize;

/// image to data
- (NSData *)ajDataValue;


@end

NS_ASSUME_NONNULL_END
