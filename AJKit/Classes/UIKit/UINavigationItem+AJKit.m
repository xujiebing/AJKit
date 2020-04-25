//
//  UINavigationItem+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "UINavigationItem+AJKit.h"
#import <objc/runtime.h>

@interface AJTitleStackView ()

@property (nonatomic, strong, readwrite) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;

@end

@implementation AJTitleStackView

static AJTitleStackView *_sharedInstance = nil;
+ (AJTitleStackView *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] initWithFrame:CGRectZero];
        [_sharedInstance p_initView];
    });
    return _sharedInstance;
}

- (void)p_initView {
    [self addArrangedSubview:self.indicatorView];
    [self addArrangedSubview:self.titleLabel];
    [self setCustomSpacing:10 afterView:self.indicatorView];
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    return _indicatorView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.alloc.init;
    }
    return _titleLabel;
}

@end

@interface UINavigationItem ()

@property (nonatomic, strong, readonly) AJTitleStackView *titleStackView;
@property (nonatomic, copy,readwrite) NSString *ajTitle;

@end

static NSString * const AJLeftButtonCallbackKey = @"AJLeftButtonCallbackKey";
static NSString * const AJRightButtonCallbackKey = @"AJRightButtonCallbackKey";

@implementation UINavigationItem (AJKit)

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectorString = NSStringFromSelector(sel);
}

id ajDictionaryGetter(id self, SEL _cmd) {
    
}

#pragma mark - 导航栏左边按钮

- (void)ajAddLeftButtonWithImage:(UIImage *)image callback:(AJNavigationItemCallback)callback {
    if (callback) {
        [self setValue:callback forKey:AJLeftButtonCallbackKey];
    }
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(p_ajLeftButtonSelector)];
    self.leftBarButtonItem = btnItem;
}

- (void)ajAddLeftButtonWithTitle:(NSString *)title callback:(AJNavigationItemCallback)callback {
    if (callback) {
        [self setValue:callback forKey:AJLeftButtonCallbackKey];
    }
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(p_ajLeftButtonSelector)];
    self.leftBarButtonItem = btnItem;
}

- (void)ajRemoveLeftButton {
    self.leftBarButtonItem = nil;
}

- (void)p_ajLeftButtonSelector {
    AJNavigationItemCallback callback = [self valueForKey:AJLeftButtonCallbackKey];
    if (callback) {
        callback();
        [self setValue:nil forKey:AJLeftButtonCallbackKey];
    }
}

#pragma mark - 导航栏右边按钮

- (void)ajAddRightButtonWithImage:(UIImage *)image callback:(AJNavigationItemCallback)callback {
    if (callback) {
        [self setValue:callback forKey:AJRightButtonCallbackKey];
    }
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(p_ajRightButtonSelector)];
    self.rightBarButtonItem = btnItem;
}

- (void)ajAddRightButtonWithTitle:(NSString *)title callback:(AJNavigationItemCallback)callback {
    if (callback) {
        [self setValue:callback forKey:AJRightButtonCallbackKey];
    }
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(p_ajRightButtonSelector)];
    self.rightBarButtonItem = btnItem;
}

- (void)ajRemoveRightButton {
    self.rightBarButtonItem = nil;
}
- (void)p_ajRightButtonSelector {
    AJNavigationItemCallback callback = [self valueForKey:AJRightButtonCallbackKey];
    if (callback) {
        callback();
        [self setValue:nil forKey:AJRightButtonCallbackKey];
    }
}

#pragma mark - 导航栏中间旋转菊花

- (void)ajStartAnimating {
    [self.titleStackView.indicatorView startAnimating];
}

- (void)ajStopAnimating {
    [self.titleStackView.indicatorView stopAnimating];
}

#pragma mark - Getter方法

- (AJTitleStackView *)titleStackView {
    return AJTitleStackView.sharedInstance;
}

- (NSString *)ajTitle {
    return self.titleStackView.titleLabel.text;
}

#pragma mark - Setter方法

- (void)setAjTitle:(NSString *)ajTitle {
    self.titleStackView.titleLabel.text = ajTitle;
}

@end

