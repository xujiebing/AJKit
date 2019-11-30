//
//  NSFileManager+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "NSFileManager+AJKit.h"

@implementation NSFileManager (AJKit)

+ (NSURL *)ajDocumentsURL {
    NSArray *array = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    return array.lastObject;
}

+ (NSURL *)ajCachesURL {
    NSArray *array = [NSFileManager.defaultManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask];
    return array.lastObject;
}

+ (NSURL *)ajLibraryURL {
    NSArray *array = [NSFileManager.defaultManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask];
    return array.lastObject;
}

@end
