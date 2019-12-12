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

#endif /* AJAPPKitConfig_h */
