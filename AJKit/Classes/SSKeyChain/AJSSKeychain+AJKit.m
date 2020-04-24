//
//  AJSSKeychain+AJExt.m
//  Pods
//
//  Created by xujiebing on 2017/6/9.
//
//

#import "AJSSKeychain+AJKit.h"

#define AJ_ACCESS_TOKEN @"AJ_accessToken"
#define AJ_IP_ADDRESS @"AJ_ipAddress"
#define AJ_ACCOUNT_NAME @"AJ_AccountName"


@implementation AJSSKeychain (AJKit)

+ (NSString *)accessToken {
    
    NSString *bundleId = AJConfigInfo.bundleId;
    NSString *accessToken = [self passwordForService:bundleId account:AJ_ACCESS_TOKEN];

    if (!accessToken || accessToken.length == 0) {
        return @"";
    }
    return accessToken;
}

+ (NSString *)accountName {
    NSString *bundleId = AJConfigInfo.bundleId;
    NSString *name = [self passwordForService:bundleId account:AJ_ACCOUNT_NAME];
    
    if (!name || name.length == 0) {
        return @"";
    }
    return name;
}

+ (BOOL)setAccessToken:(NSString *)accessToken {
    NSString *bundleId = AJConfigInfo.bundleId;
    return [self setPassword:accessToken forService:bundleId account:AJ_ACCESS_TOKEN];
}

+ (BOOL)setAccountName:(NSString *)name {
    if (name.length == 0) {
        return NO;
    }
    NSString *bundleId = AJConfigInfo.bundleId;
    return [self setPassword:name forService:bundleId account:AJ_ACCOUNT_NAME];
}

@end
