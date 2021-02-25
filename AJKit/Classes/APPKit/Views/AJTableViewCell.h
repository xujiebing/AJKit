//
//  AJTableViewCell.h
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJTableViewCell : UITableViewCell

typedef void(^AJCellComplete)(id item);

@property (nonatomic, copy, readwrite) AJCellComplete cellComplete;

#pragma mark - 以下方法子类重写

- (void)ajInitData;

- (void)ajInitView;

- (void)refreshCellWithModel:(id)item complete:(AJCellComplete)complete;

@end

NS_ASSUME_NONNULL_END
