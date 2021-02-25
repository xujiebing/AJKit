//
//  NSURL+AJKit.m
//  Base64
//
//  Created by 徐结兵 on 2020/4/13.
//

#import "NSURL+AJKit.h"

@implementation NSURL (AJKit)

- (BOOL)ajMethodUndefinedCrash {
    return NO;
}

static NSURL *_ajDocumentsURL = nil;
+ (NSURL *)ajDocumentsURL {
    if (!_ajDocumentsURL) {
        NSArray *array = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
        _ajDocumentsURL = array.lastObject;
    }
    return _ajDocumentsURL;
}

static NSURL *_ajCachesURL = nil;
+ (NSURL *)ajCachesURL {
    if (!_ajCachesURL) {
        NSArray *array = [NSFileManager.defaultManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
        _ajCachesURL = array.lastObject;
    }
    return _ajCachesURL;
}

static NSURL *_ajLibraryURL = nil;
+ (NSURL *)ajLibraryURL {
    if (!_ajLibraryURL) {
        NSArray *array = [NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];
        _ajLibraryURL = array.lastObject;
    }
    return _ajLibraryURL;
}

- (NSDictionary *)ajUrlParams {
    NSString *url = self.absoluteString;
    NSArray *components = [url componentsSeparatedByString:@"?"];
    NSString *path = components.firstObject;
    if (path.length > 0){
        NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
        mutDict[@"URL"] = path;
        NSString *dataStr = [url substringFromIndex:path.length];
        if (dataStr.length > 0){
            //去掉?
            dataStr = [dataStr substringFromIndex:1];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSArray* paramParis = [dataStr componentsSeparatedByString:@"&"];
            for (NSString *param in paramParis){
                NSArray *kv = [param componentsSeparatedByString:@"="];
                [params setObject:kv.lastObject forKey:kv.firstObject];
            }
            mutDict[@"PARAMS"] = params;
            
        }
        
        return mutDict;
    }
    return nil;
}

- (NSDictionary *)ajUrlComponents {
    NSString *url = self.absoluteString;
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:url];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    if(!components) {
        return dic;
    }
    NSArray<NSURLQueryItem *> *items = components.queryItems;
    [items enumerateObjectsUsingBlock:^(NSURLQueryItem *item, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *name = item.name;
        NSString *value = item.value;
        
        if (!value) {
            value = @"";
        }
        [dic setObject:value forKey:name];
    }];
    return dic;
    
}

+ (NSURL *)ajGenerateURL:(NSString *)host params:(NSDictionary *)params {
    NSMutableString *mutString = [NSMutableString string];
    [mutString appendString:host];
    NSArray *allKeys = params.allKeys;;
    if (allKeys.count > 0){
        [mutString appendString:@"?"];
        for (int i = 0; i < allKeys.count; i++){
            id key = allKeys[i];
            id value = params[key];
            [mutString appendString:[NSString stringWithFormat:@"%@=%@",key,value]];
            if (i < params.count - 1){
                [mutString appendString:@"&"];
            }
            
        }
    }
    NSURL *url = [NSURL URLWithString:mutString];
    return url;
}

- (void)ajOpenInSafari {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(![UIApplication.sharedApplication canOpenURL:self]) {
            AJLog(@"打开系统自带浏览器时, URL格式传的不对, URL是:%@", self);
            return;
        }
        [UIApplication.sharedApplication openURL:self];
    });
}

@end
