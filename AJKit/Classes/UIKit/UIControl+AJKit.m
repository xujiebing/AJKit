//
//  UIControl+AJKit.m
//  AJKit
//
//  Created by 徐结兵 on 2020/7/1.
//

#import "UIControl+AJKit.h"

@implementation UIControl (AJKit)

#pragma mark - 公共方法

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ajSwizzleMethod:@selector(setEnabled:) withMethod:@selector(toucheffect_setEnabled:)];
        [self ajSwizzleMethod:@selector(sendAction:to:forEvent:) withMethod:@selector(toucheffect_sendAction:to:forEvent:)];
    });
}

- (void)setAjShowTouchEffect:(BOOL)ajShowTouchEffect {
    [self p_checkTouechEffect:ajShowTouchEffect];
}

- (BOOL)ajShowTouchEffect {
    return NO;
}

#pragma mark - 私有方法

- (void)p_checkTouechEffect:(BOOL)showTouchEffect {
    if (showTouchEffect) {
        [self addTarget:self action:@selector(itemTouchedUpInside) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(itemTouchedUpOutside) forControlEvents:UIControlEventTouchUpOutside];
//        [self addTarget:self action:@selector(itemTouchedDown) forControlEvents:UIControlEventTouchDragEnter];
        [self addTarget:self action:@selector(itemTouchedDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(itemTouchedDown) forControlEvents:UIControlEventTouchDownRepeat];
        [self addTarget:self action:@selector(itemTouchedCancel) forControlEvents:UIControlEventTouchCancel];
    }else{
//        self.alpha = 1;
        [self removeTarget:self action:@selector(itemTouchedUpInside) forControlEvents:UIControlEventTouchUpInside];
        [self removeTarget:self action:@selector(itemTouchedUpOutside) forControlEvents:UIControlEventTouchUpOutside];
        [self removeTarget:self action:@selector(itemTouchedDown) forControlEvents:UIControlEventTouchDown];
        [self removeTarget:self action:@selector(itemTouchedDown) forControlEvents:UIControlEventTouchDownRepeat];
        [self removeTarget:self action:@selector(itemTouchedCancel) forControlEvents:UIControlEventTouchCancel];
    }
    [super layoutSubviews];
}

- (void)toucheffect_setEnabled:(BOOL)value {
    self.alpha = value ? 1 : 0.5;
    [self toucheffect_setEnabled:value];
}

- (void)itemTouchedUpOutside {
    self.alpha = 1;
}

- (void)itemTouchedDown {
    self.alpha = 0.5;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(touchDelayEffect:) object:NULL];
}

- (void)itemTouchedUpInside {
    [self performSelector:@selector(touchDelayEffect:) withObject:NULL afterDelay:0.05];
}

- (void)touchDelayEffect:(nullable id)object {
    self.alpha = 1;
}

- (void)itemTouchedCancel {
    self.alpha = 1;
}

// 因category不能添加属性，只能通过关联对象的方式。
static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
- (NSTimeInterval)ajAcceptEventInterval {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setAjAcceptEventInterval:(NSTimeInterval)ajAcceptEventInterval {
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(ajAcceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char *UIControl_acceptEventTime = "UIControl_acceptEventTime";

- (NSTimeInterval)cs_acceptEventTime {
    return  [objc_getAssociatedObject(self, UIControl_acceptEventTime) doubleValue];
}

- (void)setCs_acceptEventTime:(NSTimeInterval)cs_acceptEventTime {
    objc_setAssociatedObject(self, UIControl_acceptEventTime, @(cs_acceptEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)toucheffect_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (![NSStringFromSelector(action) isEqual: @"itemTouchedDown"] &&
        ![NSStringFromSelector(action) isEqual: @"itemTouchedCancel"] &&
        ![NSStringFromSelector(action) isEqual: @"itemTouchedUpInside"] &&
        ![NSStringFromSelector(action) isEqual: @"itemTouchedUpOutside"] ) {
        
        if (self.ajAcceptEventInterval > 0) {
            if ([NSDate date].timeIntervalSince1970 - self.cs_acceptEventTime < self.ajAcceptEventInterval) {
                return;
            }
            self.cs_acceptEventTime = [NSDate date].timeIntervalSince1970;
        }
    }
    [self toucheffect_sendAction:action to:target forEvent:event];
}

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

- (void)ajSetEnlargeEdge:(CGFloat)size {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)ajSetEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge){
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }else{
        return self.bounds;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)){
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}

@end
