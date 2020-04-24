//
//  AJKitMacro.h
//  AJKit
//
//  Created by 徐结兵 on 2020/4/23.
//

#ifndef AJKitMacro_h
#define AJKitMacro_h

#ifdef DEBUG
    #define AJLog(fmt, ...) fprintf(stderr,"Func: %s \nLine: %d \nLog: %s\n", __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:fmt, ##__VA_ARGS__] UTF8String]);
#else
    #define AJLog(...)
#endif

#define kAJWeakSelf __weak __typeof(self)ajSelf = self;

#define AJAssert(condition, desc) NSAssert(condition, desc);

static id AJNil(id value) {
    if (value == nil) {
        return @"";
    }
    if ([value isKindOfClass:NSNull.class]) {
        return @"";
    }
    return value;
}

// 初始化带有Xib的ViewController
#define AJInitNibWithBundleName(bundleName) \
- (instancetype)initWithNibName:(NSString *)nibNameOrNil \
bundle:(NSBundle *)nibBundleOrNil { \
if(nibNameOrNil == nil) { \
nibNameOrNil = self.ajClassName; \
} \
if (nibBundleOrNil == nil) { \
nibBundleOrNil = [NSBundle bundleWithBundleName:bundleName className:nibNameOrNil]; \
} \
self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]; \
return self; \
}

#define mark - 生成单例类

#define AJSINGLETON_H \
+ (nonnull instancetype)sharedInstance;

#define AJSINGLETON_M(classname) \
static classname *_sharedInstance = nil; \
+ (classname *)sharedInstance { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{\
        _sharedInstance = [[self alloc] init];\
    });\
    return _sharedInstance;\
}\

#endif /* AJKitMacro_h */
