//
//  VipChoosePriceCollectionViewCell.h
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/26.
//  Copyright © 2019 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VipChoosePriceCollectionViewCell: UICollectionViewCell

/**
 推荐
 */
@property(nonatomic, readwrite, strong)UILabel *recommendFlag;


/**
 价格说明
 */
@property(nonatomic, readwrite, strong)UILabel *priceDes;


/**
 价格说明
 */
@property(nonatomic, readwrite, strong)UILabel *nowPrice;

/**
 价格说明
 */
@property(nonatomic, readwrite, strong)UILabel *sourcePrice;

/**
 价格说明
 */
@property(nonatomic, readwrite, strong)UILabel *tips;

@end


NS_ASSUME_NONNULL_END
