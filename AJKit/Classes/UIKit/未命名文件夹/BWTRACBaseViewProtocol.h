//
//  BWTRACBaseViewProtocol.h
//  BWTKit 抽取VC层通用方法
//
//  Created by 胡浩 on 2017/11/30.
//

#import <UIKit/UIKit.h>

@class BWTRACBaseViewModel;

@protocol BWTRACBaseViewProtocol <NSObject>

@required

/**
 添加导航栏返回按钮
 */
- (void)addBackButton;


/**
 添加左侧带文字的按钮

 @param selector 回调方法
 @param title 按钮上显示的文字
 */
- (void)addLeftButton:(SEL _Nonnull)selector
                title:(NSString * _Nonnull)title;

/**
 添加左侧带默认图片的按钮

 @param selector 回调方法
 */
- (void)addLeftButton:(SEL _Nonnull)selector;

/**
 添加左侧带自定义图片的按钮

 @param selector 回调方法
 @param image 自定义图片
 */
- (void)addLeftButton:(SEL _Nonnull)selector
                image:(UIImage *_Nonnull)image;


/**
 添加右侧按钮

 @param selector 回调方法
 @param image 显示的图片
 @param highImage 高亮显示的图片
 */
- (void)addRightButton:(SEL _Nonnull)selector
                 image:(UIImage *_Nonnull)image
             highImage:(UIImage *_Nonnull)highImage;


/**
 添加右侧按钮

 @param selector 回调方法
 @param image 显示的图片
 */
- (void)addRightButton:(SEL _Nonnull)selector
                 image:(UIImage *_Nonnull)image;


/**
 添加右侧按钮

 @param selector 回调方法
 @param title 按钮文字
 */
- (void)addRightButton:(SEL _Nonnull)selector
                 title:(NSString *_Nonnull)title;


/**
 添加导航栏标题

 @param title 标题内容
 */
- (void)setNavigationTitle:(NSString *_Nonnull)title;



/**
 设置参数方法，此方法是接收路由的请求参数
 
 @param params 具体参数值
 */
- (void)setParameter:(NSDictionary *_Nullable)params;


/**
 关闭当前页面
 */
- (void)closePage;

@end
