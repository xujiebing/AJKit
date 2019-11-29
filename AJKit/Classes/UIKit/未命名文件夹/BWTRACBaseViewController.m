//
//  BWTRACBaseViewController.m
//  BWTKit
//
//  Created by 胡浩 on 2017/11/30.
//  Copyright (c) 2017年 BWTon. All rights reserved.

#import "BWTRACBaseViewController.h"
#import "BWTRootNavigationController.h"
#import "UINavigationItem+BWTExt.h"
#import "UINavigationController+BWTExt.h"
#import "BWTLogTools.h"
#import <BWTBaseFramework/BWTKitMacro.h>
#import <BWTBaseFramework/BWTKit.h>
//#import "BWTRACBaseViewModel.h"
//#import "BWTBaseViewModel.h"

@interface BWTRACBaseViewController ()

@end

@implementation BWTRACBaseViewController


#pragma mark - 生命周期方法


- (void)dealloc {
    BWTLog(@"%@对象已销毁", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self base_initView];
    [self base_initData];

}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    BWTFileLog(Info, @"进入页面：%@", [self className]); //!OCLINT
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    BWTLog(@"内存不足")
    // FIXME: 需要将日志记录放在拦截层处理
}


#pragma mark - 自定义方法


- (void)base_initView {
    self.navigationController.navigationBar.translucent = NO;
    if (self.bwt_navigationController.bwt_viewControllers.count > 1) {
        [self addBackButton];
    }
}

- (void)base_initData {
    

}


- (void)back:(id)sender {
    [self closePage];
}

- (void)closePage {
    if(self.presentingViewController && self.bwt_navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)setNavigationTitle:(NSString *)title {
    self.navigationItem.title = title;
}


- (void)addRightButton:(SEL)selector
                 image:(UIImage *)image
             highImage:(UIImage *)highImage {
    [UINavigationItem setRightButtonOn:self
                                target:self
                      callbackSelector:selector
                                 image:image
                             highImage:highImage];
}


- (void)addRightButton:(SEL)selector
                 image:(UIImage *)image {
    [UINavigationItem setRightButtonOn:self
                                target:self
                      callbackSelector:selector
                                 image:image];
}


- (void)addRightButton:(SEL)selector
                 title:(NSString *)title {
    [UINavigationItem setRightButtonOn:self
                                target:self
                      callbackSelector:selector
                                 title:title];
}

- (void)addBackButton {
    [UINavigationItem setLeftButtonOn:self target:self callbackSelector:@selector(back:)];
}


- (void)addLeftButton:(SEL)selector
                title:(NSString *)title {
    [UINavigationItem setLeftButtonOn:self
                               target:self
                     callbackSelector:selector
                                title:title];
}

- (void)addLeftButton:(SEL)selector
                image:(UIImage *)image{
    [UINavigationItem setLeftButtonOn:self
                               target:self
                     callbackSelector:selector
                                image:image];
}

- (void)addLeftButton:(SEL)selector {
    [UINavigationItem setLeftButtonOn:self
                               target:self
                     callbackSelector:selector];
}


- (void)setParameter:(NSDictionary *)params {
    BWTLog(@"路由过来的参数 ==== %@", params);
}


// 必须子类实现回调
//- (BWTBaseViewModel *)getViewModel {
//    DAssert(0)  //!OCLINT
//    return nil;
//}


@end
