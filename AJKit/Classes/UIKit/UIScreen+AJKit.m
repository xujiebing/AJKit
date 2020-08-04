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

+ (BOOL)ajIsIphone4 {
    return UIScreen.ajHeight < 568.0000;
}

+ (BOOL)ajIsIphone5 {
    return UIScreen.ajHeight == 568.0000;
}

+ (BOOL)ajIsIphone6 {
    return UIScreen.ajHeight == 667.0000;
}

+ (BOOL)ajIsIphone6P {
    return UIScreen.ajHeight == 736.0000;
}

+ (BOOL)ajIsIphoneX {
    return UIScreen.ajHeight >= 812.0000;
}

@end
