//
//  NSObject+AJKit.m
//  Base64
//
//  Created by 徐结兵 on 2020/4/13.
//

#import "NSObject+AJKit.h"
#import <objc/runtime.h>

@implementation NSObject (AJKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ajSwizzleMethod:@selector(forwardingTargetForSelector:) withMethod:@selector(ajForwardingTargetForSelector:)];
        [self ajSwizzleMethod:@selector(forwardInvocation:) withMethod:@selector(ajForwardInvocation:)];
    });
}


#pragma mark - 对外方法

- (BOOL)ajMethodUndefinedCrash {
    return YES;
}

- (NSString *)ajClassName {
  return [NSString stringWithUTF8String:class_getName([self class])];
}

+ (NSString *)ajClassName {
    return NSStringFromClass(self);
}

+ (BOOL)ajSwizzleMethod:(SEL)origMethod
              withMethod:(SEL)withMethod {
    Method origMethodInstance = class_getInstanceMethod(self, origMethod);
    if (!origMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(origMethod), [self class]);
        return NO;
    }
    
    Method altMethodInstance = class_getInstanceMethod(self, withMethod);
    if (!withMethod) {
        NSLog(@"original method %@ not found for class %@", NSStringFromSelector(withMethod), [self class]);
        return NO;
    }
    
    class_addMethod(self,
                    origMethod,
                    class_getMethodImplementation(self, origMethod),
                    method_getTypeEncoding(origMethodInstance));
    class_addMethod(self,
                    withMethod,
                    class_getMethodImplementation(self, withMethod),
                    method_getTypeEncoding(altMethodInstance));
    
    method_exchangeImplementations(class_getInstanceMethod(self, origMethod), class_getInstanceMethod(self, withMethod));
    
    return YES;
}

+ (BOOL)ajSwizzleClassMethod:(SEL)origClassMethod
              withClassMethod:(SEL)withClassMethod {
    Class c = object_getClass((id)self);
    return [c ajSwizzleMethod:origClassMethod withMethod:withClassMethod];
}

+ (void)ajSwizzleMethod:(SEL)origMethod
           withClassName:(NSString *)withClassName
              withMethod:(SEL)withMethod {
  if (!withClassName) {
      return;
  }
  Class origClass = [self class];
  Class withClass = NSClassFromString(withClassName);
  [self ajSwizzleMethod:origClass origMethod:origMethod withClass:withClass withMethod:withMethod];
}

+ (void)ajSwizzleMethod:(Class)origClass
              origMethod:(SEL)origMethod
               withClass:(Class)withClass
              withMethod:(SEL)withMethod {
  if (!origClass) {
    return;
  }
  if (!origMethod) {
    return;
  }
  if (!withClass) {
    return;
  }
  if (!withMethod) {
    return;
  }

  AJ_TRY_BODY(Method srcMethod = class_getInstanceMethod(origClass,origMethod); //!OCLINT
               Method tarMethod = class_getInstanceMethod(withClass,withMethod);
               method_exchangeImplementations(srcMethod, tarMethod);)
}

#pragma mark - 内部方法

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
    if ([self ajMethodUndefinedCrash]) {
        return [self ajForwardingTargetForSelector:aSelector];
    }
#if DEBUG
    NSString *className = NSStringFromClass(self.class);
    NSString *funcName = NSStringFromSelector(aSelector);
    NSString *description = [NSString stringWithFormat:@"【%@】 未实现 【%@】 方法", className, funcName];
//    AJAssert(0, description);
#endif
    IMP imp = class_getMethodImplementation([self class], @selector(p_noCrash));
    class_addMethod([NSObject class], aSelector, imp, "v@:");
    return [NSObject.new ajForwardingTargetForSelector:aSelector];
}

- (void)p_noCrash {
    NSLog(@"p_noCrash");
    return;
}

@end
