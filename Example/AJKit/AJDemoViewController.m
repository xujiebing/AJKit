//
//  AJDemoViewController.m
//  AJKit
//
//  Created by xujiebing on 11/20/2019.
//  Copyright (c) 2019 xujiebing. All rights reserved.
//

#import "AJDemoViewController.h"
#import "TableViewController.h"
#import <AJKit/AJKit.h>

@interface AJDemoViewController ()

@end

@implementation AJDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)tableViewEvent:(id)sender {
    TableViewController *vc = TableViewController.new;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
