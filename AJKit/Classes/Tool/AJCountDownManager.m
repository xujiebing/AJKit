//
//  AJCountDownManager.m
//  AJBase
//
//  Created by gaoyang on 2018/12/15.
//

#import "AJCountDownManager.h"

@interface AJCountDownBean()

/**
 总时间
 */
@property (nonatomic, assign) NSInteger totalCount;
/**
 当前还剩多少次
 */
@property (nonatomic, assign) NSInteger currentCount;
/**
 是否正在计时
 */
@property (nonatomic, assign) BOOL isRunning;

@property (nonatomic, copy) NSString *identifier;

/**
 时间间隔触发
 */
@property (nonatomic, assign) NSTimeInterval interval;
/**
 上一个时间戳
 */
@property (nonatomic, assign) NSTimeInterval prevTimeStamp;

@end

@implementation AJCountDownBean

@end

//@interface AJCountDownManager()
//
//@end

static NSMutableDictionary *beanCache;
static CADisplayLink *displayLink;

@implementation AJCountDownManager

+ (void)initialize {
    beanCache = [[NSMutableDictionary alloc]init];
}

+ (AJCountDownBean *)dequeueBeanWithIdentifier:(NSString *)identifier {
    AJCountDownBean *bean = [beanCache objectForKey:identifier];
    if (!bean) {
        bean = [[AJCountDownBean alloc]init];
        bean.identifier = identifier;
    }
    return bean;
}

+ (void)startCountDownWithBean:(AJCountDownBean *)bean totalCount:(NSInteger)totalCount interval:(NSTimeInterval)interval {
    bean.totalCount = totalCount;
    bean.isRunning = YES;
    bean.currentCount = totalCount;
    bean.interval = interval;
    bean.prevTimeStamp = [[NSDate date]timeIntervalSince1970];
    [beanCache setObject:bean forKey:bean.identifier];
    
    [self p_startDisplayLink];
}

+ (void)stopCountDownWithBean:(AJCountDownBean *)bean {
    bean.isRunning = NO;
    [beanCache removeObjectForKey:bean.identifier];
    [self p_checkBeanCache];//检查计时器是否停止
}

+ (void)p_startDisplayLink {
    if (!displayLink) {
        displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(p_step)];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

+ (void)p_invalidateDisplayLink {
    if (displayLink) {
        [displayLink invalidate];
        displayLink = nil;
    }
}

+ (void)p_step {
    NSTimeInterval nowTimeStamp = [[NSDate date]timeIntervalSince1970];
    
    NSArray *keys = [beanCache allKeys];
    for (NSInteger i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        AJCountDownBean *bean = [beanCache objectForKey:key];
        if (nowTimeStamp - bean.prevTimeStamp >= bean.interval) {//时间到了
            bean.currentCount --;
            bean.prevTimeStamp = nowTimeStamp;
            if (bean.currentCount <= 0) {//计时结束
                bean.isRunning = NO;
                [beanCache removeObjectForKey:bean.identifier];
            }
        }
    }
    [self p_checkBeanCache];
}

+ (void)p_checkBeanCache {
    NSArray *keys = [beanCache allKeys];
    if (!keys || keys.count <= 0) {//没有剩余对象了
        [self p_invalidateDisplayLink];
    }
}


@end
