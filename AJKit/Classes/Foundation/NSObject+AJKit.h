//
//  NSObject+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AJKit)

/// 获取Class类名
+ (NSString *)ajClassName;

/// 判断对象是否是JSON对象
- (BOOL)ajIsJSONObject;

/// 获取Class类名
- (NSString *)ajClassName;

@end

NS_ASSUME_NONNULL_END
