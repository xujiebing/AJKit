//
//  AJKitConfig.h
//  AJKit
//
//  Created by 徐结兵 on 2020/4/23.
//

#ifndef AJKitConfig_h
#define AJKitConfig_h

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-function"

#import "AJTools.h"

static NSString *AJPlatformConfigKey = @"platformKeys";

static id AJPlatformConfig1(NSString *key) {
    return [AJTools getKeysValueConfigKey:AJPlatformConfigKey, key, nil];
}

static id AJPlatformConfig2(NSString *key1, NSString *key2) {
    return [AJTools getKeysValueConfigKey:AJPlatformConfigKey, key1, key2, nil];
}

static id AJPlatformConfig3(NSString *key1, NSString *key2, NSString *key3) {
    return [AJTools getKeysValueConfigKey:AJPlatformConfigKey, key1, key2, key3, nil];
}

static id AJPlatformConfig4(NSString *key1, NSString *debugKey, NSString *releaseKey, NSString *key4) {
    return [AJTools getKeysValueConfigKey:AJPlatformConfigKey, key1, debugKey, releaseKey, key4, nil];
}

static NSString *AJLocalConfigKey = @"localConfig";

static id AJLocalConfig1(NSString *key) {
    return [AJTools getKeysValueConfigKey:AJLocalConfigKey, key, nil];
}

static id AJLocalConfig2(NSString *key1, NSString *key2) {
    return [AJTools getKeysValueConfigKey:AJLocalConfigKey, key1, key2, nil];
}

static id AJLocalConfig3(NSString *key1, NSString *key2, NSString *key3) {
    return [AJTools getKeysValueConfigKey:AJLocalConfigKey, key1, key2, key3, nil];
}

static id AJLocalConfig4(NSString *key1, NSString *debugKey, NSString *releaseKey, NSString *key4) {
    return [AJTools getKeysValueConfigKey:AJLocalConfigKey, key1, debugKey, releaseKey, key4, nil];
}

static NSString * const AJKitModuleName = @"AJKit";

#pragma mark - 图片

/// 图片对象
/// @param imageName 图片名
/// @param bundleName bundle名
static UIImage *AJImage(NSString *imageName, NSString *bundleName) {
    if (bundleName.length == 0) {
        UIImage *image = [UIImage imageNamed:imageName];
        return image;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    if (image) {
        return image;
    }
    NSString *bundlePath = [NSBundle.mainBundle pathForResource:bundleName ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    image = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    return image;
}

#endif /* AJKitConfig_h */
