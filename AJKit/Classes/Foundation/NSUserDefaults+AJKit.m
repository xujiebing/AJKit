//
//  NSUserDefaults+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2020/4/24.
//

#import "NSUserDefaults+AJKit.h"

@implementation NSUserDefaults (AJKit)

+ (void)ajSetValue:(id)value forKey:(NSString *)key {
    if (!value || key.length == 0) {
        AJAssert(0, @"value or key is nil");
        return;
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}

+ (id)ajObjectForKey:(NSString *)key {
    if (key.length == 0) {
        AJAssert(0, @"key is nil");
        return nil;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+ (void)ajRemoveObjectForKey:(NSString *)key {
    
    if (key.length == 0) {
        AJAssert(0, @"key is nil");
        return;
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}


+ (void)ajSetValue:(id _Nonnull)value
            forKey:(NSString *_Nonnull)key
        moduleName:(NSString *)name {

    if (!value || key.length == 0) {
        AJAssert(0, @"value or key is nil");
        return;
    }

    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:name];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}

+ (id)ajObjectForKey:(NSString *)key moduleName:(NSString *)moduleName {
    if (key.length == 0) {
        AJAssert(0, @"key is nil");
        return nil;
    }
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:moduleName];
    return [defaults objectForKey:key];
}


+ (void)ajRemoveObjectForKey:(NSString *_Nonnull)key
                  moduleName:(NSString *_Nullable)moduleName {
    if (key.length == 0) {
        AJAssert(0, @"key is nil");
        return;
    }

    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:moduleName];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

+ (void)ajRemoveObjectWithModuleName:(NSString *)moduleName {
    if (moduleName.length == 0) {
        AJAssert(0, @"moduleName is nil");
        return;
    }
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:moduleName];
    NSDictionary *dic = [defaults dictionaryRepresentation];
    for (id key in dic) {
        [defaults removeObjectForKey:key];
        [defaults synchronize];
    }
}

@end
