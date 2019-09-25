//
//  VipChoosePriceCell.h
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/25.
//  Copyright © 2019 HT. All rights reserved.
//

#import "TomatoCommonBoardView.h"

#import "VipChoosePriceCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface VipChoosePriceCell : TomatoCommonBoardView

/**
 价格选择面板CollectionView
 */
@property(nonatomic, readwrite, strong)UICollectionView *priceCollectionView;


/**
 立即购买按钮
 */
@property(nonatomic, readwrite, strong)UIButton *buyButton;

@end

NS_ASSUME_NONNULL_END
