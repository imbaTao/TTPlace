//
//  HomeViewController.m
//  HTToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HT. All rights reserved.
//
#pragma mark - VC
#import "HomeViewController.h"
#import "HomeView.h"
#import "HomeViewSub.h"




@interface HomeViewController ()<HomeViewDelegate>

/**
 <#description#>
 */
//@property(nonatomic, readwrite, strong)<#method#> *<#name#>;


@end

@implementation HomeViewController


- (void)testAction {
    NSLog(@"我打印了");
}

- (void)viewDidLoad {
    HomeView *homeView = [[HomeView alloc] init];
    homeView.layer.backgroundColor = UIColor.redColor.CGColor;
    homeView.title = @"123213";
   
    
    NSLog(@"%@ ------ ",homeView.title);
    
    
//    UIView *tempView = [[UIView alloc] init];
//    tempView.frame = CGRectMake(0, 0, 130, 130);
//
//    [homeView addSubview:tempView];
    [self.view addSubview:homeView];
    
    homeView.frame = CGRectMake(0, 0, 130, 130);
    [homeView settingCornerRadius:5];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testAction)];
    homeView.userInteractionEnabled = true;
    [homeView addGestureRecognizer:gesture];
     [homeView test];
}
@end

