//
//  HZYDiscoverViewController.m
//  HZYToolBox
//
//  Created by hong  on 2018/7/2.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverTableView.h"
#import "DiscoverTableViewCell.h"
@interface DiscoverViewController ()
/** discoverTableView */
@property(nonatomic,strong)DiscoverTableView *discoverTableView;
@end

@implementation DiscoverViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[HZYTabbarController share] showTabbar];
}

- (void)viewWillDisappear:(BOOL)animated{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hiddenLeftBtn];
    [self.view addSubview:self.discoverTableView];
    [self layoutPageViews];
    [self initData];
}

- (void)layoutPageViews{
    [self.discoverTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 49, 0));
    }];
}

- (void)initData{
    self.discoverTableView.dataArray = [@[@"1",@"2"] copy];
    [self.discoverTableView reloadData];
}

#pragma mark - TaleViewCellSelectedDelegate
- (void)cellSelectedWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中了");
}

#pragma mark - Setter && Getter
- (DiscoverTableView *)discoverTableView{
    if (!_discoverTableView) {
        _discoverTableView = [[DiscoverTableView alloc] initWithCellClass:[DiscoverTableViewCell class] identifier:@"DiscoverCell" style:UITableViewStyleGrouped];
        _discoverTableView.cellDelegate = self;
        _discoverTableView.rowHeight = SCREEN_W * 0.72;
        if (@available(iOS 11.0, *)) {
        _discoverTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _discoverTableView;
}

@end
