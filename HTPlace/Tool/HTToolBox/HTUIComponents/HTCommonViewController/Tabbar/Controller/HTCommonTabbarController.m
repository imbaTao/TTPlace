//
//  HTCommonTabbarController.m
//  Jihuigou-Native
//
//  Created by hong on 2019/12/17.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCommonTabbarController.h"

@interface HTCommonTabbarController ()

/**
 是否隐藏头部
 */
@property(nonatomic, readwrite, assign)BOOL hiddenNavBar;

@end

@implementation HTCommonTabbarController

- (instancetype)initWithHiddeNavigationBar:(BOOL)hidde {
    self = [super init];
    if (self) {
        self.hiddenNavBar = hidde;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 自己封装的tabbar隐藏导航栏头部
    [self.navigationController setNavigationBarHidden:self.hiddenNavBar animated:false];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



@end
