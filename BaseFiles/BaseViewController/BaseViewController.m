//
//  BaseViewController.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

/** bar */
@property(nonatomic,strong)UIImageView *bar;
@end

@implementation BaseViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = true;
    [self.view addSubview:self.bar];
    [self.bar addSubview:self.backButton];
    [self layoutPageViews];
}


- (void)layoutPageViews{
    [self.bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(64);
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bar);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
}


#pragma mark - Setter && Getter
- (UIImageView *)bar{
    if (!_bar) {
        _bar = [[UIImageView alloc] init];
        _bar.backgroundColor = [UIColor grayColor];
    }
    return _bar;
}

- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton creatBtnWithImgName:@"back" selector:@selector(backAction)];
    }
    return _backButton;
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
