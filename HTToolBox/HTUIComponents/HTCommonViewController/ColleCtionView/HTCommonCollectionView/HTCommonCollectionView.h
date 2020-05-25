//
//  HTCommonCollectionView.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/10/9.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTCommonCollectionViewCell.h"
#import "UICollectionViewFlowLayout+HTUICollectionViewFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 data
 */
@property(nonatomic, readwrite, strong)NSMutableArray *data;

/**
 cellClassNames
 */
@property(nonatomic, readwrite, strong)NSArray *cellClassNames;


/**
  初始化实例方法
 */
- (instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewFlowLayout *)layout cellClassNames:(nullable NSArray *)cellClassNames delegateTarget:(nullable id)target;

/**
 没有frame的方法
 */
- (instancetype)initWithlayout:(UICollectionViewFlowLayout *)layout cellClassNames:(nullable NSArray *)cellClassNames delegateTarget:(nullable id)target;

/**
 设置cell
 */
- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView;

/**
 初始化UI
 */
- (void)setupUI;
@end

NS_ASSUME_NONNULL_END
