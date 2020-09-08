//
//  HomeViewController.m
//  HTPlace
//
//  Created by Mr.hong on 2020/9/8.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewController2.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我是第一页";
    
    self.tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 500, 300, 200)];
    self.tempLabel.backgroundColor = [UIColor redColor];
    self.tempLabel.text = @"我是第一页";
    [self.view addSubview:self.tempLabel];
    
    

    
#if DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(hotReload) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    });
#endif
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
      HomeViewController2 *vc2 = [[HomeViewController2 alloc] init];

     //在push动画之前设置动画代理
     self.navigationController.delegate = vc2;
     [self.navigationController pushViewController:vc2 animated:YES];
}


// 热刷新UI代码，不用可以注释掉，不调用
- (void)hotReload {
    [self removeAllViews:self.view];
    [self viewDidLoad];
}

// 热刷新UI代码，不用可以注释掉，不调用
- (void)removeAllViews:(UIView *)view {
    while (view.subviews.count) {
        UIView* child = view.subviews.lastObject;
        [child removeFromSuperview];
    }
}


@end
