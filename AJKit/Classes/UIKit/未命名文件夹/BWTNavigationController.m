//
//  KLNavigationController.m
//  BWTon 自定义导航
//
//  Created by HuHao on 17/4/9.
//  Copyright (c) 2017年 BWTon. All rights reserved.
//

#import "BWTNavigationController.h"
#import "BWTKitMacro.h"

@interface BWTNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIViewController *currentShowVC;

@end

@implementation BWTNavigationController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  kWeakSelf;
  if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    self.interactivePopGestureRecognizer.delegate = weakSelf;
    self.delegate = weakSelf;
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  BWTLog(@"内存不足...");
}


#pragma mark - UINavigationControllerDelegate


- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
  
  if (navigationController.viewControllers.count == 1) {
    self.currentShowVC = nil;
  } else {
    self.currentShowVC = viewController;
  }
  
  BWTLog(@"didShowViewController >>>> %@", viewController);
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
  
  BWTLog(@"willShowViewController >>>> %@", viewController);
  
}




#pragma mark - Gesture Delegate Method

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (gestureRecognizer == self.interactivePopGestureRecognizer) {
            return (self.currentShowVC == self.topViewController);
        }
    }

    return YES;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    
}

- (void)replaceLastViewController:(UIViewController *)vc {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.viewControllers];
    [array removeLastObject];
    [array addObject:vc];
    self.viewControllers = array;
}

- (void)addViewController:(UIViewController *)vc {
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.viewControllers];
    [array addObject:vc];
    [vc addChildViewController:vc]
    self.viewControllers = array;
}

@end
