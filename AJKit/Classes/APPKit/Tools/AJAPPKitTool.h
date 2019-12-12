//
//  AJAPPKitTool.h
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJAPPKitTool : NSObject

/// 获取Bundle
/// @param bundleName bundle名
/// @param className 类名
+ (NSBundle *)bundleWithBundleName:(NSString *)bundleName
                           className:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
