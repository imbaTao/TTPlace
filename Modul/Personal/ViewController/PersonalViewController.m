//
//  PersonalViewController.m
//  HZYToolBox
//
//  Created by hong  on 2018/7/2.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalTableView.h"
@interface PersonalViewController ()
/** PersonalTableView */
@property(nonatomic,strong)PersonalTableView *personalTableView;
@end

@implementation PersonalViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.personalTableView];
    [self layoutPageViews];
    [self initData];
}

- (void)layoutPageViews{
    [self.personalTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)initData{
    self.personalTableView.dataArray = [@[@"1",@"2"] copy];
    [self.personalTableView reloadData];
}

#pragma mark - TaleViewCellSelectedDelegate
- (void)cellSelectedWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中了");
}

#pragma mark - Setter && Getter
- (PersonalTableView *)personalTableView{
    if (!_personalTableView) {
        _personalTableView = [[PersonalTableView alloc] initWithCellClass:[PersonalTableViewCell class] identifier:@"personalCell"];
        _personalTableView.backgroundColor = [UIColor clearColor];
        _personalTableView.cellDelegate = self;
        _personalTableView.rowHeight = 100;
    }
    return _personalTableView;
}

@end
