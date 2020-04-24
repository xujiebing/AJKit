//
//  NSURL+AJKit.h
//  Base64
//
//  Created by 徐结兵 on 2020/4/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (AJKit)

@property(class, nonatomic, strong, readonly) NSURL *ajDocumentsURL;
@property(class, nonatomic, strong, readonly) NSURL *ajCachesURL;
@property(class, nonatomic, strong, readonly) NSURL *ajLibraryURL;

/// 根据URL切割参数  返回  {URL:host路径, PARAMS:参数集}
- (NSDictionary *)ajUrlParams;

/// 根据URLComponents切割参数
- (NSDictionary *)ajUrlComponents;

/// 将参数拼接到host末尾
/// @param host host
/// @param params params
+ (NSURL *)ajGenerateURL:(NSString *)host params:(NSDictionary *)params;

/// 在safari中打开url链接
- (void)ajOpenInSafari;

@end

NS_ASSUME_NONNULL_END
