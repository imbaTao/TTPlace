//
//  UICollectionView+HTCollectionView.h
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/26.
//  Copyright © 2019 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionViewFlowLayout+HTUICollectionViewFlowLayout.h"
NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (HTCollectionView)

+(instancetype)creatWithFlowLayout:(UICollectionViewFlowLayout *)flowLayout classString:(NSString *)classString;

@end

NS_ASSUME_NONNULL_END
