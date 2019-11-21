//
//  AJFoundationConfig.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#ifndef AJFoundationConfig_h
#define AJFoundationConfig_h

#ifdef DEBUG
    #define AJLog(fmt, ...) fprintf(stderr,"Func: %s \nLine: %d \nLog: %s", __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:fmt, ##__VA_ARGS__] UTF8String]);
#else
    #define AJLog(...)
#endif

#define kAJWeakSelf __weak __typeof(self)ajSelf = self;

static NSString * const AJEmptyString = @"";

#endif /* AJFoundationConfig_h */
