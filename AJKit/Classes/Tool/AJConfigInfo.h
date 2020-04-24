//
//  AJConfigInfo.h
//  AJAD
//
//  Created by 徐结兵 on 2020/4/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJConfigInfo : NSObject

@property (class, nonatomic, copy, readonly) NSString *msxDomain;

@property (class, nonatomic, copy, readonly) NSString *gatewayDomain;

@property (class, nonatomic, copy, readonly) NSString *businessDomain;

@property (class, nonatomic, copy, readonly) NSString *h5IpPart;

@property (class, nonatomic, copy, readonly) NSString *bundleId;

@property (class, nonatomic, assign, readonly) NSInteger bundleVersion;

@property (class, nonatomic, copy, readonly) NSString *shortVersion;

@property (class, nonatomic, copy, readonly) NSString *appName;

@property (class, nonatomic, copy, readonly) NSString *appScheme;

@property (class, nonatomic, assign, readonly) BOOL isDebugKey;

@property (class, nonatomic, assign, readonly) BOOL isSupportTouchID;

@end

NS_ASSUME_NONNULL_END
