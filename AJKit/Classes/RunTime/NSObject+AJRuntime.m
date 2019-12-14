//
//  NSObject+AJRuntime.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import "NSObject+AJRuntime.h"

@implementation NSObject (AJRuntime)

+ (BOOL)ajSwizzleMethod:(SEL)origMethod withMethod:(SEL)withMethod
{
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

+ (BOOL)ajSwizzleClassMethod:(SEL)origClassMethod withClassMethod:(SEL)withClassMethod
{
    Class c = object_getClass((id)self);
    return [c ajSwizzleMethod:origClassMethod withMethod:withClassMethod];
}

+ (void)ajSwizzleMethod:(SEL)origMethod withClassName:(NSString *)withClassName withMethod:(SEL)withMethod
{
    if (!withClassName) {
        return;
    }
    Class origClass = [self class];
    Class withClass = NSClassFromString(withClassName);
    [self ajSwizzleMethod:origClass origMethod:origMethod withClass:withClass withMethod:withMethod];
}

+ (void)ajSwizzleMethod:(Class)origClass origMethod:(SEL)origMethod withClass:(Class)withClass withMethod:(SEL)withMethod
{
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
    
    Method srcMethod = class_getInstanceMethod(origClass,origMethod);
    Method tarMethod = class_getInstanceMethod(withClass,withMethod);
    method_exchangeImplementations(srcMethod, tarMethod);
}
@end
