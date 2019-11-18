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
 当横向排布时，lineSpacing是两个item左右之间的间距,interitemSpacing为0,注意collectionView高度不能＞item高度两倍，不然换行
 当纵向排布是, lineSpacing是两个item上下之间的间距，interitemSpacing是左右间距
 */
+ (instancetype)creatWithLineSpacing:(CGFloat)lineSpacing  InteritemSpacing:(CGFloat)interitemSpacing itemCount:(NSInteger)itemCount sectionInset:(UIEdgeInsets)sectionInset sourceSize:(CGSize)sourceSize needChangeSize:(BOOL)needChangeSize scrollDirection:(UICollectionViewScrollDirection)scrollDirection;



// 旧方法，打算废弃
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
