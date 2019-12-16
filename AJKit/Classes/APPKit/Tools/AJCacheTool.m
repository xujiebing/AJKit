//
//  AJCacheTool.m
//  AJKit
//
//  Created by 徐结兵 on 2019/12/16.
//

#import "AJCacheTool.h"

@implementation AJCacheTool

+ (void)setValue:(id)value forKey:(NSString *)key {
    if (!value || key.length == 0) {
        NSAssert(0, @"");
        return;
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}

+ (id)objectForKey:(NSString *)key {
    if (key.length == 0) {
        NSAssert(0, @"");
        return nil;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+ (void)removeObjectWithKey:(NSString *)key {
    
    if (key.length == 0) {
        NSAssert(0, @"");
        return;
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}


+ (void)setValue:(id _Nonnull)value
          forKey:(NSString *_Nonnull)key
      moduleName:(NSString *)name {

    if (!value || key.length == 0) {
        NSAssert(0, @"");
        return;
    }

    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:name];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}

+ (id)objectForKey:(NSString *)key moduleName:(NSString *)moduleName {
    if (key.length == 0) {
        NSAssert(0, @"");
        return nil;
    }
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:moduleName];
    return [defaults objectForKey:key];
}


+ (void)removeObjectWithKey:(NSString *_Nonnull)key
                 moduleName:(NSString *_Nullable)moduleName {
    if (key.length == 0) {
        NSAssert(0, @"");
        return;
    }

    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:moduleName];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

+ (void)removeObjectWithModuleName:(NSString *)moduleName {
    if (moduleName.length == 0) {
        NSAssert(0, @"");
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
