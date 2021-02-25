//
//  LimitInput.h
//  singleview
//
//  Created by aqua on 14-8-30.
//  Copyright (c) 2014年 aqua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


#define PROPERTY_NAME @"limit"

#define DECLARE_PROPERTY(className) \
@interface className (Limit) @end

DECLARE_PROPERTY(UITextField)
DECLARE_PROPERTY(UITextView)

@interface AJLimitInput : NSObject

@property(nonatomic, assign) BOOL enableLimitCount;

+(AJLimitInput *) sharedInstance;


@end
