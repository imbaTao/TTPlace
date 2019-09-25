//
//  HTCommonTableViewController.m
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/16.
//  Copyright © 2019 HT. All rights reserved.
//

#import "HTCommonTableViewController.h"
#import "NSObject+RACKVOWrapper.h"

@interface HTCommonTableViewController ()

/**
 空数据展示视图
 */
@property(nonatomic, readwrite, strong)UIView *emptyView;

@end

@implementation HTCommonTableViewController
@synthesize tableView = _tableView;

- (instancetype)initWithViewModel:(HTCommonTableViewModel *)vm {
    self = [self init];
    if (self) {
        self.vm = vm;
    }
    return self;
}

// 添加加载和刷新控件
- (void)pullConfig {
    // 下拉刷新
    @weakify(self);
    if (self.vm.canPulldown) {
        [self.tableView ht_addHeaderRefresh:^(MJRefreshNormalHeader *header) {
            /// 加载下拉刷新的数据
            @strongify(self);
            [self headerRefresh];
        }];
        [self.tableView.mj_header beginRefreshing];
    }
    
    // 上拉加载
    if (self.vm.canPullUp) {
        @weakify(self);
        [self.tableView ht_addFooterRefresh:^(MJRefreshAutoNormalFooter *footer) {
            /// 加载上拉刷新的数据
            @strongify(self);
            [self footerRefresh];
        }];
    }
}
- (void)p_setupMainView {
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:self.vm.style];
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.showsVerticalScrollIndicator = false;
    self.tableView.showsHorizontalScrollIndicator = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置代理
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.tableView.contentInset  = self.vm.contentInset;

    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    for (NSString *name in self.vm.classNames) {
        [self.tableView registerClass:NSClassFromString(name) forCellReuseIdentifier:name];
    }
    
    if (@available(iOS 11.0, *)) {
        // iOS 11上发生tableView顶部有留白，原因是代码中只实现了heightForHeaderInSection方法，而没有实现viewForHeaderInSection方法。那样写是不规范的，只实现高度，而没有实现view，但代码这样写在iOS 11之前是没有问题的，iOS 11之后应该是由于开启了估算行高机制引起了bug。
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

// 设置空提示页
- (void)setupEmptyView {
//    self.emptyView = [[JHGEmptyView alloc] initWithFrame:self.tableView.bounds];
//    [self.tableView addSubview:self.emptyView];
//    self.emptyView.hidden = true;
//    [self.emptyView configEmptyWithIcon:self.vm.emptyIconPath notice:self.vm.emtyTips];
}

// 监听ViewModel模型
- (void)bindViewModel
{
    @weakify(self);
    [self.vm rac_observeKeyPath:@"data" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld observer:self block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        
        // 旧值
        NSArray *oldValue = change[@"old"];
        if (![oldValue isKindOfClass:[NSArray class]]) {
            oldValue = [NSArray array];
        }
        
        // 新值
        NSArray *newValue = change[@"new"];
        if (![newValue isKindOfClass:[NSArray class]]) {
            newValue = [NSArray array];
        }
        
        // 如果数量小于一页的数量那么隐藏上拉
        if (newValue.count < self.vm.pageSize) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        // 上拉刷新
        if (self.vm.page != 1) {
            NSArray *data1 = [oldValue arrayByAddingObjectsFromArray:newValue];
            self.vm.data2 = data1;
        }else {
            self.vm.data2 = newValue;
        }
        
        // 是否显示空数据视图
        self.emptyView.hidden = self.vm.data2.count > 0;
        
        // 刷新数据
        [self reloadData];
    }];
    
    // 刷新信号
    [self.vm.refreshSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self reloadData];
    }];
}


#pragma mark - life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupMainView];
    [self setupEmptyView];
    [self bindViewModel];
    [self pullConfig];
}

// 刷新事件
- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - 上下拉刷新事件
// 下拉事件
- (void)headerRefresh{
    @weakify(self)
    [[[self.vm.fetchDataSourceCommand
       execute:@1]
      deliverOnMainThread]
     subscribeNext:^(NSArray *datas) {
         @strongify(self)
         self.vm.page = 1;
         if (![datas isKindOfClass:[NSArray class]] || !datas) {
             datas = [NSArray array];
         }
          self.vm.data = datas;
     } error:^(NSError *error) {
         @strongify(self)
         [self.tableView.mj_header endRefreshing];
     }];
}

/// 上拉事件
- (void)footerRefresh{
    @weakify(self);
    [[[self.vm.fetchDataSourceCommand
       execute:@(self.vm.page + 1)]
      deliverOnMainThread]
     subscribeNext:^(NSArray *datas) {
         @strongify(self)
         self.vm.page += 1;
         if (![datas isKindOfClass:[NSArray class]] || !datas) {
             datas = [NSArray array];
         }
          self.vm.data = datas;
     } error:^(NSError *error) {
         @strongify(self);
         [self.tableView.mj_footer endRefreshing];
     }];
}

#pragma mark - Data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.vm numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.vm itemsInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.vm heightOfRow:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (self.vm.classNames.count > 0) {
       cell = [tableView dequeueReusableCellWithIdentifier:self.vm.classNames[0] forIndexPath:indexPath];
    }else {
       cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    }
    
    [self configureCell:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

// 设置cell数据
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
}

//  组头视图
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.vm sectionHeaderHeightOfRow:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.vm sectionHeaderView:section];
}

// 组尾视图
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [self.vm sectionFooterHeightOfRow:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self.vm sectionFooterView:section];
}

#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView selectRowAtIndexPath:indexPath animated:false scrollPosition:UITableViewScrollPositionNone];
    [self.vm.didSelectCommand execute:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
