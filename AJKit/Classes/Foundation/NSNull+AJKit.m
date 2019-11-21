//
//  NSNull+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import "NSNull+AJKit.h"

@implementation NSNull (AJKit)

- (BOOL)isEqualToString:(NSString *)aString {
    AJLog(@"[NSNull]没有[isEqualToString:]方法.");
    return NO;
}

- (NSUInteger)length {
    AJLog(@"[NSNull]没有[length]方法.");
    return 0;
}

- (float)floatValue {
    AJLog(@"[NSNull]没有[floatValue]方法.");
    return 0.00;
}

- (double)doubleValue {
    AJLog(@"[NSNull]没有[doubleValue]方法.");
    return 0.00;
}

- (NSInteger)integerValue {
    AJLog(@"[NSNull]没有[integerValue]方法.");
    return 0;
}

- (NSUInteger)count {
    AJLog(@"[NSNull]没有[count]方法.");
    return 0;
}

- (id)objectForKey:(id)aKey {
    AJLog(@"[NSNull]没有[objectForKey]方法.");
    return @"";
}

- (id)objectForKeyedSubscript:(id)key {
    AJLog(@"[NSNull]没有[objectForKeyedSubscript]方法.");
    return @"";
}

- (NSString *)substringFromIndex:(NSUInteger)from {
    AJLog(@"[NSNull]没有[substringFromIndex]方法.");
    return @"";
}

- (NSString *)substringToIndex:(NSUInteger)to {
    AJLog(@"[NSNull]没有[substringToIndex]方法.");
    return @"";
}

- (NSString *)stringValue {
    AJLog(@"[NSNull]没有[stringValue]方法.");
    return @"";
}

@end
