//
//  UIDevice+AJKit.h
//  AJAD
//
//  Created by 徐结兵 on 2020/4/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (AJKit)

/// 是否飞行模式
@property (class, nonatomic, assign, readonly) BOOL ajIsAirPlaneMode;

/// 获取系统语言判断是否是中文
@property (class, nonatomic, assign, readonly) BOOL ajIsZHLanguage;

/// 是否越狱
@property (class, nonatomic, assign, readonly) BOOL ajIsPrisonBreak;

/// 是否支持摄像头
@property (class, nonatomic, assign, readonly) BOOL ajSupportCamera;

@property (nonatomic, assign, readonly) BOOL ajIsSimulator;

/// 设备型号， 如："iPhone6,1" "iPad4,6"
@property (class, nonatomic, copy, readonly) NSString *ajMachineModel;

/// 设备名称， 如："iPhone 5s" "iPad mini 2"
@property (class, nonatomic, copy, readonly) NSString *ajMachineModelName;



@end

NS_ASSUME_NONNULL_END
