//
//  AJKitConfig.h
//  AJKit
//
//  Created by 徐结兵 on 2020/4/23.
//

#ifndef AJKitConfig_h
#define AJKitConfig_h

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
