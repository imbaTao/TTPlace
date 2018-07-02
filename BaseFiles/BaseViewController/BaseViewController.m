//
//  BaseViewController.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "BaseViewController.h"

//#import "UINavigationItem+SXFixSpace.h"


@interface BaseViewController ()
@end

@implementation BaseViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[HZYTabbarController share] isHaveBar:false];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self configNaviBar];
}

- (void)configNaviBar{
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:17],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lucency"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"lucency"]];
    self.navigationController.navigationBar.translucent = false;
    
     self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backAction) image:[UIImage imageNamed:@"back"]];
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
