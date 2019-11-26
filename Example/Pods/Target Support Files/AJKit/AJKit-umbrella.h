#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AJFoundation.h"
#import "AJFoundationConfig.h"
#import "NSArray+AJKit.h"
#import "NSData+AJKit.h"
#import "NSDate+AJKit.h"
#import "NSDictionary+AJKit.h"
#import "NSNull+AJKit.h"
#import "NSObject+AJKit.h"
#import "NSString+AJKit.h"
#import "UIDevice+AJKit.h"
#import "AJUIKit.h"
#import "UIViewController+AJKit.h"

FOUNDATION_EXPORT double AJKitVersionNumber;
FOUNDATION_EXPORT const unsigned char AJKitVersionString[];

