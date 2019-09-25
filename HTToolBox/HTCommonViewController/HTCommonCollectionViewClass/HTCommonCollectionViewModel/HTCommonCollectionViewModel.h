//
//  HTCommonCollectionViewModel.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/26.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCommonTableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonCollectionViewModel : HTCommonTableViewModel

/**
 布局
 */
@property(nonatomic, readwrite, strong)UICollectionViewFlowLayout *flowLayout;

/**
 注册cell的类别种类
 */
@property(nonatomic, readwrite, copy)NSArray *cellNames;

/**
 根据下标获取模型数据
 */
- (id)modelDataWithIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 代理类方法

/**
 返回组数
 */
- (NSInteger)numberOfSections;

/**
 每组多少个
 */
- (NSInteger)itemsInSection:(NSInteger)section;

/**
 返回cell高度
 */
- (CGSize)itemSize:(NSIndexPath *)indexPath;

/**
 通知刷新
 */
- (void)reloadData;

/**
 根据页码获取数据
 */
- (RACSignal *)fetchDataWithPage:(NSUInteger)page;

@end

NS_ASSUME_NONNULL_END
