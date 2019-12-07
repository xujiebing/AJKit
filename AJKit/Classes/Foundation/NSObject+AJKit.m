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
        NSObject.ajKitSwizzleMethod(@selector(forwardingTargetForSelector:), @selector(p_ajForwardingTargetForSelector:));
        NSObject.ajKitSwizzleMethod(@selector(forwardInvocation:), @selector(p_ajForwardInvocation:));
    });
}

- (BOOL)ajIsJSONObject {
    return [NSJSONSerialization isValidJSONObject:self];
}

- (NSString *)ajJsonValue {
    if (!self.ajIsJSONObject) {
        return nil;
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}

- (NSString *)ajClassName {
    return [NSString stringWithUTF8String:class_getName([self class])];
}

+ (NSString *)ajClassName {
    return NSStringFromClass(self);
}

#pragma mark - 内部方法

+ (BOOL (^)(SEL _Nonnull, SEL _Nonnull))ajKitSwizzleMethod {
    kAJWeakSelf
    BOOL (^block)(SEL, SEL) = ^(SEL origMethod, SEL withMethod){
        Method origMethodInstance = class_getInstanceMethod(ajSelf, origMethod);
        if (!origMethod) {
            AJLog(@"original method %@ not found for class %@", NSStringFromSelector(origMethod), [self class]);
            return NO;
        }
        
        Method altMethodInstance = class_getInstanceMethod(self, withMethod);
        if (!withMethod) {
            AJLog(@"original method %@ not found for class %@", NSStringFromSelector(withMethod), [self class]);
            return NO;
        }
        
        class_addMethod(ajSelf,
                        origMethod,
                        class_getMethodImplementation(ajSelf, origMethod),
                        method_getTypeEncoding(origMethodInstance));
        class_addMethod(ajSelf,
                        withMethod,
                        class_getMethodImplementation(ajSelf, withMethod),
                        method_getTypeEncoding(altMethodInstance));
        method_exchangeImplementations(class_getInstanceMethod(ajSelf, origMethod), class_getInstanceMethod(ajSelf, withMethod));
        return YES;
    };
    return block;
}

- (void)p_ajForwardInvocation:(NSInvocation *)anInvocation {
    if ([self respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:self];
        return;
    }
}

- (id)p_ajForwardingTargetForSelector:(SEL)aSelector {
    if ([self respondsToSelector:aSelector]) {
        return [self p_ajForwardingTargetForSelector:aSelector];
    }
#if DEBUG
    NSString *className = NSStringFromClass(self.class);
    NSString *funcName = NSStringFromSelector(aSelector);
    NSString *description = [NSString stringWithFormat:@"【%@】 未实现 【%@】 方法", className, funcName];
    NSAssert(0, description);
#endif
    IMP imp = class_getMethodImplementation([self class], @selector(p_ajNoCrash));
    class_addMethod([NSObject class], aSelector, imp, "v@:");
    return [NSObject.new p_ajForwardingTargetForSelector:aSelector];
}

- (void)p_ajNoCrash {
    AJLog(@"p_ajNoCrash")
}

@end
