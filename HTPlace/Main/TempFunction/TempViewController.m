//
//  TempViewController.m
//  HTPlace
//
//  Created by Mr.hong on 2020/9/14.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "TempViewController.h"
#import "GCUserInfoCardView.h"
#import <ReactiveObjC.h>
@interface TempViewController ()<GCUserInfoCardViewDelegate>

@end

@implementation TempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor grayColor];
    
#if DEBUG
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(hotReload) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
});
#endif
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showCardView];
}


- (void)showCardView {
    GCUserInfoCardView *cardView = [[GCUserInfoCardView alloc] init];
    cardView.delegate = self;
    [cardView show];
}

#pragma mark - CardInfoViewDelegate
- (void)userIconClickAction {
    
}

- (void)reportAction {
    
}

- (void)bottomButtonAction:(UIButton *)sender {
       switch (sender.tag - 100) {
           case 0:{
               // @ta
           }break;
           case 1:{
               // 送礼物
           }break;
           case 2:{
               // 聊一下
           }break;
           default:break;
       }
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
