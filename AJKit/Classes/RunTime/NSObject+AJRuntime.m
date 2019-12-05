//
//  NSObject+AJRuntime.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/20.
//

#import "NSObject+AJRuntime.h"

@implementation NSObject (AJRuntime)

+ (BOOL (^)(SEL _Nonnull, SEL _Nonnull))ajSwizzleMethod {
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

+ (BOOL (^)(SEL _Nonnull, SEL _Nonnull))ajSwizzleClassMethod {
    kAJWeakSelf
    BOOL (^block)(SEL, SEL) = ^(SEL origClassMethod, SEL withClassMethod){
        Class c = object_getClass((id)ajSelf);
        return c.ajSwizzleMethod(origClassMethod, withClassMethod);
    };
    return block;
}

+ (void (^)(SEL _Nonnull, NSString * _Nonnull, SEL _Nonnull))ajSwizzleMethodWithClassName {
    kAJWeakSelf
    void (^block)(SEL, NSString *, SEL) = ^(SEL origMethod, NSString *withClassName, SEL withMethod){
        if (!withClassName.ajNonEmpty) {
            return ;
        }
        Class origClass = [ajSelf class];
        Class withClass = NSClassFromString(withClassName);
        ajSelf.ajSwizzleMethodWithClass(origClass, origMethod, withClass, withMethod);
    };
    return block;
}

+ (void (^)(Class  _Nonnull __unsafe_unretained, SEL _Nonnull, Class  _Nonnull __unsafe_unretained, SEL _Nonnull))ajSwizzleMethodWithClass {
    void (^block)(Class, SEL, Class, SEL) = ^(Class origClass, SEL origMethod, Class withClass, SEL withMethod){
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
    };
    return block;
}

@end
