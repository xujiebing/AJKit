//
//  UIScreen+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2020/4/24.
//

#import "UIScreen+AJKit.h"

@implementation UIScreen (AJKit)

+ (CGRect)ajBounds {
    return UIScreen.mainScreen.bounds;
}

+ (CGFloat)ajWidth {
    return UIScreen.ajBounds.size.width;
}

+ (CGFloat)ajHeight {
    return UIScreen.ajBounds.size.height;
}

+ (CGFloat)ajViewHeight {
    CGFloat height = UIScreen.ajHeight;
    if (height >= 812) {
        return height - 44 - 20 - 24;
    }
    return height - 44 - 20;
}

@end
