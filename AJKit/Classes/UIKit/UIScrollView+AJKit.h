//
//  UIScrollView+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (AJKit)

- (void)ajScrollToTopAnimated:(BOOL)animated;

- (void)ajScrollToBottomAnimated:(BOOL)animated;

- (void)ajScrollToLeftAnimated:(BOOL)animated;

- (void)ajScrollToRightAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
