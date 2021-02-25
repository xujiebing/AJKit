//
//  UIColor+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/29.
//

#import <UIKit/UIKit.h>

static UIColor *AJDynamicColor(UIColor *lightColor, UIColor *darkColor) {
    if (@available(iOS 13.0, *)) {
        UIColor * (^block)(UITraitCollection *) = ^(UITraitCollection * _Nonnull traitCollection){
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkColor;
            } else {
                return lightColor;
            }
        };
        UIColor *color = [UIColor colorWithDynamicProvider:block];
        return color;
    }
    return lightColor;
}

static UIColor *AJUIColorFrom10RGB(NSInteger red, NSInteger green, NSInteger blue) {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

static UIColor *AJUIColorFrom10RGBA(NSInteger red, NSInteger green, NSInteger blue, float alpha) {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

static UIColor *AJUIColorFrom16RGB(NSInteger rgbValue) {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

static UIColor *AJUIColorFrom16RGBA(NSInteger rgbValue, float alpha) {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alpha];
}

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (AJKit)

/// UIColor对象转hexString
/// @return NSString* hexString
- (NSString *)ajToHexString;

/// 颜色转换成图片
/// @return 图片
- (UIImage *)ajImage;

/// 颜色转换成图片
/// @param size size
- (UIImage *)ajImageWithSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
