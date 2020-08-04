//
//  NSError+AJKit.m
//  AJAD
//
//  Created by 徐结兵 on 2020/4/15.
//

#import "NSError+AJKit.h"

@implementation NSError (AJKit)

- (BOOL)bwtMethodUndefinedCrash {
    return NO;
}

- (NSString *)errorCode {
    return NSString.ajStringFromInteger(self.code);
}

- (NSString *)businessCode {
    id description = self.localizedDescription;
    if (!NSString.ajIsEmpty(description)) {
        return NSString.ajStringFromInteger(self.code);
    }
    if ([description isKindOfClass:NSDictionary.class]) {
        if ([description ajContainsObjectForKey:kBusinessCode]) {
            return [description ajObjectForKey:kBusinessCode];
        }
    }
    RACTuple *tuple = description;
    if ([tuple isKindOfClass:RACTuple.class]) {
        return tuple.errorCode;
    }
    return nil;
}

- (NSString *)errorMessage {
    id description = self.localizedDescription;
    if (!NSString.ajIsEmpty(description)) {
        return self.localizedDescription;
    }
    if ([description isKindOfClass:NSDictionary.class]) {
        if ([description ajContainsObjectForKey:kErrorMessage]) {
            return [description ajObjectForKey:kErrorMessage];
        }
    }
    RACTuple *tuple = description;
    if ([tuple isKindOfClass:RACTuple.class]) {
        return tuple.errorMessage;
    }
    return nil;
}

@end
