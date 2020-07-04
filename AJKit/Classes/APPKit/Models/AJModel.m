//
//  AJModel.m
//  AJKit
//
//  Created by 徐结兵 on 2020/6/12.
//

#import "AJModel.h"

@implementation AJModel

- (NSString *)debugDescription {
    NSString *desc = [NSString stringWithFormat:@"\n<%@ : %p>\n\n", self.ajClassName, self];
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        const char * propName = property_getName(property);
        if (!propName) {
            continue;
        }
        NSString *prop = [NSString stringWithCString:propName encoding:[NSString defaultCStringEncoding]];
        id obj = [self valueForKey:prop];
        desc = [desc stringByAppendingFormat:@"%@ : %@;\n", prop, obj];
    }
    desc = [desc stringByAppendingFormat:@"\n<%@ : %p>\n", self.ajClassName, self];
    free(properties);
    return desc;
}

@end
