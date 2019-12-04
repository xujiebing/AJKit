//
//  NSObject+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import "NSObject+AJKit.h"

@implementation NSObject (AJKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSObject.ajSwizzleMethod(@selector(forwardingTargetForSelector:), @selector(ajForwardingTargetForSelector:));
        NSObject.ajSwizzleMethod(@selector(forwardInvocation:), @selector(ajForwardInvocation:));
    });
}

- (void)ajForwardInvocation:(NSInvocation *)anInvocation {
    if ([self respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:self];
        return;
    }
}

- (id)ajForwardingTargetForSelector:(SEL)aSelector {
    if ([self respondsToSelector:aSelector]) {
        return [self ajForwardingTargetForSelector:aSelector];
    }
#if DEBUG
    NSString *className = NSStringFromClass(self.class);
    NSString *funcName = NSStringFromSelector(aSelector);
    NSString *description = [NSString stringWithFormat:@"【%@】 未实现 【%@】 方法", className, funcName];
    NSAssert(0, description);
#endif
    IMP imp = class_getMethodImplementation([self class], @selector(ajNoCrash));
    class_addMethod([NSObject class], aSelector, imp, "v@:");
    return [NSObject.new ajForwardingTargetForSelector:aSelector];
}

- (void)ajNoCrash {
    AJLog(@"ajNoCrash")
}

+ (BOOL (^)(id _Nonnull))ajIsJSONObject {
    BOOL (^block)(id) = ^(id ajSelf){
        BOOL isJaon = [NSJSONSerialization isValidJSONObject:ajSelf];
        return isJaon;
    };
    return block;
}

+ (NSString *(^)(id _Nonnull))ajClassName {
    NSString * (^block)(id) = ^(id ajSelf){
        NSString *className = [NSString stringWithUTF8String:class_getName([ajSelf class])];
        return className;
    };
    return block;
}

+ (NSString *(^)(id _Nonnull))ajJsonString {
    NSString * (^block)(id) = ^(id ajSelf){
        if (!NSObject.ajIsJSONObject(ajSelf)) {
            return AJEmptyString;
        }
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:ajSelf options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    };
    return block;
}

@end
