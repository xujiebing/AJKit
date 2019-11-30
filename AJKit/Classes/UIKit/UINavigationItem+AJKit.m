//
//  UINavigationItem+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2019/11/30.
//

#import "UINavigationItem+AJKit.h"

@interface UINavigationItem ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) UILabel *titleLabel;

@end

static NSString * const AJUINavigationItemBgViewKey                 = @"AJUINavigationItemBgViewKey";
static NSString * const AJUINavigationItemActivityIndicatorKey      = @"AJUINavigationActivityIndicatorKey";
static NSString * const AJUINavigationItemTitleStrKey               = @"AJUINavigationTitleStrKey";
static NSString * const AJUINavigationItemTitleLabelKey             = @"AJUINavigationTitleLabelKey";

@implementation UINavigationItem (AJKit)

#pragma mark - 导航栏左边按钮

- (void (^)(NSString * _Nonnull))ajAddBackButtonWithTitle {
    kAJWeakSelf
    void (^block)(NSString *) = ^(NSString *title){
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
        ajSelf.backBarButtonItem = btnItem;
    };
    return block;
}

- (void (^)(UIImage * _Nonnull, id _Nonnull, SEL _Nonnull))ajAddLeftButtonWithImage {
    kAJWeakSelf
    void (^block)(UIImage *, id, SEL) = ^(UIImage *image, id target, SEL selector){
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:selector];
        ajSelf.leftBarButtonItem = btnItem;
    };
    return block;
}

- (void (^)(NSString * _Nonnull, id _Nonnull, SEL _Nonnull))ajAddLeftButtonWithTitle {
    kAJWeakSelf
    void (^block)(NSString *, id, SEL) = ^(NSString *title, id target, SEL selector){
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:selector];
        ajSelf.leftBarButtonItem = btnItem;
    };
    return block;
}

- (void)ajRemoveLeftButton {
    self.leftBarButtonItem = nil;
}

#pragma mark - 导航栏右边按钮

- (void (^)(UIImage * _Nonnull, id _Nonnull, SEL _Nonnull))ajAddRightButtonWithImage {
    kAJWeakSelf
    void (^block)(UIImage *, id, SEL) = ^(UIImage *image, id target, SEL selector){
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:selector];
        ajSelf.rightBarButtonItem = btnItem;
    };
    return block;
}

- (void (^)(NSString * _Nonnull, id _Nonnull, SEL _Nonnull))ajAddRightButtonWithTitle {
    kAJWeakSelf
    void (^block)(NSString *, id, SEL) = ^(NSString *title, id target, SEL selector){
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:selector];
        ajSelf.rightBarButtonItem = btnItem;
    };
    return block;
}

- (void)ajRemoveRightButton {
    self.rightBarButtonItem = nil;
}

#pragma mark - 导航栏中间旋转菊花

- (void (^)(NSString * _Nonnull))ajStartAnimatingWithTitle {
    kAJWeakSelf
    void (^block)(NSString *) = ^(NSString *title){
        if (title.length == 0) {
            title = ajSelf.titleStr;
        }
        //计算titleLabel宽度
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName,nil];
        CGSize actualsize = [title boundingRectWithSize:CGSizeMake(280,40) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        //自定义titleView
        UIView *titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, actualsize.width + 25, 40)];
        self.titleView = titleBgView;
        self.bgView.frame = CGRectMake(0, 0, actualsize.width + 25, 40);
        self.bgView.center = titleBgView.center;
        [titleBgView addSubview:self.bgView];
        //菊花开始旋转
        [self.activityIndicator startAnimating];
        //设置标题label
        self.titleLabel.frame = CGRectMake(25, 0, actualsize.width, 40);
        self.titleLabel.text = title;
        [self.bgView addSubview:self.titleLabel];
    };
    return block;
}

- (void)ajStartAnimating {
    self.ajStartAnimatingWithTitle(self.titleStr);
}

- (void)ajStopAnimating {
    kAJWeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //菊花停止旋转
        [ajSelf.activityIndicator stopAnimating];
        CGPoint point = ajSelf.bgView.center;
        //计算titleLabel宽度
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName,nil];
        CGSize actualsize = [ajSelf.titleStr boundingRectWithSize:CGSizeMake(280,40) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        ajSelf.bgView.frame = CGRectMake(0, 0, actualsize.width, 40);
        ajSelf.bgView.center = point;
        ajSelf.titleLabel.text = ajSelf.titleStr;
        ajSelf.titleLabel.frame = CGRectMake(0, 0, actualsize.width, 40);
    });
}

#pragma mark - 内部方法

- (void)setTitle:(NSString *)title {
    UIFont *font = [UIFont boldSystemFontOfSize:17.0f];
    CGSize textSize = [self p_autoCalculateRectWithTitle:title font:17.0f size:CGSizeMake(UIScreen.mainScreen.bounds.size.width, 9999)];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 10.f;
    label.backgroundColor = UIColor.clearColor;
    label.font = font;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = UINavigationBar.appearance.tintColor;
    label.text = title;
    self.titleView = label;
    self.titleStr = title;
}


- (CGSize)p_autoCalculateRectWithTitle:(NSString*)title
                                  font:(CGFloat)font
                                  size:(CGSize)size {
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary* attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:font],
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize = [title boundingRectWithSize:size
                                           options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                        attributes:attributes
                                           context:nil].size;
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    return labelSize;
}

#pragma mark - 动态属性

- (UIView *)bgView {
    UIView *bgView = objc_getAssociatedObject(self, &AJUINavigationItemBgViewKey);
    if(!bgView) {
        bgView = [[UIView alloc] init];
        [self setBgView:bgView];
    }
    return bgView;
}

- (void)setBgView:(UIView *)bgView {
    objc_setAssociatedObject(self, &AJUINavigationItemBgViewKey, bgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)activityIndicator {
    UIActivityIndicatorView *activityIndicator = objc_getAssociatedObject(self, &AJUINavigationItemActivityIndicatorKey);
    if(!activityIndicator) {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicator.center = CGPointMake(10.0f, 20.0f);
        activityIndicator.color = UINavigationBar.appearance.tintColor;
        [self.bgView addSubview:activityIndicator];
        [self setActivityIndicator:activityIndicator];
    }
    return activityIndicator;
}

- (void)setActivityIndicator:(UIActivityIndicatorView *)activityIndicator {
    objc_setAssociatedObject(self, &AJUINavigationItemActivityIndicatorKey, activityIndicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)titleStr {
    NSString *titleStr = objc_getAssociatedObject(self, &AJUINavigationItemTitleStrKey);
    if (!titleStr) {
        titleStr = self.title;
        [self setTitleStr:titleStr];
    }
    return titleStr;
}

- (void)setTitleStr:(NSString *)titleStr {
    objc_setAssociatedObject(self, &AJUINavigationItemTitleStrKey, titleStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)titleLabel {
    UILabel *titleLabel = objc_getAssociatedObject(self, &AJUINavigationItemTitleLabelKey);
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textColor = UINavigationBar.appearance.tintColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleLabel:titleLabel];
    }
    return titleLabel;
}

- (void)setTitleLabel:(UILabel *)titleLabel {
    objc_setAssociatedObject(self, &AJUINavigationItemTitleLabelKey, titleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
