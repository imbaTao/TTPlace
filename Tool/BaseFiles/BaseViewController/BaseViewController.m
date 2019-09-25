//
//  BaseViewController.m
//  HTToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HT. All rights reserved.
//


#import "BaseViewController.h"

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNaviBar];
}

- (void)configNaviBar{
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:17],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.navigationController.navigationBar.layer.shadowOpacity = 0.8;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 3);
    
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"lucency"]];
    self.navigationController.navigationBar.translucent = false;
}

- (void)hiddenLeftBtn{
    self.navigationItem.leftBarButtonItem = nil;
}
#pragma mark - Response
- (void)backAction{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
