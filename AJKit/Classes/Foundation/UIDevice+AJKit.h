//
//  UIDevice+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (AJKit)

/// 随机生成一个UUID
+ (NSString *)ajUUID;

#pragma mark - Device Information

@property (nonatomic, readonly) BOOL ajIsPad;

@property (nonatomic, readonly) BOOL ajIsSimulator;

@property (nonatomic, readonly) BOOL ajIsJailbroken;

@property (nonatomic, readonly) BOOL ajCanMakePhoneCalls;

/// 获取设备名，如： "iPhone6,1" "iPad4,6"
@property (nonatomic, readonly) NSString *ajMachineModel;

#pragma mark - Network Information

/// 获取链接的WIFI的IP地址 如：192.168.1.111
@property (nonatomic, readonly) NSString *ajIpAddressWIFI;

#pragma mark - Disk Space

/// Total disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ajDiskSpace;

/// Free disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ajDiskSpaceFree;

/// Used disk space in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ajDiskSpaceUsed;


#pragma mark - Memory Information

/// Total physical memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ajMemoryTotal;

/// Used (active + inactive + wired) memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ajMemoryUsed;

/// Free memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ajMemoryFree;

/// Acvite memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ajMemoryActive;

/// Inactive memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ajMemoryInactive;

/// Wired memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ajMemoryWired;

/// Purgable memory in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t ajMemoryPurgable;

#pragma mark - CPU Information

/// Avaliable CPU processor count.
@property (nonatomic, readonly) NSUInteger ajCpuCount;

/// Current CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly) float ajCpuUsage;

/// Current CPU usage per processor (array of NSNumber), 1.0 means 100%. (nil when error occurs)
@property (nonatomic, readonly) NSArray *ajCpuUsagePerProcessor;

@end

NS_ASSUME_NONNULL_END
