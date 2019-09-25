//
//  JHGGroupShoppingNormalProdCell.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/31.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JHGGroupShoppingNormalProdCell : UITableViewCell

/**
 商品图片
 */
@property(nonatomic, readwrite, strong)UIImageView *prodIcon;

/**
 商品名称
 */
@property(nonatomic, readwrite, strong)UILabel *prodNameLB;

/**
 拼团人数
 */
@property(nonatomic, readwrite, strong)UILabel *personCount;

/**
 商品价格
 */
@property(nonatomic, readwrite, strong)UILabel *price;

/**
 拼团商品件数
 */
@property(nonatomic, readwrite, strong)UILabel *groupProdCount;

/**
 去拼团按钮
 */
@property(nonatomic, readwrite, strong)UIButton *groupButton;
@end

NS_ASSUME_NONNULL_END
