//
//  NSError+AJKit.h
//  AJAD
//
//  Created by 徐结兵 on 2020/4/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const AJErrorDomain = @"com.bwton.app";
static NSString * const kBusinessCode = @"bwtBusinessCode";
static NSString * const kErrorMessage = @"bwtErrorMessage";

static NSError *AJError(NSInteger code, NSString *message) {
    return [NSError errorWithDomain:AJErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey: AJNil(message)}];
}

static NSError *AJBusinessError(NSInteger code, NSString *businessCode, NSString *message) {
    NSDictionary *userInfo = @{kBusinessCode:AJNil(businessCode),
                               kErrorMessage:AJNil(message)};
    return [NSError errorWithDomain:AJErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey: userInfo}];
}

@interface NSError (AJKit)

/// 错误码 转换后的错误码，如服务端错误码为 0005, 则该属性为 80003
@property (nonatomic, copy, readonly) NSString *errorCode;

/// 错误码 服务端返回的原始错误码
@property (nonatomic, copy, readonly) NSString *businessCode;

/// 错误信息
@property (nonatomic, copy, readonly) NSString *errorMessage;

@end

NS_ASSUME_NONNULL_END
