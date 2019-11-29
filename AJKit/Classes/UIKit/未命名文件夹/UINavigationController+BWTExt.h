//
//  UINavigationController+BWTExt.h
//  BWTon
//
//  Created by HuHao on 15/10/2.
//  Copyright © 2015年 BWTon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NavigationAlphaBlock) ();

@interface UINavigationController (BWTExt)


@property (nonatomic, readonly) UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer;


@end
