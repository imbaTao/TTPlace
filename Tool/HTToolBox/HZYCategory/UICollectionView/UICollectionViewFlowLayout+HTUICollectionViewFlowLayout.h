//
//  UICollectionViewFlowLayout+HTUICollectionViewFlowLayout.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/30.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewFlowLayout (HTUICollectionViewFlowLayout)

/**
 创建flowLayout
 @parm LineSpacing 每列之间的间距
 @parm InteritemSpacing 每行之间的间距
 @parm sectionInset 每组组之间的间距
 @parm itemSize 每个item的Size
 @parm scrollDirection 滚动方向
 */
+(instancetype)creatWithLineSpacing:(CGFloat)LineSpacing  InteritemSpacing:(CGFloat)InteritemSpacing sectionInset:(UIEdgeInsets)sectionInset itemSize:(CGSize)itemSize scrollDirection:(UICollectionViewScrollDirection)scrollDirection;

@end

NS_ASSUME_NONNULL_END
