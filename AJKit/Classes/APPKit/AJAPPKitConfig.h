//
//  AJAPPKitConfig.h
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#ifndef AJAPPKitConfig_h
#define AJAPPKitConfig_h

// 初始化带有Xib的ViewController
#define AJInitNibWithBundleName(bundleName) \
- (instancetype)initWithNibName:(NSString *)nibNameOrNil \
bundle:(NSBundle *)nibBundleOrNil { \
if(nibNameOrNil == nil) { \
nibNameOrNil = self.ajClassName; \
} \
if (nibBundleOrNil == nil) { \
nibBundleOrNil = [AJAPPKitTool bundleWithBundleName:bundleName className:nibNameOrNil]; \
} \
self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]; \
return self; \
}



#define mark - 生成单例类

#define SINGLETON_H(classname) + (nonnull instancetype)shared##classname;

#define SINGLETON_M(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}

#define SINGLETON_MO(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \

#endif /* AJAPPKitConfig_h */
