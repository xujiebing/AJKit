//
//  AJAPPKitConfig.h
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#ifndef AJAPPKitConfig_h
#define AJAPPKitConfig_h


#pragma mark - 机型获取

#define IS_IPHONE_4_OR_LESS (AJScreenHeight < 568.000000)
#define IS_IPHONE_5 (AJScreenHeight == 568.000000)
#define IS_IPHONE_6 (AJScreenHeight == 667.000000)
#define IS_IPHONE_6P (AJScreenHeight == 736.000000)
#define IS_IPHONE_X (AJScreenHeight >= 812.000000)

#pragma mark - 获取应用屏幕大小
#define AJAppFrame [[UIScreen mainScreen] applicationFrame]
#define AJScreenBounds [UIScreen mainScreen].bounds
#define AJScreenWidth AJScreenBounds.size.width
#define AJScreenHeight AJScreenBounds.size.height
#define AJViewHeight [UIScreen mainScreen].bounds.size.height >= 812.000000 ? CGRectGetHeight([UIScreen mainScreen].bounds) - 44 - 20 - 24 : CGRectGetHeight([UIScreen mainScreen].bounds) - 44 - 20

#pragma mark - 颜色处理

// 根据16位RBG值转换成颜色，格式:UIColorFrom16RGB(0xFF0000)
#define UIColorFrom16RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 根据10位RBG值转换成颜色, 格式:KLColorFrom10RBG(255,255,255)
#define UIColorFrom10RGB(RED, GREEN, BLUE) [UIColor colorWithRed:RED/255.0 green:GREEN/255.0 blue:BLUE/255.0 alpha:1.0]

#pragma mark - 对字符串做特殊的宏，即保证返回的值不为空

#define ISNIL(x) ((x) == nil ? @"" : (x))
#define ISNILDefault(x, y) ((x) == nil ? y : (x))

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
