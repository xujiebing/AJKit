//
//  AJViewController.m
//  AJKit
//
//  Created by xujiebing on 11/20/2019.
//  Copyright (c) 2019 xujiebing. All rights reserved.
//

#import "AJViewController.h"
#import <AJKit/AJFoundation.h>

@interface AJViewController ()

@end

@implementation AJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSData *data = @"qqqq".ajDataValue;
    
    NSString *q = NSData.ajHexString(data);
    NSString *qq = NSData.ajStringValue(data);
    AJLog(@"")
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
