//
//  NSError+AJKit.m
//  AJAD
//
//  Created by 徐结兵 on 2020/4/15.
//

#import "NSError+AJKit.h"

@implementation NSError (AJKit)

- (BOOL)ajMethodUndefinedCrash {
    return NO;
}

- (NSString *)errorCode {
    id description = self.localizedDescription;
    if (!NSString.ajIsEmpty(description)) {
        return NSString.ajStringFromInteger(self.code);
    }
    // FIXME 这里用kindOfClass 会匹配不上，目前还未找到原因，所以用字符串来匹配(这里会有问题，在AppDelegate中又正常)
    RACTuple *tuple = description;
    if([tuple.ajClassName rangeOfString:@"Tuple"].location != NSNotFound) {
        return tuple.errorCode;
    }
    return nil;
}

- (NSString *)errorMessage {
    id description = self.localizedDescription;
    if (!NSString.ajIsEmpty(description)) {
        return self.localizedDescription;
    }
    // FIXME 这里用kindOfClass 会匹配不上，目前还未找到原因，所以用字符串来匹配(这里会有问题，在AppDelegate中又正常)
    RACTuple *tuple = description;
    if([tuple.ajClassName rangeOfString:@"Tuple"].location != NSNotFound) {
        return tuple.errorMessage;
    }
    return nil;
}

@end
