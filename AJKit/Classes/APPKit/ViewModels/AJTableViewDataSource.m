//
//  AJTableViewDataSource.m
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import "AJTableViewDataSource.h"

@interface AJTableViewDataSource ()

@property (nonatomic, assign) BOOL hasSection;              // 是否有分组
@property (nonatomic, assign) BOOL isCanEdit;               // cell是否可编辑

@property (nonatomic, copy) AJRegisterCellCallback registerCellBlock;
@property (nonatomic, copy) AJEditingCellCallback editingCellBlock;
@property (nonatomic, copy) AJConfigCellCallback configCellBlock;

@property (nonatomic, strong) NSArray *itemsArray;

@end

@implementation AJTableViewDataSource

#pragma mark - 系统方法

- (void)dealloc {
    NSLog(@"AJTableViewDataSource dealloc");
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self aj_initData];
    }
    return self;
}

- (void)aj_initData {
    self.hasSection = NO;
    self.sectionCount = 0;
    self.currentPage = 1;
    self.pageSize = 10;
}

#pragma mark - 公共方法

- (void)registerCellCallback:(AJRegisterCellCallback)callback {
    self.registerCellBlock = callback;
}

- (void)editCellCallback:(AJEditingCellCallback)callback {
    self.editingCellBlock = callback;
    _isCanEdit = (callback != nil);
}

- (void)configCellCallback:(AJConfigCellCallback)callback {
    self.configCellBlock = callback;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.hasSection) {
        return [[self.itemsArray ajObjectAtIndex:indexPath.section] ajObjectAtIndex:indexPath.row];
    }
    return [self.itemsArray ajObjectAtIndex:indexPath.row];
}

- (void)setSectionCount:(NSUInteger)count {
    if (count > 0) {
        _sectionCount = count;
        self.hasSection = YES;
    }
}

- (void)addItems:(NSArray *)items {
    if (NSArray.ajIsEmpty(items) && self.currentPage == 1) {
        self.itemsArray = @[];
        return;
    }
    if (items.count < self.pageSize) {
        self.hasNextPage = NO;
    } else {
        self.hasNextPage = YES;
    }
    if (NSArray.ajIsEmpty(self.itemsArray)) {
        self.itemsArray = items;
        return;
    }
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.itemsArray];
    if (self.currentPage == 1) {
        [tempArray removeAllObjects];
    }
    [tempArray addObjectsFromArray:items];

    self.itemsArray = tempArray;
}

- (void)resetItems:(NSArray *)items {
    if (NSArray.ajIsEmpty(items)) {
        return;
    }
    self.itemsArray = items;
}

- (void)removeItems {
    self.itemsArray = @[];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (NSArray.ajIsEmpty(self.itemsArray)) {
        return 0;
    }
    if (!self.hasSection) {
        return self.itemsArray.count;
    }
    NSArray *array = self.itemsArray[section];
    if (NSArray.ajIsEmpty(array)) {
        return 0;
    }
    return array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.hasSection) {
        return self.sectionCount;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier;
    if (self.registerCellBlock) {
        cellIdentifier = self.registerCellBlock(indexPath);
    }
    UITableViewCell *cell = nil;
    if(NSString.ajIsEmpty(cellIdentifier)) {
        NSString *reuseIdentifier = [@"ajKitCell" stringByAppendingFormat:@"%d", indexPath.row];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    if (self.configCellBlock) {
        id item = [self itemAtIndexPath:indexPath];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.configCellBlock(cell, item, indexPath);
        });
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.isCanEdit;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (self.editingCellBlock) {
            self.editingCellBlock(indexPath);
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

#pragma mark - 懒加载方法

- (NSArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSArray alloc] init];
    }
    return _itemsArray;
}

@end
