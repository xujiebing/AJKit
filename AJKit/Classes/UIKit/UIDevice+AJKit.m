//
//  UIDevice+AJKit.m
//  AJAD
//
//  Created by 徐结兵 on 2020/4/14.
//

#import "UIDevice+AJKit.h"
#include <sys/sysctl.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation UIDevice (AJKit)

- (BOOL)ajMethodUndefinedCrash {
    return NO;
}

+ (BOOL)ajIsAirPlaneMode {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    return networkInfo.currentRadioAccessTechnology == nil;
}

static BOOL _ajIsZHLanguage = nil;
+ (BOOL)ajIsZHLanguage {
    if (_ajIsZHLanguage == nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
        NSString *currentLanguage = [languages firstObject];
        _ajIsZHLanguage = [currentLanguage rangeOfString:@"zh"].length > 0;
    }
    return _ajIsZHLanguage;
}

static BOOL _ajIsPrisonBreak = nil;
+ (BOOL)ajIsPrisonBreak {
    if (_ajIsPrisonBreak == nil) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
            _ajIsPrisonBreak = YES;
        } else if ([[NSFileManager defaultManager] fileExistsAtPath:@"User/Applications/"]) {
            _ajIsPrisonBreak = YES;
        } else {
            _ajIsPrisonBreak = NO;
        }
    }
    return _ajIsPrisonBreak;
}

static BOOL _ajSupportCamera = nil;
+ (BOOL)ajSupportCamera {
    if (_ajSupportCamera == nil) {
        _ajSupportCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
        [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    }
    return _ajSupportCamera;
}

- (BOOL)ajIsSimulator {
    static dispatch_once_t one;
    static BOOL simu;
    dispatch_once(&one, ^{
        simu = NSNotFound != [[self model] rangeOfString:@"Simulator"].location;
    });
    return simu;
}

+ (NSString *)ajMachineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}

+ (NSString *)ajMachineModelName {
    static dispatch_once_t one;
    static NSString *name;
    dispatch_once(&one, ^{
        NSString *model = [self ajMachineModel];
        if ([model isEqualToString:@"iPhone1,1"]) name = @"iPhone 1G";
        else if ([model isEqualToString:@"iPhone1,2"]) name = @"iPhone 3G";
        else if ([model isEqualToString:@"iPhone2,1"]) name = @"iPhone 3GS";
        else if ([model isEqualToString:@"iPhone3,1"]) name = @"iPhone 4 (GSM)";
        else if ([model isEqualToString:@"iPhone3,2"]) name = @"iPhone 4";
        else if ([model isEqualToString:@"iPhone3,3"]) name = @"iPhone 4 (CDMA)";
        else if ([model isEqualToString:@"iPhone4,1"]) name = @"iPhone 4S";
        else if ([model isEqualToString:@"iPhone5,1"]) name = @"iPhone 5";
        else if ([model isEqualToString:@"iPhone5,2"]) name = @"iPhone 5";
        else if ([model isEqualToString:@"iPhone5,3"]) name = @"iPhone 5c";
        else if ([model isEqualToString:@"iPhone5,4"]) name = @"iPhone 5c";
        else if ([model isEqualToString:@"iPhone6,1"]) name = @"iPhone 5s";
        else if ([model isEqualToString:@"iPhone6,2"]) name = @"iPhone 5s";
        else if ([model isEqualToString:@"iPhone7,1"]) name = @"iPhone 6 Plus";
        else if ([model isEqualToString:@"iPhone7,2"]) name = @"iPhone 6";
        else if ([model isEqualToString:@"iPhone8,1"]) name = @"iPhone 6s";
        else if ([model isEqualToString:@"iPhone8,2"]) name = @"iPhone 6s Plus";
        else if ([model isEqualToString:@"iPhone8,4"]) name = @"iPhone SE";
        else if ([model isEqualToString:@"iPhone9,1"]) name = @"iPhone 7";
        else if ([model isEqualToString:@"iPhone9,3"]) name = @"iPhone 7";
        else if ([model isEqualToString:@"iPhone9,2"]) name = @"iPhone 7 Plus";
        else if ([model isEqualToString:@"iPhone9,4"]) name = @"iPhone 7 Plus";
        else if ([model isEqualToString:@"iPhone10,1"]) name = @"iPhone 8";
        else if ([model isEqualToString:@"iPhone10,4"]) name = @"iPhone 8";
        else if ([model isEqualToString:@"iPhone10,2"]) name = @"iPhone 8 Plus";
        else if ([model isEqualToString:@"iPhone10,5"]) name = @"iPhone 8 Plus";
        else if ([model isEqualToString:@"iPhone10,3"]) name = @"iPhone X";
        else if ([model isEqualToString:@"iPhone10,6"]) name = @"iPhone X";
        else if ([model isEqualToString:@"iPhone11,2"]) name = @"iPhone XS";
        else if ([model isEqualToString:@"iPhone11,4"]) name = @"iPhone XS Max";
        else if ([model isEqualToString:@"iPhone11,6"]) name = @"iPhone XS Max";
        else if ([model isEqualToString:@"iPhone11,8"]) name = @"iPhone XR";
        
        else if ([model isEqualToString:@"iPod1,1"]) name = @"iPod 1";
        else if ([model isEqualToString:@"iPod2,1"]) name = @"iPod 2";
        else if ([model isEqualToString:@"iPod3,1"]) name = @"iPod 3";
        else if ([model isEqualToString:@"iPod4,1"]) name = @"iPod 4";
        else if ([model isEqualToString:@"iPod5,1"]) name = @"iPod 5";
        
        else if ([model isEqualToString:@"iPad1,1"]) name = @"iPad 1";
        else if ([model isEqualToString:@"iPad2,1"]) name = @"iPad 2 (WiFi)";
        else if ([model isEqualToString:@"iPad2,2"]) name = @"iPad 2 (GSM)";
        else if ([model isEqualToString:@"iPad2,3"]) name = @"iPad 2 (CDMA)";
        else if ([model isEqualToString:@"iPad2,4"]) name = @"iPad 2";
        else if ([model isEqualToString:@"iPad2,5"]) name = @"iPad Mini 1";
        else if ([model isEqualToString:@"iPad2,6"]) name = @"iPad Mini 1";
        else if ([model isEqualToString:@"iPad2,7"]) name = @"iPad Mini 1";
        else if ([model isEqualToString:@"iPad3,1"]) name = @"iPad 3 (WiFi)";
        else if ([model isEqualToString:@"iPad3,2"]) name = @"iPad 3 (4G)";
        else if ([model isEqualToString:@"iPad3,3"]) name = @"iPad 3 (4G)";
        else if ([model isEqualToString:@"iPad3,4"]) name = @"iPad 4";
        else if ([model isEqualToString:@"iPad3,5"]) name = @"iPad 4";
        else if ([model isEqualToString:@"iPad3,6"]) name = @"iPad 4";
        else if ([model isEqualToString:@"iPad4,1"]) name = @"iPad Air";
        else if ([model isEqualToString:@"iPad4,2"]) name = @"iPad Air";
        else if ([model isEqualToString:@"iPad4,3"]) name = @"iPad Air";
        else if ([model isEqualToString:@"iPad4,4"]) name = @"iPad Mini 2";
        else if ([model isEqualToString:@"iPad4,5"]) name = @"iPad Mini 2";
        else if ([model isEqualToString:@"iPad4,6"]) name = @"iPad Mini 2";
        else if ([model isEqualToString:@"iPad4,7"]) name = @"iPad Mini 3";
        else if ([model isEqualToString:@"iPad4,8"]) name = @"iPad Mini 3";
        else if ([model isEqualToString:@"iPad4,9"]) name = @"iPad Mini 3";
        else if ([model isEqualToString:@"iPad5,1"]) name = @"iPad Mini 4";
        else if ([model isEqualToString:@"iPad5,2"]) name = @"iPad Mini 4";
        else if ([model isEqualToString:@"iPad5,3"]) name = @"iPad Air 2";
        else if ([model isEqualToString:@"iPad5,4"]) name = @"iPad Air 2";
        else if ([model isEqualToString:@"iPad6,3"]) name = @"iPad Pro 9.7";
        else if ([model isEqualToString:@"iPad6,4"]) name = @"iPad Pro 9.7";
        else if ([model isEqualToString:@"iPad6,7"]) name = @"iPad Pro 12.9";
        else if ([model isEqualToString:@"iPad6,8"]) name = @"iPad Pro 12.9";
        
        else if ([model isEqualToString:@"i386"]) name = @"Simulator x86";
        else if ([model isEqualToString:@"x86_64"]) name = @"Simulator x64";
        else name = model;
    });
    return name;
}

@end
