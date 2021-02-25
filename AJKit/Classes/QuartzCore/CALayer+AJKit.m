//
//  CALayer+AJKit.m
//  AJAD
//
//  Created by 徐结兵 on 2020/4/15.
//

#import "CALayer+AJKit.h"

@implementation CALayer (AJKit)

- (BOOL)ajMethodUndefinedCrash {
    return NO;
}

+ (CAShapeLayer *)ajCreateCloseLayer:(CGSize)size
                                color:(UIColor *)color
                          strokeWidth:(CGFloat)strokeWidth {
    CAShapeLayer *closelayer = [[CAShapeLayer alloc]init];
    closelayer.strokeColor = color.CGColor;
    closelayer.lineWidth = strokeWidth;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIBezierPath *closePath = [UIBezierPath bezierPath];
        [closePath moveToPoint:CGPointMake(0,0)];
        [closePath addLineToPoint:CGPointMake(size.width, size.height)];
        
        [closePath moveToPoint:CGPointMake(size.width,0)];
        [closePath addLineToPoint:CGPointMake(0, size.height)];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            closelayer.path = closePath.CGPath;
        });
    });
    return closelayer;
}

+ (CAShapeLayer *)ajCreatePlusLayer:(CGSize)size
                               color:(UIColor *)color
                         strokeWidth:(CGFloat)strokeWidth
                               isAdd:(BOOL)isAdd {    
    CAShapeLayer *pluslayer = [[CAShapeLayer alloc]init];
    pluslayer.strokeColor = color.CGColor;
    pluslayer.lineWidth = strokeWidth;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGFloat plusWidth = size.width / 2;
        UIBezierPath *plusPath = [UIBezierPath bezierPath];
        [plusPath moveToPoint:CGPointMake(size.width / 2. - plusWidth / 2. + 0.5, size.height / 2. + 0.5)];
        [plusPath addLineToPoint:CGPointMake(size.width / 2. + plusWidth / 2. + 0.5, size.height / 2. + 0.5)];
        
        if(isAdd){
            [plusPath moveToPoint:CGPointMake(size.width / 2. + 0.5, size.height / 2. - plusWidth / 2. + 0.5)];
            [plusPath addLineToPoint:CGPointMake(size.width / 2. + 0.5, size.height / 2. + plusWidth / 2. + 0.5)];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            pluslayer.path = plusPath.CGPath;
        });
    });
    
    return pluslayer;
}
@end
