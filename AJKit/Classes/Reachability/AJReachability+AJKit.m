//
//  AJReachability+AJKit.m
//  Base64
//
//  Created by 徐结兵 on 2020/4/13.
//

#import "AJReachability+AJKit.h"

@implementation AJReachability (AJKit)

static AJReachability *_reachability = nil;
+ (AJReachability *)reachability {
    if (!_reachability) {
        _reachability = [AJReachability reachabilityWitBWTostName:@"www.baidu.com"];
    }
    return _reachability;
}

+ (BOOL)isReachable {
    BOOL isReachable = [AJReachability.reachability isReachable];
    if(!isReachable) {
        AJLog(@"没有网络未进行网络请求");
    }
    return isReachable;
}

+ (BOOL)isReachableViaWWAN {
    BOOL isReachable = [AJReachability.reachability isReachableViaWWAN];
    return isReachable;
}

+ (BOOL)isReachableViaWiFi {
    BOOL isReachable = [AJReachability.reachability isReachableViaWiFi];
    return isReachable;
}
@end
