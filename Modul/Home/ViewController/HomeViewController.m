//
//  HomeViewController.m
//  HTToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HT. All rights reserved.
//
#pragma mark - VC
#import "HomeViewController.h"
@interface HomeViewController ()
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = false;
}



- (void)injected
{
    for (UIView *value in self.view.subviews) {
        [value removeFromSuperview];
    }
    self.view.backgroundColor = UIColor.grayColor;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.vm.data  = @[@"UIView",@"UILabel",@"UIButton",@"UITextFile"];
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    NSString *cellContent = [self.vm modelDataWithIndexPath:indexPath];
    cell.textLabel.text = cellContent;
}



































#pragma mark - private
- (void)p_configNavi{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
