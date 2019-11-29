//
//  BWTLoadingView.m
//  BWTKit
//
//  Created by ccc's MacBook Pro on 2018/7/4.
//

#import "BWTLoadingView.h"
#import "BWTTools.h"
#import "BWTBaseUI.h"

@implementation BWTLoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSBundle *currentBundle = [BWTTools bundleWithBundleName:kBWTBaseUIModuleName className:NSStringFromClass([BWTLoadingView class])];
        self = [[currentBundle loadNibNamed:@"BWTLoadingView" owner:self options:nil] lastObject];
        self.frame = frame;
    }
    return self;
}

@end
