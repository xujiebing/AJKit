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
#import "NSDictionary+AJKit.h"
#import "NSString+AJKit.h"
#import "AJRuntime.h"
#import "NSObject+AJRuntime.h"

FOUNDATION_EXPORT double AJKitVersionNumber;
FOUNDATION_EXPORT const unsigned char AJKitVersionString[];

