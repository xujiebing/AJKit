//
//  AJReachability+AJKit.h
//  Base64
//
//  Created by 徐结兵 on 2020/4/13.
//

NS_ASSUME_NONNULL_BEGIN

@interface AJReachability (AJKit)

@property (class, nonatomic, strong, readwrite) AJReachability *reachability;

/// 网络是否可用
@property (class, nonatomic, assign, readwrite) BOOL isReachable;

/// 检测2、3、4G是否可用
@property (class, nonatomic, assign, readwrite) BOOL isReachableViaWWAN;

/// 检测wifi是否可用
@property (class, nonatomic, assign, readwrite) BOOL isReachableViaWiFi;

@end

NS_ASSUME_NONNULL_END
