//
//  HTCommonTableViewController.h
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/16.
//  Copyright © 2019 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTCommonTableViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HTCommonTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


/**
 内容偏移量
 */
@property (nonatomic, readwrite, assign) UIEdgeInsets contentInset;

/**
 列表
 */
@property(nonatomic, readwrite, strong)UITableView *tableView;

/**
 vm
 */
@property(nonatomic, readwrite, strong)HTCommonTableViewModel *vm;


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

/**
 设置子类tableView，不同场景不同区分
 */
- (void)setupTableView;
@end

NS_ASSUME_NONNULL_END
