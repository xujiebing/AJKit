//
//  NSFileManager+AJKit.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (AJKit)

+ (NSURL *)ajDocumentsURL;

+ (NSURL *)ajCachesURL;

+ (NSURL *)ajLibraryURL;

@end

NS_ASSUME_NONNULL_END
