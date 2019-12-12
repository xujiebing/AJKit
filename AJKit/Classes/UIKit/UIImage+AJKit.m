//
//  UIImage+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/29.
//

#import "UIImage+AJKit.h"

@implementation UIImage (AJKit)

- (void (^)(CGRect, UIViewContentMode))ajDrawInRectAndContentMode {
    kAJWeakSelf
    void (^block)(CGRect, UIViewContentMode) = ^(CGRect rect, UIViewContentMode contentMode){
        CGRect drawRect;
        CGSize size = ajSelf.size;
        switch (contentMode) {
            case UIViewContentModeRedraw:
            case UIViewContentModeScaleToFill: {
                [ajSelf drawInRect:rect];
                return;
            }
            case UIViewContentModeScaleAspectFit: {
                CGFloat factor;
                if (size.width < size.height) {
                    factor = rect.size.height / size.height;
                } else {
                    factor = rect.size.width / size.width;
                }
                size.width = roundf(size.width * factor);
                size.height = roundf(size.height * factor);
                drawRect = CGRectMake(roundf(CGRectGetMidX(rect) - size.width / 2.0f),
                                      roundf(CGRectGetMidY(rect) - size.height / 2.0f),
                                      size.width,
                                      size.height);
            } break;
                
            case UIViewContentModeScaleAspectFill: {
                CGFloat factor;
                if (size.width < size.height) {
                    factor = rect.size.width / size.width;
                } else {
                    factor = rect.size.height / size.height;
                }
                size.width = roundf(size.width * factor);
                size.height = roundf(size.height * factor);
                drawRect = CGRectMake(roundf(CGRectGetMidX(rect) - size.width / 2.0f),
                                      roundf(CGRectGetMidY(rect) - size.height / 2.0f),
                                      size.width,
                                      size.height);
            } break;
                
            case UIViewContentModeCenter: {
                drawRect = CGRectMake(roundf(CGRectGetMidX(rect) - size.width / 2.0f),
                                      roundf(CGRectGetMidY(rect) - size.height / 2.0f),
                                      size.width,
                                      size.height);
            } break;
                
            case UIViewContentModeTop: {
                drawRect = CGRectMake(roundf(CGRectGetMidX(rect) - size.width / 2.0f),
                                      rect.origin.y - size.height,
                                      size.width,
                                      size.height);
            } break;
                
            case UIViewContentModeBottom: {
                drawRect = CGRectMake(roundf(CGRectGetMidX(rect) - size.width / 2.0f),
                                      rect.origin.y - size.height,
                                      size.width,
                                      size.height);
            }  break;
                
            case UIViewContentModeLeft: {
                drawRect = CGRectMake(rect.origin.x,
                                      roundf(CGRectGetMidY(rect) - size.height / 2.0f),
                                      size.width,
                                      size.height);
            } break;
                
            case UIViewContentModeRight: {
                drawRect = CGRectMake(CGRectGetMaxX(rect) - size.width,
                                      roundf(CGRectGetMidY(rect) - size.height / 2.0f),
                                      size.width,
                                      size.height);
            } break;
                
            case UIViewContentModeTopLeft: {
                drawRect = CGRectMake(rect.origin.x,
                                      rect.origin.y,
                                      size.width,
                                      size.height);
            } break;
                
            case UIViewContentModeTopRight: {
                drawRect = CGRectMake(CGRectGetMaxX(rect) - size.width,
                                      rect.origin.y,
                                      size.width,
                                      size.height);
            } break;
                
            case UIViewContentModeBottomLeft: {
                drawRect = CGRectMake(rect.origin.x,
                                      CGRectGetMaxY(rect) - size.height,
                                      size.width,
                                      size.height);
            } break;
                
            case UIViewContentModeBottomRight: {
                drawRect = CGRectMake(CGRectGetMaxX(rect) - size.width,
                                      CGRectGetMaxY(rect) - size.height,
                                      size.width,
                                      size.height);
            } break;
            default: return;
        }
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        CGContextAddRect(context, rect);
        CGContextClip(context);
        [ajSelf drawInRect:drawRect];
        CGContextRestoreGState(context);
    };
    return block;
}

- (UIImage * _Nonnull (^)(CGRect, NSInteger))ajRoundImageWithFrameAndRadius {
    kAJWeakSelf
    UIImage * (^block)(CGRect, NSInteger) = ^(CGRect rect, NSInteger radius){
        UIImage *newImage;
        CGSize size = rect.size;
        CGRect bounds = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        [[UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:radius] addClip];
        [ajSelf drawInRect:bounds];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    };
    return block;
}

- (UIImage * _Nonnull (^)(CGSize))ajCompressToSize {
    kAJWeakSelf
    UIImage * (^block)(CGSize) = ^(CGSize size){
        UIImage *sourceImage = ajSelf;
        UIImage *newImage = nil;
        CGSize imageSize = sourceImage.size;
        CGFloat width = imageSize.width;
        CGFloat height = imageSize.height;
        CGFloat targetWidth = size.width;
        CGFloat targetHeight = size.height;
        CGFloat scaleFactor = 0.0;
        CGFloat scaledWidth = targetWidth;
        CGFloat scaledHeight = targetHeight;
        CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
        if (!CGSizeEqualToSize(imageSize, size)) {
            CGFloat widthFactor = targetWidth / width;
            CGFloat heightFactor = targetHeight / height;
            if (widthFactor > heightFactor) {
                scaleFactor = widthFactor; // scale to fit height
            } else {
                scaleFactor = heightFactor; // scale to fit width
            }
            scaledWidth= width * scaleFactor;
            scaledHeight = height * scaleFactor;
            // center the image
            if (widthFactor > heightFactor) {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            } else if (widthFactor < heightFactor) {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
        }
        
        UIGraphicsBeginImageContext(size); // this will crop
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width= scaledWidth;
        thumbnailRect.size.height = scaledHeight;
        [sourceImage drawInRect:thumbnailRect];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        if(!newImage) {
            UIGraphicsEndImageContext();
        }
        return newImage;
    };
    return block;
}

- (UIImage * _Nonnull (^)(CGSize))ajRealCompressToSize {
    kAJWeakSelf
    UIImage * (^block)(CGSize) = ^(CGSize size){
        //下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale * 2);
        [ajSelf drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //返回的就是已经改变的图片
        return scaledImage;
    };
    return block;
}

- (NSData *)ajDataValue {
    return UIImageJPEGRepresentation(self,1.0f);
}

@end
