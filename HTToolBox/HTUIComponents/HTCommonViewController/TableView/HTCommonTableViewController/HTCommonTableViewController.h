//
//  HTCommonTableViewController.h
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/16.
//  Copyright © 2019 HT. All rights reserved.
//

#import "HTCommonViewController.h"
#import "HTCommonTableViewModel.h"
#import "HTCommonTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonTableViewController : HTCommonViewController<UITableViewDelegate,UITableViewDataSource>

/**
 内容偏移量
 */
@property (nonatomic, readwrite, assign) UIEdgeInsets contentInset;

/**
 列表
 */
@property(nonatomic, readwrite, strong)HTCommonTableView *tableView;

/**
 空数据展示视图
 */
@property(nonatomic, readwrite, strong)UIView *emptyView;

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
 设置上拉下拉刷新
 */
- (void)pullConfig;

/**
 设置
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

/**
 设置空页面
 */
- (void)setupEmptyView:(UIView *)emptyView;
@end

NS_ASSUME_NONNULL_END
