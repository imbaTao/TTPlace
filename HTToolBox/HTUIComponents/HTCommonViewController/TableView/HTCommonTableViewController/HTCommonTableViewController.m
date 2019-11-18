//
//  HTCommonTableViewController.m
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/16.
//  Copyright © 2019 HT. All rights reserved.
//

#import "HTCommonTableViewController.h"
#import "NSObject+RACKVOWrapper.h"
#import "HTCommonTableView.h"


@interface HTCommonTableViewController ()

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


- (void)p_setupMainView {
    self.tableView = [[HTCommonTableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:self.vm.style cellClassNames:self.vm.classNames delegateTarget:self];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.vm.contentInset);
    }];
}

// 设置空提示页
- (void)setupEmptyView {
//    self.emptyView.frame = self.tableView.bounds;
//    [self.tableView addSubview:self.emptyView];
//    self.emptyView.hidden = true;
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
// 添加加载和刷新控件
- (void)pullConfig {
    // 下拉刷新
    @weakify(self);
    if (self.vm.canPulldown && !self.tableView.mj_header) {
        [self.tableView ht_addHeaderRefresh:^(MJRefreshNormalHeader *header) {
            /// 加载下拉刷新的数据
            @strongify(self);
            [self headerRefresh];
        }];
        [self.tableView.mj_header beginRefreshing];
    }else if(!self.vm.canPulldown){
        // 监听滚动,移动背景墙的
        @weakify(self);
        [RACObserve(self.tableView, contentOffset) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            CGPoint offset = [x CGPointValue];
            if (offset.y < 0) {
                self.tableView.contentOffset = CGPointMake(0, 0);
            }
        }];
    }
    
    
    
    
    
    // 上拉加载
    if (self.vm.canPullUp && !self.tableView.mj_footer) {
        @weakify(self);
        [self.tableView ht_addFooterRefresh:^(MJRefreshAutoNormalFooter *footer) {
            /// 加载上拉刷新的数据
            @strongify(self);
            [self footerRefresh];
        }];
    }
}

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
         // 如果之前就没值的话赋值改变头部和尾部
         if (!self.vm.data) {
             self.vm.data = @[];
         }
         [self.tableView.mj_header endRefreshing];
     }];
}

// 上拉事件
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
         // 如果之前就没值的话赋值改变头部和尾部
         if (!self.vm.data) {
             self.vm.data = @[];
         }
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
       cell = [tableView dequeueReusableCellWithIdentifier:self.vm.classNames.firstObject forIndexPath:indexPath];
    }else {
       cell = [tableView dequeueReusableCellWithIdentifier:@"HTCommonTableViewCell" forIndexPath:indexPath];
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
