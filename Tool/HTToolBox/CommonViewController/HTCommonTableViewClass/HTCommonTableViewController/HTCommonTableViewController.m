//
//  HTCommonTableViewController.m
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/16.
//  Copyright © 2019 HT. All rights reserved.
//

#import "HTCommonTableViewController.h"

@interface HTCommonTableViewController ()

@end

@implementation HTCommonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_setupTableView];
    [self bindViewModel];
}

- (void)p_setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:self.vm.style];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.showsVerticalScrollIndicator = false;
    tableView.showsHorizontalScrollIndicator = false;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // set delegate and dataSource
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.tableView = tableView;
    self.tableView.contentInset  = self.contentInset;
    
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    /// 下拉刷新
    @weakify(self);
    
    /// 添加加载和刷新控件
    if (self.vm.canPulldown) {
        
        [self.tableView ht_addHeaderRefresh:^(MJRefreshNormalHeader *header) {
            /// 加载下拉刷新的数据
            @strongify(self);
            [self tableViewDidTriggerHeaderRefresh];
        }];
        [self.tableView.mj_header beginRefreshing];
    }
    
    if (self.vm.canPullUp) {
        /// 上拉加载
        @weakify(self);
        [self.tableView ht_addFooterRefresh:^(MJRefreshAutoNormalFooter *footer) {
            /// 加载上拉刷新的数据
            @strongify(self);
            [self tableViewDidTriggerFooterRefresh];
        }];
        
        //   RAC(self.tableView.mj_footer, hidden) =
        /// 隐藏footer or 无更多数据
        [[RACObserve(self.vm, dataSource) deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
            @strongify(self)
            NSUInteger count = self.vm.dataSource.count;
            if (count < self.vm.pageSize) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }];
        
    }
    
    [self.vm.refreshSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self reloadData];
    }];
    
    if (@available(iOS 11.0, *)) {
        /// iOS 11上发生tableView顶部有留白，原因是代码中只实现了heightForHeaderInSection方法，而没有实现viewForHeaderInSection方法。那样写是不规范的，只实现高度，而没有实现view，但代码这样写在iOS 11之前是没有问题的，iOS 11之后应该是由于开启了估算行高机制引起了bug。
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
    }
    
}


/// override
- (void)bindViewModel
{
    //    [super bindViewModel];
    @weakify(self)
    [[RACObserve(self.vm, dataSource)
      deliverOnMainThread]
     subscribeNext:^(id x) {
         @strongify(self)
         // 刷新数据
         [self reloadData];
     }];
    
    
    /// 隐藏emptyView
    //    [self.vm.fetchDataSourceCommand.executing subscribeNext:^(NSNumber *executing) {
    //        @strongify(self)
    ////        UIView *emptyDataSetView = [self.tableView.subviews.rac_sequence objectPassingTest:^(UIView *view) {
    ////            return [NSStringFromClass(view.class) isEqualToString:@"DZNEmptyDataSetView"];
    ////        }];
    ////        emptyDataSetView.alpha = 1.0 - executing.floatValue;
    //
    //
    //
    //    }];
//        [self.vm.fetchDataSourceCommand.executionSignals.switchToLatest subscribeNext:^(id _) {
//                @strongify(self);
//
//            }];
//
//            [self.vm.fetchDataSourceCommand.errors subscribeNext:^(id _) {
//                @strongify(self);
//
//            }];
}

/// reload tableView data
- (void)reloadData{
    [self.tableView reloadData];
}

#pragma mark - 上下拉刷新事件
/// 下拉事件
- (void)tableViewDidTriggerHeaderRefresh{
    @weakify(self)
    [[[self.vm.fetchDataSourceCommand
       execute:@1]
      deliverOnMainThread]
     subscribeNext:^(id x) {
         @strongify(self)
         self.vm.page = 1;
     } error:^(NSError *error) {
         @strongify(self)
         [self.tableView.mj_header endRefreshing];
     } completed:^{
         @strongify(self)
         [self.tableView.mj_header endRefreshing];
     }];
}

/// 上拉事件
- (void)tableViewDidTriggerFooterRefresh{
    @weakify(self);
    [[[self.vm.fetchDataSourceCommand
       execute:@(self.vm.page + 1)]
      deliverOnMainThread]
     subscribeNext:^(id x) {
         @strongify(self)
         self.vm.page += 1;
         if ([x integerValue] < self.vm.pageSize) {
             [self.tableView.mj_footer endRefreshingWithNoMoreData];
         }
     } error:^(NSError *error) {
         @strongify(self);
         [self.tableView.mj_footer endRefreshing];
     } completed:^{
         @strongify(self)
         [self.tableView.mj_footer endRefreshing];
     }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vm.dataSource.count;
}

/// duqueueReusavleCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

/// configure cell data
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView selectRowAtIndexPath:indexPath animated:false scrollPosition:UITableViewScrollPositionNone];
    [self.vm.didSelectCommand execute:indexPath];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
