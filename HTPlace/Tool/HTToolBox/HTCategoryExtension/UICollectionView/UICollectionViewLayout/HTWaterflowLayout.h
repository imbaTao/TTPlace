//
//  HTWaterflowLayout.h
//  瀑布流布局
//
//  Created by liucai on 2017/8/14.
//  Copyright © 2017年 liucai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTWaterflowLayout : UICollectionViewLayout

/**
 *  自定义UICollectionViewLayout  实现瀑布流布局
 */

/** 行间距 */
@property(nonatomic,assign)CGFloat lineSpacing;

/** 列间距 */
@property(nonatomic,assign)CGFloat interitemSpacing;

/** 总列数 */
@property(nonatomic,assign)NSInteger numberOfColums;

/** section 到collectionView的边距 */
@property(nonatomic,assign)UIEdgeInsets sectionInsets;

/** 保存每一列最大Y值的字典*/
@property(nonatomic,strong)NSMutableDictionary *maxYDic;

/** 保存每一个item的attributes的数组 */
@property(nonatomic,strong)NSMutableArray *attributesArr;

/**
 传回高度
 */
@property(nonatomic,copy) CGFloat(^calculateitemHBlock)(CGFloat itemW,NSIndexPath *indexPath);

@end
