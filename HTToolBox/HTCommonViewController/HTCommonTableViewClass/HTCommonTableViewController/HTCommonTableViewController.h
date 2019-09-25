//
//  HTCommonTableViewController.h
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/16.
//  Copyright © 2019 HT. All rights reserved.
//

#import "HTCommonViewController.h"
#import "HTCommonTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonTableViewController : HTCommonViewController<UITableViewDelegate,UITableViewDataSource>

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

/**
 使用vm初始化
 */
- (instancetype)initWithViewModel:(HTCommonTableViewModel *)vm;


/**
 上拉事件
 */
- (void)headerRefresh;

/**
 下拉事件
 */
- (void)footerRefresh;

/**
 设置
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

/**
 设置子类tableView，不同场景不同区分
 */
- (void)setupTableView;
@end

NS_ASSUME_NONNULL_END
