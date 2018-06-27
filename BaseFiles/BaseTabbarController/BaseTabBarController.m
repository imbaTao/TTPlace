//
//  BaseTabBarController.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "BaseTabBarController.h"
@interface BaseTabBarController ()
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_configTabbar];
}


#pragma mark - private
- (void)p_configTabbar{
    self.tabBar.hidden = true;
    [self.view addSubview:self.customBar];
    [self.customBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.height.offset(49);
        make.left.offset(0);
        make.right.offset(0);
    }];
}

#pragma mark - Setter && Getter
- (UIView *)customBar{
    if (!_customBar) {
        _customBar = [[UIView alloc] init];
        _customBar.backgroundColor = [UIColor whiteColor];
    }
    return _customBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
