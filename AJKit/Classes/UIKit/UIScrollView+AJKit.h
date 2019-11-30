//
//  UIScrollView+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (AJKit)

- (void (^)(BOOL animated))ajScrollToTopAnimated;

- (void (^)(BOOL animated))ajScrollToBottomAnimated;

- (void (^)(BOOL animated))ajScrollToLeftAnimated;

- (void (^)(BOOL animated))ajScrollToRightAnimated;

@end

NS_ASSUME_NONNULL_END
