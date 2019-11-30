//
//  AJViewController.m
//  AJKit
//
//  Created by xujiebing on 11/20/2019.
//  Copyright (c) 2019 xujiebing. All rights reserved.
//

#import "AJViewController.h"
#import <AJKit/AJFoundation.h>
#import <AJKit/AJUIKit.h>

@interface AJViewController ()

@end

@implementation AJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController pushViewController:AJViewController.new animated:YES];
    self.navigationItem.ajAddLeftButtonWithTitle(@"test", self, @selector(p_test));
}

- (void)p_test {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
