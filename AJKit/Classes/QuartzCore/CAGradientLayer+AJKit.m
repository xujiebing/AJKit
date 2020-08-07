//
//  CAGradientLayer+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2020/8/6.
//

#import "CAGradientLayer+AJKit.h"

@implementation CAGradientLayer (AJKit)

+ (void)ajHorizontalGradientLayer:(UIView *)view
                       startColor:(UIColor *)startColor
                         endColor:(UIColor *)endColor {
    if (!view || !startColor || !endColor) {
        return;
    }
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, view.ajWidth, view.ajHeight);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)startColor.CGColor,(__bridge id)endColor.CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    [view.layer insertSublayer:gl atIndex:0];
}

@end
