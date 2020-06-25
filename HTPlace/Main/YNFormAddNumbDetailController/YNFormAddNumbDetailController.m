//
//  YNFormAddNumbDetailController.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/25.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "YNFormAddNumbDetailController.h"

@interface YNFormAddNumbDetailController ()

@end

@implementation YNFormAddNumbDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(doneAction) title:@"完成" font:[UIFont mediumFontSize:16] titleColor:rgba(255, 39, 66, 1) highlightedColor:rgba(255, 39, 66, 1) titleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
    
    
    UILabel *titleLabel = [UILabel regularFontWithSize:13 color:rgba(102, 102, 102, 1)];
    titleLabel.text = @"添加号是账号的唯一凭证，只能修改一次";
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(19);
        make.top.offset(13);
    }];
    
    UIView *containerView = [[UIView alloc] init];
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right
    }];
    
    
}

- (void)doneAction {
    
}

@end
