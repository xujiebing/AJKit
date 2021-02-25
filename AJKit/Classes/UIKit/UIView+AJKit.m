//
//  UIView+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/29.
//

#import "UIView+AJKit.h"

@implementation UIView (AJKit)

- (void)setAjX:(CGFloat)ajX {
    CGRect frame = self.frame;
    frame.origin.x = ajX;
    self.frame = frame;
}

- (CGFloat)ajX {
    return self.frame.origin.x;
}

- (void)setAjY:(CGFloat)ajY {
    CGRect frame = self.frame;
    frame.origin.y = ajY;
    self.frame = frame;
}

- (CGFloat)ajY {
    return self.frame.origin.y;
}

- (void)setAjCenterX:(CGFloat)ajCenterX {
    CGPoint center = self.center;
    center.x = ajCenterX;
    self.center = center;
}

- (CGFloat)ajCenterX {
    return self.center.x;
}

- (void)setAjCenterY:(CGFloat)ajCenterY {
    CGPoint center = self.center;
    center.y = ajCenterY;
    self.center = center;
}

- (CGFloat)ajCenterY {
    return self.center.y;
}

- (void)setAjWidth:(CGFloat)ajWidth {
    CGRect frame = self.frame;
    frame.size.width = ajWidth;
    self.frame = frame;
}

- (CGFloat)ajWidth {
    return self.frame.size.width;
}

- (void)setAjHeight:(CGFloat)ajHeight {
    CGRect frame = self.frame;
    frame.size.height = ajHeight;
    self.frame = frame;
}

- (CGFloat)ajHeight {
    return self.frame.size.height;
}

- (void)setAjSize:(CGSize)ajSize {
    CGRect frame = self.frame;
    frame.size = ajSize;
    self.frame = frame;
}

- (CGSize)ajSize {
    return self.frame.size;
}

- (void)setAjOrigin:(CGPoint)ajOrigin {
    CGRect frame = self.frame;
    frame.origin = ajOrigin;
    self.frame = frame;
}

- (CGPoint)ajOrigin {
    return self.frame.origin;
}

- (void)ajAddCorners:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)ajAddRectCorners:(CGFloat)radius rectCorners:(UIRectCorner)rectCorners {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)ajAddBorder:(CGFloat)width color:(UIColor *)color {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

@end
