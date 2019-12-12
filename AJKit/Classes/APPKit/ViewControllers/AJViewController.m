//
//  AJViewController.m
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import "AJViewController.h"

@interface AJViewController ()

@end

@implementation AJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_ajInitView];
    [self ajInitData];
    [self ajInitView];
}

- (void)p_ajInitView {
    self.navigationController.navigationBar.translucent = NO;
    if (self.navigationController.viewControllers.count > 1) {
        UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] pathForResource:@"AJAPPKit" ofType:@"bundle"], @"ajappkit_icon_back"]];;
        self.navigationItem.ajAddLeftButtonWithImage(image, self, @selector(p_ajBack));
    }
}

- (void)ajInitData {
    
}

- (void)ajInitView {
    
}

- (void)p_ajBack {
    if(self.presentingViewController && self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
