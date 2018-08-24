//
//  BaseViewController.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

/** backGroundImgView */
@property(nonatomic,strong)UIImageView *backGroundImgView;

//梯度渐变背景
@property(nonatomic, strong)CAGradientLayer *backGroundLayer;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backGroundLayer = [CAGradientLayer layer];
    _backGroundLayer.colors = @[
                                (__bridge id)(RGB(96, 96, 96).CGColor),
                              (__bridge id)RGB(50, 50, 50).CGColor
                              ];
    _backGroundLayer.frame = CGRectMake(0, 0, SCREEN_W , SCREEN_H);
    _backGroundLayer.locations = @[@0.0,@0.5];
    _backGroundLayer.opacity = 1;
    [self.view.layer addSublayer:_backGroundLayer];
    [self configNaviBar];
}

- (void)configNaviBar{
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:17],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.navigationController.navigationBar.barTintColor = RGB(59, 59, 59);
    
    self.navigationController.navigationBar.layer.shadowOpacity = 0.8;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 3);
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"lucency"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"lucency"]];
    self.navigationController.navigationBar.translucent = false;
    
     self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backAction) image:[UIImage imageNamed:@"back"]];
}

- (void)hiddenLeftBtn{
    self.navigationItem.leftBarButtonItem = nil;
}
#pragma mark - Setter && Getter
//- (UIImageView *)backGroundImgView{
//    if (!_backGroundImgView) {
//        _backGroundImgView = [[UIImageView alloc] init];
//        _backGroundImgView.image = [UIImage imageNamed:@"BaseVCBackGroundImg"];
//    }
//    return _backGroundImgView;
//}
#pragma mark - Response
- (void)backAction{
    [self.navigationController popViewControllerAnimated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
