//
//  TableViewCell1.m
//  PPT
//
//  Created by 徐结兵 on 2020/6/4.
//  Copyright © 2020 徐结兵. All rights reserved.
//

#import "TableViewCell1.h"
#import <AJKit/AJKit.h>

@implementation TableViewCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)ajInitView {
    self.textLabel.textColor = UIColor.redColor;
}

- (void)refreshCellWithModel:(NSString *)title complete:(AJCellComplete)complete {
    if (NSString.ajIsEmpty(title)) {
        return;
    }
    self.textLabel.text = title;
}

@end
