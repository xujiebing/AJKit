//
//  TableViewCell2.m
//  PPT
//
//  Created by 徐结兵 on 2020/6/4.
//  Copyright © 2020 徐结兵. All rights reserved.
//

#import "TableViewCell2.h"
#import <AJKit/AJKit.h>

@interface TableViewCell2 ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation TableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)ajInitView {
    self.titleLabel.textColor = UIColor.blueColor;
}

- (void)refreshCellWithModel:(NSString *)title complete:(AJCellComplete)complete {
    if (NSString.ajIsEmpty(title)) {
        return;
    }
    self.titleLabel.text = title;
}

@end
