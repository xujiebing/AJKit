//
//  AJTableViewCell.m
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import "AJTableViewCell.h"

@interface AJTableViewCell ()

@end

@implementation AJTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self ajInitData];
    [self ajInitView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)ajInitData {
    
}

- (void)ajInitView {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshCellWithModel:(id)item complete:(AJCellComplete)complete {
    
}

@end
