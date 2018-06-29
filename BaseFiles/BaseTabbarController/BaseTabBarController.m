//
//  BaseTabBarController.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseTabbarView.h"
@interface BaseTabBarController ()
/** tabbarView */
@property(nonatomic,strong)BaseTabbarView *customBar;
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = true;
    [self.view addSubview:self.customBar];
    [self.customBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.height.offset(49);
        make.left.offset(0);
        make.right.offset(0);
    }];
}

- (BaseTabbarView *)customBar{
    if (!_customBar) {
        _customBar = [[BaseTabbarView alloc] init];;
    }
    return _customBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

