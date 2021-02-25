//
//  AJCountDownManager.h
//  AJBase
//
//  Created by gaoyang on 2018/12/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJCountDownBean : NSObject

/**
 总时间
 */
@property (nonatomic, assign, readonly) NSInteger totalCount;
/**
 当前还剩多少次
 */
@property (nonatomic, assign, readonly) NSInteger currentCount;
/**
 是否正在计时
 */
@property (nonatomic, assign, readonly) BOOL isRunning;

@end

@interface AJCountDownManager : NSObject

/**
 获取倒计时模块(倒计时没结束前会重用)
 @param identifier 唯一标识
 @return 倒计时模块
 */
+ (AJCountDownBean *)dequeueBeanWithIdentifier:(NSString *)identifier;

/**
 开始倒计时
 @param bean 倒计时模块
 @param totalCount 总计次数
 @param interval 间隔时间间隔
 */
+ (void)startCountDownWithBean:(AJCountDownBean *)bean totalCount:(NSInteger)totalCount interval:(NSTimeInterval)interval;

/**
 停止倒计时
 @param bean 倒计时模块
 */
+ (void)stopCountDownWithBean:(AJCountDownBean *)bean;

@end

NS_ASSUME_NONNULL_END
