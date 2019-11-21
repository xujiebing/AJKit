//
//  NSData+AJAlgorithm.h
//  AJKit
//
//  Created by 徐结兵 on 2019/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (AJAlgorithm)

/// 将NSData对象转换为md5的字符串
- (NSString *)ajMd5String;

/// 将NSData对象换成md5的NSData
- (NSData *)ajMd5Data;

@end

NS_ASSUME_NONNULL_END
