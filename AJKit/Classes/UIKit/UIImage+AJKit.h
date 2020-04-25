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
/// @param rect 大小
/// @param contentMode contentMode
- (void)ajDrawInRect:(CGRect)rect contentModel:(UIViewContentMode)contentMode;

/// 生成一张圆角图片
/// @param rect 大小
/// @param radius 圆角弧度
- (UIImage *)ajRoundImageWithFrame:(CGRect)rect radius:(NSInteger)radius;

/// 图片压缩到指定大小
/// @param size 大小
- (UIImage *)ajCompressToSize:(CGSize)size;

/// 图片压缩到指定大小（不失真）
/// @param size 大小
- (UIImage *)ajRealCompressToSize:(CGSize)size;

/// image to data
- (NSData *)ajDataValue;


@end

NS_ASSUME_NONNULL_END
