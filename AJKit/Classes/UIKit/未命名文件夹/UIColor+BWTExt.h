//
//  UIColor+BWTExt.h
//  BWTKit
//
//  Created by gaoyang on 2018/6/19.
//

#import <UIKit/UIKit.h>

@interface UIColor (BWTExt)

- (NSString *) hexFromUIColor;

//是否rgba(0,0,0,0)
- (BOOL) isOriginalColor;

+ (UIColor *) colorWithHexString: (NSString *) hexString;

//+(UIColor *) colorWithHexString2: (NSString *) hexString;

@end
