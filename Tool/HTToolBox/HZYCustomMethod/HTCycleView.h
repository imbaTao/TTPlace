//
//  HTCycleView.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/30.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionView+HTCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTPageControl : UIPageControl
@end

@interface HTCycleView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>


/**
 数据
 */
@property(nonatomic, readwrite, strong)NSArray *data;

/**
 每页数量
 */
@property(nonatomic, readwrite, assign)NSInteger itemCountInOnePage;

/**
 轮播面板
 */
@property(nonatomic, readwrite, strong)UICollectionView *cycleBoard;

/**
 指示器
 */
@property(nonatomic, readwrite, strong)HTPageControl *pageControl;


/**
 传入一个倍数下标返回一个真实数据源下标，实际就是把组数取模倍数
 */
- (NSIndexPath *)realDataIndexPath:(NSIndexPath *)sourceIndexPath;





- (instancetype)initWithFlowLayout:(UICollectionViewFlowLayout *)flowLayout pageEnabled:(BOOL)pageEnabled cellClassName:(NSString *)cellClassName autoCyle:(BOOL)autoCyle itemCountInOnePage:(NSInteger)itemCountInOnePage pageBottomOffSet:(CGFloat)pageBottomOffSet alwaysAllowScorllEnabel:(BOOL)alwaysAllowScorllEnabel showPageControl:(BOOL)showPageControl scrollDirection:(UICollectionViewScrollDirection)scrollDirection;


- (void)configCell:(id)cell indexPath:(NSIndexPath *)indexPath collectionView:(id)collectionView;

/**
 获取本视图的高度
 */
- (CGFloat)fetchCycleViewHeight;

@end

NS_ASSUME_NONNULL_END
