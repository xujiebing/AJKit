//
//  TableViewController.m
//  PPT
//
//  Created by 徐结兵 on 2020/6/3.
//  Copyright © 2020 徐结兵. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "TableViewCell1.h"
#import "TableViewCell2.h"
#import <AJKit/AJKit.h>

@interface TableViewController ()

@property (nonatomic, copy) AJTableViewDataSource *dataSource;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_initData];
    [self p_initView];
}

#pragma mark - 重写方法

- (void)configTableViewSource {
    self.tableViewStyle = UITableViewStyleGrouped;
    kAJWeakSelf
    [self.ajDataSource registerCellCallback:^NSString *(NSIndexPath *indexPath) {
        NSString *cellName;
        if (indexPath.section == 0) {
            Class class = TableViewCell.class;
            cellName = NSStringFromClass(class);
            [ajSelf.tableView registerClass:TableViewCell.class forCellReuseIdentifier:cellName];
        } else if (indexPath.section == 1) {
            Class class = TableViewCell1.class;
            cellName = NSStringFromClass(class);
            [ajSelf.tableView registerClass:class forCellReuseIdentifier:cellName];
        } else {
            cellName = TableViewCell2.ajClassName;
            UINib *nib = [UINib nibWithNibName:cellName bundle:nil];
            [ajSelf.tableView registerNib:nib forCellReuseIdentifier:cellName];
        }
        return cellName;
    }];
    [self.ajDataSource configCellCallback:^(id cell, id item, NSIndexPath *indexPath) {
        AJTableViewCell *realCell = cell;
        if (indexPath.section == 1) {
            realCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [realCell refreshCellWithModel:item complete:^(id  _Nonnull item) {
            NSLog(@"");
        }];
    }];
    
    
}

- (void)requestDataSourceWithPage:(NSInteger)page {
//    NSArray *array = @[@"title1", @"title2", @"title3"];
    NSArray *array = @[
    @[@"title1", @"title2", @"title3"],
    @[@"title1", @"title2", @"title3"],
    @[@"title1", @"title2", @"title3"],
    ];
    self.ajDataSource.sectionCount = array.count;
    [self.ajDataSource addItems:array];
}

- (void)viewForHeaderInSection:(NSInteger)section headerView:(UITableViewHeaderFooterView *)headerView {
    if (section == 0) {
        headerView.contentView.backgroundColor = UIColor.redColor;
    } else if (section == 1) {
        headerView.contentView.backgroundColor = UIColor.yellowColor;
    } else {
        headerView.contentView.backgroundColor = UIColor.blackColor;
    }
}

- (void)viewForFooterInSection:(NSInteger)section footerView:(UITableViewHeaderFooterView *)footerView {
    if (section == 0) {
        footerView.contentView.backgroundColor = UIColor.redColor;
    } else if (section == 1) {
        footerView.contentView.backgroundColor = UIColor.yellowColor;
    } else {
        footerView.contentView.backgroundColor = UIColor.blackColor;
    }
}

- (CGFloat)heightForFooterInSection:(NSInteger)section {
    return 8;
}

#pragma mark - 私有方法

- (void)p_initData {
    
}

- (void)p_initView {
    
}

#pragma mark - Getter方法

- (AJTableViewDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = AJTableViewDataSource.new;
    }
    return _dataSource;;
}

@end
