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

- (void (^)(CGFloat))ajAddCorners {
    kAJWeakSelf
    void (^block)(CGFloat) = ^(CGFloat radius){
        ajSelf.layer.cornerRadius = radius;
        ajSelf.layer.masksToBounds = YES;
    };
    return block;
}

- (void (^)(CGFloat, UIRectCorner))ajAddRectCorners {
    kAJWeakSelf
    void (^block)(CGFloat, UIRectCorner) = ^(CGFloat radius, UIRectCorner rectCorners){
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:ajSelf.bounds byRoundingCorners:rectCorners cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = ajSelf.bounds;
        maskLayer.path = maskPath.CGPath;
        ajSelf.layer.mask = maskLayer;
    };
    return block;
}

- (void (^)(CGFloat, UIColor * _Nonnull))ajAddBorder {
    kAJWeakSelf
    void (^block)(CGFloat, UIColor *) = ^(CGFloat width, UIColor *color){
        ajSelf.layer.borderColor = color.CGColor;
        ajSelf.layer.borderWidth = width;
    };
    return block;
}


@end
