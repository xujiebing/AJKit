//
//  UIScreen+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2020/4/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (AJKit)

@property (class, nonatomic, readonly) CGRect ajBounds;

@property (class, nonatomic, readonly) CGFloat ajWidth;

@property (class, nonatomic, readonly) CGFloat ajHeight;

@property (class, nonatomic, readonly) CGFloat ajViewHeight;

@property (class, nonatomic, assign, readonly) BOOL ajIsIphone4;

@property (class, nonatomic, assign, readonly) BOOL ajIsIphone5;

@property (class, nonatomic, assign,readonly) BOOL ajIsIphone6;

@property (class, nonatomic, assign, readonly) BOOL ajIsIphone6P;

@property (class, nonatomic, assign, readonly) BOOL ajIsIphoneX;

@end

NS_ASSUME_NONNULL_END
