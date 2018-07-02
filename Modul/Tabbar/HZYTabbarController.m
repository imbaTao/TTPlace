//
//  HZYTabbarController.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/27.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "HZYTabbarController.h"
#import "BaseNavigationController.h"

#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "PersonalViewController.h"
@interface HZYTabbarController ()

@end


@implementation HZYTabbarController
singleM();
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_initSubVC];
}

#pragma mark - private
- (void)p_initSubVC{
    HomeViewController *vc1 = [[HomeViewController alloc] init];
    vc1.title = @"1控制器";
    BaseNavigationController *nav1 = [[BaseNavigationController alloc] initWithRootViewController:vc1];
    
    DiscoverViewController *vc2 = [[DiscoverViewController alloc] init];
    BaseNavigationController *nav2 = [[BaseNavigationController alloc] initWithRootViewController:vc2];
    vc2.view.backgroundColor = [UIColor redColor];
    [vc2.navigationItem setTitle:@"2控制器"];
    vc2.title = @"2控制器";
    
    PersonalViewController *vc3 = [[PersonalViewController alloc] init];
    BaseNavigationController *nav3 = [[BaseNavigationController alloc] initWithRootViewController:vc3];
    vc3.view.backgroundColor = [UIColor grayColor];
    vc3.title = @"3控制器";
    NSArray *subVCArr = @[nav1,nav2,nav3];
    for (int i = 0; i < subVCArr.count; i++) {
        [self addChildViewController:subVCArr[i]];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
