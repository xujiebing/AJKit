//
//  AJArrayDataSource.m
//  AJKit
//
//  Created by 徐结兵 on 2019/12/8.
//

#import "AJArrayDataSource.h"

@interface AJArrayDataSource ()

@property (nonatomic, assign) BOOL hasSection;              // 是否有分组
@property (nonatomic, assign) BOOL isCanEdit;               // cell是否可编辑

@property (nonatomic, copy) AJCellEditingCallback editBlock;
@property (nonatomic, copy) AJCellConfigureCallback configureCellBlock;

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;


@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation AJArrayDataSource

#pragma mark - 系统方法

- (void)dealloc {
    NSLog(@"AJArrayDataSource dealloc");
}

- (id)init {
    NSAssert(0, @"该方法禁用，是使用自定义初始化方法");
    return nil;
}

#pragma mark - 公共方法

- (AJArrayDataSource *)initWithDataSourcce:(NSArray *)dataSource
                            cellIdentifier:(NSString *)cellIdentifier
                                  callback:(AJCellConfigureCallback)callback {
    return [self initWithDataSourcce:dataSource cellIdentifier:cellIdentifier hasSection:NO sectionCount:1 callback:callback];
}

- (AJArrayDataSource *)initWithDataSourcce:(NSArray *)dataSource
                            cellIdentifier:(NSString *)cellIdentifier
                                hasSection:(BOOL)hasSection
                              sectionCount:(NSInteger)sectionCount
                                  callback:(AJCellConfigureCallback)callback {
    self = [super init];
    if (self) {
        self.currentPage = 1;
        self.items = dataSource;
        self.cellIdentifier = cellIdentifier;
        self.configureCellBlock = callback;
        self.hasSection = hasSection;
        self.sectionCount = sectionCount < 1 ? 1 : sectionCount;
    }
    return self;
}

- (void)changeItems:(NSArray *)array {
    if (!array) {
        return;
    }
    self.items = array;
}

- (void)configureCellEditBlock:(AJCellEditingCallback)block {
    _editBlock = block;
    _isCanEdit = (block != nil);
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.sectionCount > 0 && self.hasSection) {
        return self.items[indexPath.section][indexPath.row];
    }
    return self.items[indexPath.row];
}

- (void)setSectionCount:(NSUInteger)count {
    _sectionCount = count < 1 ? 1 : count;
}

- (void)addDataSource:(NSArray *)items {
    if (NSArray.ajIsEmpty(items)) {
        return;
    }
    if (NSArray.ajIsEmpty(self.dataSource)) {
        self.dataSource = items;
        return;
    }
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.dataSource];
    if (self.currentPage == 1) {
        [tempArray removeAllObjects];
    }
    [tempArray addObjectsFromArray:items];

    self.dataSource = tempArray;
}

- (void)clearDataSource {
    self.dataSource = @[];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (NSArray.ajIsEmpty(self.items)) {
        return 0;
    }
    if (!self.hasSection) {
        return self.items.count;
    }
    NSArray *array = self.items[section];
    if ([array isKindOfClass:[NSArray class]]) {
        return array.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    if(self.cellIdentifier) {
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    } else {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;

    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item, indexPath);
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.isCanEdit;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.editBlock(indexPath);
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}


#pragma mark - 懒加载方法

- (NSArray *)items {
    if (!_items) {
        _items = [[NSArray alloc] init];
    }
    return _items;
}

@end
