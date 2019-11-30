//
//  UIColor+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/29.
//

#import "UIColor+AJKit.h"

@implementation UIColor (AJKit)

- (NSString *)toHexString {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString = [NSString stringWithFormat:@"#%02lX%02lX%02lX",lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
    return hexString;
}

- (UIImage *)ajImage {
    return self.ajImageWithSize(CGSizeMake(1, 1));
}

- (UIImage * _Nonnull (^)(CGSize))ajImageWithSize {
    UIImage * (^block)(CGSize) = ^(CGSize size) {
        UIImage *image = nil;
        if (size.width <= 0 || size.height <= 0) {
            return image;
        }
        CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, self.CGColor);
        CGContextFillRect(context, rect);
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    };
    return block;
}

@end
