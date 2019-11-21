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
    NSString *string = @"dajkla";
//    string = [NSNull null];
//    NSString *base64 = string.ajBase64Encoding;
//    AJLog(base64)
    id a = @[];
    string = a;
    string.ajUrlEncodeUTF8;
    AJLog(@"")
    
    NSArray *array = @[];
    array = nil;
    [array objectAtIndex:1];
    AJLog(@"")
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
