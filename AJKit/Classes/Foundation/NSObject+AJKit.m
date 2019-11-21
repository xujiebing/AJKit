//
//  NSObject+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import "NSObject+AJKit.h"

@implementation NSObject (AJKit)

+ (NSString *)ajClassName {
  return NSStringFromClass(self);
}

- (BOOL)ajIsJSONObject {
  if ([NSJSONSerialization isValidJSONObject:self]) return YES;
  return NO;
}

- (NSString *)ajClassName {
  return [NSString stringWithUTF8String:class_getName([self class])];
}

@end
