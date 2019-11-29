//
//  GCPlaceholderTextView.h
//  GCLibrary
//
//  Created by Guillaume Campagna on 10-11-16.
//  Copyright 2010 LittleKiwi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCPlaceholderTextView : UITextView
// 新增,只有在写评论时,才needDraw占位符
@property (nonatomic,assign)BOOL isNeedDraw;
@property(nonatomic, strong) NSString *placeholder;
// 这个是画的内容
@property(nonatomic, strong) NSString *placeholder_Draw;
@property (nonatomic, strong) UIColor *realTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *placeholderColor UI_APPEARANCE_SELECTOR;

@end
