//
//  BWTRACTableViewController.m
//  MSX 基于RAC的基础类列表视图
//
//  Created by 胡浩 on 2017/6/23.
//  Copyright © 2017年 BWTon. All rights reserved.
//

#import "BWTRACTableViewController.h"
#import "BWTTableViewModel.h"
#import "BWTKit.h"
#import "MJRefresh.h"
#import "BWTBaseUI.h"

static NSString *kFooterImageName = @"BWTRACTableViewControllerFooterImageName";

@interface BWTRACTableViewController () <UITableViewDelegate>

@property (nonatomic, strong, readwrite) UIImageView *footerImageView;    // 底部广告图片
@property (nonatomic, strong, readwrite) BWTTableViewModel *bwt_viewModel;
@property (nonatomic, strong) BWTArrayDataSource *dataSourceAdapter;

@end



@implementation BWTRACTableViewController


#pragma mark - 生命周期方法

- (void)dealloc {
    self.dataSourceAdapter = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self bwt_init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self bwt_init];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self bwt_initView];
    [self bwt_initData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - 自定义方法


- (void)setAutoLoad:(BOOL)autoLoad {
    _autoLoad = autoLoad;
}


- (void)reloadTableView {

    // 添加为空时显示的View
    if (self.bwt_viewModel.dataSource.count == 0) {
        [self.tableView addSubview:self.emptyView];
        self.emptyView.hidden = NO;
    } else {
        [self.emptyView removeFromSuperview];
        self.emptyView.hidden = YES;
    }

    [self.dataSourceAdapter changeItems:self.bwt_viewModel.dataSource];
    [self.tableView reloadData];
    
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}

- (void)endRefreshing {
    if (self.bwt_viewModel.currentPage > 1 && [self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
        return;
    }

    if([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
 
}

+ (void)setFooterImage:(UIImage *)image {
    if (!image) {
        return;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    [BWTTools setValue:imageData forKey:kFooterImageName];
}

- (void)configTableView:(BWTArrayDataSource *)dataSource
              viewModel:(BWTTableViewModel *)viewModel
                  cells:(NSArray *)cells {
    self.tableView.dataSource = dataSource;
    self.bwt_viewModel = viewModel;
    self.dataSourceAdapter = dataSource;
    kWeakSelf
    [cells enumerateObjectsUsingBlock:^(NSString *cellName, NSUInteger idx, BOOL * _Nonnull stop) {
        Class class = NSClassFromString(cellName);
        [weakSelf.tableView registerClass:class forCellReuseIdentifier:cellName];
    }];
}

- (void)configTableView:(BWTArrayDataSource *)dataSource
              viewModel:(BWTTableViewModel *)viewModel
                   nibs:(NSArray *)nibs {
    self.tableView.dataSource = dataSource;
    self.bwt_viewModel = viewModel;
    self.dataSourceAdapter = dataSource;
    kWeakSelf
    [nibs enumerateObjectsUsingBlock:^(NSString *nibName, NSUInteger idx, BOOL * _Nonnull stop) {
        UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
        [weakSelf.tableView registerNib:nib forCellReuseIdentifier:nibName];
    }];
}

- (void)configTableView:(BWTArrayDataSource *)dataSource
              viewModel:(BWTTableViewModel *)viewModel
                   nibs:(NSArray *)nibs
                 bundle:(NSBundle *)bundle {
    self.tableView.dataSource = dataSource;
    self.bwt_viewModel = viewModel;
    self.dataSourceAdapter = dataSource;
    kWeakSelf
    [nibs enumerateObjectsUsingBlock:^(NSString *nibName, NSUInteger idx, BOOL * _Nonnull stop) {
        UINib *nib = [UINib nibWithNibName:nibName bundle:bundle];
        [weakSelf.tableView registerNib:nib forCellReuseIdentifier:nibName];
    }];
}


- (void)headerRefreshViewVisible:(BOOL)visible {
    [self p_headerViewVisible:visible];
}

- (void)footerRefreshViewVisible:(BOOL)visible {
    [self p_footerViewVisible:visible];
}


#pragma mark - 对内方法

- (void)bwt_init {
    // 初始化默认数据
    _autoLoad = YES;
    _closeRefresh = NO;
    _tableViewStyle = UITableViewStylePlain;
}

- (void)bwt_initView {

    self.view.backgroundColor = UIColorFrom10RGB(248, 248, 248);
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerImageView];
    [self configTableViewSource];
    if (!self.closeRefresh) {
        [self p_addHeader];
        [self p_addFooter];
    }
}

- (void)bwt_initData {

    // 数据更新后刷新视图
    @weakify(self)
    [[[RACObserve(self.bwt_viewModel, dataSource)
       distinctUntilChanged]
       deliverOnMainThread]
       subscribeNext:^(id x) {
         @strongify(self)
         [self reloadTableView];
     }];

    // 绑定上拉分页是否可用
    [[RACObserve(self.bwt_viewModel, hasNextPage)
        distinctUntilChanged]
        subscribeNext:^(NSNumber *hasNextPage) {
        @strongify(self)
        self.tableView.mj_footer.hidden = !hasNextPage.boolValue;
    }];

    // 网络请求返回后刷新组件结束刷新
    [[self.bwt_viewModel.requestRemoteDataCommand.executionSignals
      switchToLatest]
      subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self endRefreshing];
    } error:^(NSError * _Nullable error) {
        BWTLog(@"error === %@", error);
    }];

    // 网络返回错误异常监听
    [[[self.bwt_viewModel rac_signalForSelector:@selector(handlerError:)]
        deliverOnMainThread]
        subscribeNext:^(RACTuple * _Nullable x) {
            @strongify(self);
            [self endRefreshing];
            RACTupleUnpack(NSError *error) = x;
            [self handlerError:error];
    }];

    // 底部slogen处理
    [[RACObserve(self.tableView, contentOffset)
      takeUntil:self.rac_willDeallocSignal]
      subscribeNext:^(id change) {
        @strongify(self);

          // slogen的隐藏与显示
          CGFloat tabelVeiwContentHeight = self.tableView.contentSize.height;
          CGFloat viewHeight = self.tableView.frame.size.height;
          if (viewHeight - tabelVeiwContentHeight > 24) {
              CGPoint offset = [change CGPointValue];
              if (viewHeight - tabelVeiwContentHeight + offset.y > 24) {
                  [UIView animateWithDuration:0.5 animations:^{
                      self.footerImageView.alpha = 1;
                  }];
              } else {
                  [UIView animateWithDuration:1 animations:^{
                      self.footerImageView.alpha = 0;
                  }];
              }
         } else {
             [UIView animateWithDuration:0.5 animations:^{
                 @strongify(self);
                 self.footerImageView.alpha = 0;
             }];
         }
    }];
    
}

- (void)p_addHeader {
    kWeakSelf
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf p_headerWithRefreshing];
    }];

    if (self.autoLoad) {
        [self.tableView.mj_header beginRefreshing];
    }
}


- (void)p_addFooter {
    kWeakSelf
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf p_footerWithRefreshing];
    }];
    self.tableView.mj_footer.automaticallyHidden = NO; // 关闭自动分页刷新
    self.tableView.mj_footer.hidden = YES;
}


- (void)p_headerWithRefreshing {
    self.bwt_viewModel.currentPage = 1;
    [self.bwt_viewModel.requestRemoteDataCommand execute:@(1)];
}


- (void)p_footerWithRefreshing {
    self.bwt_viewModel.currentPage++;
    [self.bwt_viewModel.requestRemoteDataCommand execute:@(self.bwt_viewModel.currentPage)];

//    if (self.totalPage > 0 && self.totalPage < self.currentPage
//        && self.currentPage > 1) {
//        BWTLog(@"没有分页数据...");
//        [self.tableView.mj_footer endRefreshing];
//        self.tableView.mj_footer.hidden = YES;
//        return;
//    }
//    
//    [self requestData:self.currentPage pageCount:self.pageCount];
}

- (void)p_headerViewVisible:(BOOL)visible {
    self.tableView.mj_header.hidden = !visible;
}

- (void)p_footerViewVisible:(BOOL)visible {
    self.tableView.mj_footer.hidden = !visible;
}


- (void)handlerError:(NSError *)error {
    BWTLog(@"error === %@", error);
}

#pragma mark - 懒加载方法

- (UIImageView *)footerImageView {
    if (!_footerImageView) {
        _footerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((BWTScreenWidth - 126) / 2.f, BWTScreenHeight - 24 - 64, 126, 14)];
        NSData *imageData = [BWTTools objectForKey:kFooterImageName];
        if (imageData && [imageData isKindOfClass:[NSData class]]) {
            UIImage *image = [UIImage imageWithData:imageData];
            _footerImageView.image = image;
        } else {
            _footerImageView.image = BWTBaseImageName(@"bottomImage");
        }
        
    }
    return _footerImageView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BWTScreenWidth, BWTViewHeight) style:_tableViewStyle];
        tableView.backgroundColor = UIColorFrom10RGB(237,246,255);
        tableView.backgroundView = nil;
        tableView.delegate = self;
        tableView.tableFooterView = [[UIView alloc] init];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.rowHeight = 70.f;
        
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        _tableView = tableView;
    }
    
    return _tableView;
}

/* 目前基本可以兼容有表头的tableView
 * 无表头的话  请在所使用的类里加上self.emptyView.frame = self.tableView.frame;
 */
- (UIView *)emptyView {
    if (!_emptyView) {
        
        CGFloat posY = self.tableView.tableHeaderView.frame.size.height;
        CGFloat height = 0.0;
        
        if (self.tableView.tableHeaderView.frame.size.height != 0.0) {
            height = self.tableView.frame.size.height - self.tableView.tableHeaderView.frame.size.height;
        } else {
            height = self.tableView.frame.size.height;
        }
        
        _emptyView = [[UIView alloc]initWithFrame:CGRectMake(0.0, posY, self.tableView.frame.size.width, height)];
        
        UIImage *image = self.emptyImage;
        if (!image) {
            image = BWTBaseImageName(@"list_empty");
        }
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        CGFloat centerY = 0.0;
        if (self.tableView.tableHeaderView.frame.size.height != 0.0) {
            centerY = _emptyView.center.y - 120.0;
        } else {
            centerY = _emptyView.center.y - 90.0;
        }
        
//        imageView.size = CGSizeMake(188, 165);
        imageView.center = CGPointMake(_emptyView.center.x, centerY);
        // imageView.center = view.center;
        _emptyView.hidden = YES;
        _emptyView.backgroundColor = [UIColor clearColor];
        [_emptyView addSubview:imageView];
        
        UILabel *emptyLbl = [[UILabel alloc] initWithFrame:CGRectMake(16, imageView.frame.origin.y + imageView.frame.size.height + 8, BWTScreenWidth-32, 30)];
        
//        if (self.emptyTitle.length == 0) {
//            self.emptyTitle = @"亲, 没有更多内容";
//        }
        
        NSString *emptyDesc = self.emptyDesc;
        if (!emptyDesc) {
            emptyDesc = BWTBaseUILocalizedString(@"BWTTableViewController_Empty_Title");
        }
        emptyLbl.text = emptyDesc;
        emptyLbl.textAlignment = NSTextAlignmentCenter;
        emptyLbl.font = [UIFont systemFontOfSize:16];
        emptyLbl.textColor = UIColorFrom16RGB(0x787878);
        [_emptyView addSubview:emptyLbl];
        
    }
    
    return _emptyView;
}






#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self selectRowAtIndexPath:indexPath];
}


#pragma mark - 以下方法子类需要重写


/**
 *  配置TableView的数据源
 */
- (void)configTableViewSource {
    DAssert(0)
}

/**
 *  选中单个cell时回调的方法
 *
 *  @param indexPath
 */
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
