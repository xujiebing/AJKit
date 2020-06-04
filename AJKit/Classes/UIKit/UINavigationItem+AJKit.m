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

@property (nonatomic, copy) AJNavigationItemCallback leftCallback;

@end

static NSString * const AJLeftButtonCallbackKey = @"AJLeftButtonCallbackKey";
static NSString * const AJRightButtonCallbackKey = @"AJRightButtonCallbackKey";

@implementation UINavigationItem (AJKit)

#pragma mark - 导航栏左边按钮

- (void)ajAddLeftButtonWithImage:(UIImage *)image callback:(AJNavigationItemCallback)callback {
    if (callback) {
        objc_setAssociatedObject(self, &AJLeftButtonCallbackKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(p_ajLeftButtonSelector)];
    self.leftBarButtonItem = btnItem;
}

- (void)ajAddLeftButtonWithTitle:(NSString *)title callback:(AJNavigationItemCallback)callback {
    if (callback) {
        objc_setAssociatedObject(self, &AJLeftButtonCallbackKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(p_ajLeftButtonSelector)];
    self.leftBarButtonItem = btnItem;
}

- (void)ajRemoveLeftButton {
    self.leftBarButtonItem = nil;
}

- (void)p_ajLeftButtonSelector {
    AJNavigationItemCallback callback = objc_getAssociatedObject(self, &AJLeftButtonCallbackKey);
    if (callback) {
        callback();
        objc_setAssociatedObject(self, &AJLeftButtonCallbackKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

#pragma mark - 导航栏右边按钮

- (void)ajAddRightButtonWithImage:(UIImage *)image callback:(AJNavigationItemCallback)callback {
    if (callback) {
        objc_setAssociatedObject(self, &AJRightButtonCallbackKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(p_ajRightButtonSelector)];
    self.rightBarButtonItem = btnItem;
}

- (void)ajAddRightButtonWithTitle:(NSString *)title callback:(AJNavigationItemCallback)callback {
    if (callback) {
        objc_setAssociatedObject(self, &AJRightButtonCallbackKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(p_ajRightButtonSelector)];
    self.rightBarButtonItem = btnItem;
}

- (void)ajRemoveRightButton {
    self.rightBarButtonItem = nil;
}
- (void)p_ajRightButtonSelector {
    AJNavigationItemCallback callback = objc_getAssociatedObject(self, &AJRightButtonCallbackKey);
    if (callback) {
        callback();
        objc_setAssociatedObject(self, &AJRightButtonCallbackKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
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

