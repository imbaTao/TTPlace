//
//  HTCommonTableView.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/10/9.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
/**
 data
 */
@property(nonatomic, readwrite, strong)NSMutableArray *data;

/**
 cellClassNames
 */
@property(nonatomic, readwrite, strong)NSArray *cellClassNames;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style cellClassNames:(nullable NSArray *)cellClassNames delegateTarget:(nullable id)target;


/**
 设置cell
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
