//
//  HTCommonCollectionViewController.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/26.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCommonTableViewController.h"
#import "HTCommonCollectionViewModel.h"
#import "HTCommonCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonCollectionViewController : HTCommonTableViewController<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 vm
 */
@property(nonatomic, readwrite, strong)HTCommonCollectionViewModel *vm;


/**
 collectionView
 */
@property(nonatomic, readwrite, strong)HTCommonCollectionView *collectionView;


/**
 设置cell
 */
- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView;

/**
 布局
 */
- (void)p_setupMainView;
@end

NS_ASSUME_NONNULL_END
