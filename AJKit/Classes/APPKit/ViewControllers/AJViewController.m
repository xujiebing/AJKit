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
        kAJWeakSelf
        [self.navigationItem ajAddLeftButtonWithImage:AJImage(@"icon_back", AJKitModuleName) callback:^{
            [ajSelf p_ajBack];
        }];
    }
    [self.navigationController.navigationBar setTintColor:UIColor.blackColor];
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
