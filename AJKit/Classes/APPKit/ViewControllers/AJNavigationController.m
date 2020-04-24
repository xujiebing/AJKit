//
//  AJNavigationController.m
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import "AJNavigationController.h"

@interface AJNavigationController ()

@property (nonatomic, weak) UIViewController *currentShowVC;

@end

@implementation AJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_ajInitView];
}

- (void)p_ajInitView {
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
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
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    
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

@end
