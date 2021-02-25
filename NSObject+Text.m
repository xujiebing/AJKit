//
//  NSObject+text.m
//  AJKit
//
//  Created by 徐结兵 on 2019/12/4.
//

#import "NSObject+Text.h"

@implementation NSObject (Text)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSObject.ajSwizzleMethod(@selector(forwardingTargetForSelector:), @selector(ajForwardingTargetForSelector:));
    });
}

- (id)ajForwardingTargetForSelector:(SEL)aSelector {
    if ([self respondsToSelector:aSelector]) {
        return [self ajForwardingTargetForSelector:aSelector];
    }
#if DEBUG
    NSString *className = NSStringFromClass(self.class);
    NSString *funcName = NSStringFromSelector(aSelector);
    NSString *description = [NSString stringWithFormat:@"%@ 未实现 %@ 方法", className, funcName];
    NSAssert(0, description);
#endif
    IMP imp = class_getMethodImplementation([self class], @selector(doNothing:));
    class_addMethod([NSObject class], aSelector, imp, "v@:");
    return [NSObject.new ajForwardingTargetForSelector:aSelector];
}

- (void)doNothing:(id)param {
    NSLog(@"no func");
}

@end
