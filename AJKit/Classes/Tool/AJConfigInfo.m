//
//  AJConfigInfo.m
//  AJAD
//
//  Created by 徐结兵 on 2020/4/15.
//

#import "AJConfigInfo.h"

@implementation AJConfigInfo

static NSString *_msxDomain = nil;
+ (NSString *)msxDomain {
    if (!_msxDomain) {
        _msxDomain = AJLocalConfig1(@"MSXIpAddress");
        if (!NSString.ajIsEmpty(_msxDomain)) {
            return _msxDomain;
        }
        NSString *domainKey = @"MSXDomain";
        NSString *type = AJLocalConfig2(domainKey, @"type");
        if ([@"0" isEqualToString:type]) {
            _msxDomain = AJLocalConfig2(domainKey, @"dev");
        } else if ([@"1" isEqualToString:type]) {
            _msxDomain = AJLocalConfig2(domainKey, @"test");
        } else {
            _msxDomain = AJLocalConfig2(domainKey, @"release");
        }
    }
    return _msxDomain;
}

static NSString *_gatewayDomain = nil;
+ (NSString *)gatewayDomain {
    if (!_gatewayDomain) {
        _gatewayDomain = AJLocalConfig1(@"MSXNewIpAddress");
        if (!NSString.ajIsEmpty(_gatewayDomain)) {
            return _gatewayDomain;
        }
        NSString *domainKey = @"MSXGatewayDomain";
        NSString *type = AJLocalConfig2(domainKey, @"type");
        if ([@"0" isEqualToString:type]) {
            _gatewayDomain = AJLocalConfig2(domainKey, @"dev");
        } else if ([@"1" isEqualToString:type]) {
            _gatewayDomain = AJLocalConfig2(domainKey, @"test");
        } else {
            _gatewayDomain = AJLocalConfig2(domainKey, @"release");
        }
    }
    return _gatewayDomain;
}

static NSString *_businessDomain = nil;
+ (NSString *)businessDomain {
    if (!_businessDomain) {
        _businessDomain = AJLocalConfig1(@"BusinessIpAddress");
        if (!NSString.ajIsEmpty(_businessDomain)) {
            return _businessDomain;
        }
        NSString *domainKey = @"MSXBusinessDomain";
        NSString *type = AJLocalConfig2(domainKey, @"type");
        if ([@"0" isEqualToString:type]) {
            _businessDomain = AJLocalConfig2(domainKey, @"dev");
        } else if ([@"1" isEqualToString:type]) {
            _businessDomain = AJLocalConfig2(domainKey, @"test");
        } else {
            _businessDomain = AJLocalConfig2(domainKey, @"release");
        }
    }
    return _businessDomain;
}

static NSString *_h5IpPart = nil;
+ (NSString *)h5IpPart {
    if (!_h5IpPart) {
        _h5IpPart = AJLocalConfig1(@"MSXH5IpPart");
    }
    return _h5IpPart;
}

static NSString *_bundleId = nil;
+ (NSString *)bundleId {
    if (!_bundleId) {
        NSString *identifier = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
        if (identifier.length == 0) {
            return @"";
        }
        NSString *inhouseTag = @".inhouse";
        NSString *todayTag = @".today";
        NSString *suffixTag;
        if ([identifier hasSuffix:inhouseTag]) {
            suffixTag = inhouseTag;
        } else if ([identifier hasSuffix:todayTag]) {
            suffixTag = todayTag;
        }
        if (suffixTag) {
            NSRange range = [identifier rangeOfString:suffixTag];
            if (range.location == NSNotFound) {
                NSLog(@"identifier中没有找到%@",suffixTag);
            } else {
                identifier = [identifier substringToIndex:range.location];
            }
        }
        _bundleId = identifier;
    }
    return _bundleId;
}

static NSInteger _bundleVersion = nil;
+ (NSInteger)bundleVersion {
    if (!_bundleVersion) {
        NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        _bundleVersion = version.integerValue;
    }
    return _bundleVersion;
}

static NSString *_shortVersion = nil;
+ (NSString *)shortVersion {
    if (!_shortVersion) {
        _shortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    }
    return _shortVersion;
}

static NSString *_appName = nil;
+ (NSString *)appName {
    if (!_appName) {
        NSBundle *bundle = [NSBundle bundleForClass:[self class]];
        if (!_appName) {
            _appName = [bundle objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        }
        if (!_appName) {
            _appName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];
        }
    }
    return _appName;
}

static NSString *_appScheme = nil;
+ (NSString *)appScheme {
    if (!_appScheme) {
        NSArray *array = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
        for (NSDictionary *dic in array) {
            NSString *urlName = [dic objectForKey:@"CFBundleURLName"];
            if (![urlName isEqualToString:@"AJPaySchems"]) {
                continue;
            }
            NSArray *schemesArray = [dic objectForKey:@"CFBundleURLSchemes"];
            _appScheme = [schemesArray firstObject];
            continue;
        }
        if (NSString.ajIsEmpty(_appScheme)) {
            AJAssert(0, @"请在info.plist文件中加入scheme");
        }
    }
    return _appScheme;
}

static BOOL _isDebugKey = nil;
+ (BOOL)isDebugKey {
    if (_isDebugKey == nil) {
        NSNumber *debugKey = AJPlatformConfig1(@"DebugKey");
        _isDebugKey = debugKey ? [debugKey boolValue] : YES;
    }
    return _isDebugKey;
}

static BOOL _isSupportTouchID = nil;
+ (BOOL)isSupportTouchID {
    if (_isSupportTouchID == nil) {
        _isSupportTouchID = NO;
        id supportTouchID = AJLocalConfig1(@"SupportTouchID");
        if (supportTouchID) {
            _isSupportTouchID = [supportTouchID boolValue];
        }
    }
    return _isSupportTouchID;
}

@end
