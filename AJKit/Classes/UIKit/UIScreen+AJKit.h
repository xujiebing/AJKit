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

@end

NS_ASSUME_NONNULL_END
