//
//  HTCycleView.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/30.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionView+HTCollectionView.h"
#import "HTCycleViewConfigModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol HTCycleViewDelegate <NSObject>
/**
 选中某一页的代理
 */
- (void)pageDidSelected:(NSIndexPath *)indexPath data:(id)data;
@end

@interface HTCycleView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 代理
 */
@property(nonatomic,weak)id <HTCycleViewDelegate> delegate;

/**
 设置模型
 */
@property(nonatomic, readwrite, strong)HTCycleViewConfigModel *configModel;

/**
 数据
 */
@property(nonatomic, readwrite, strong)NSArray *data;

/**
 设置滚动单页面数据
 */
- (void)configCell:(id)cell indexPath:(NSIndexPath *)indexPath collectionView:(id)collectionView;

/**
 传入一个倍数下标返回一个真实数据源下标，实际就是把组数取模倍数
 */
- (NSIndexPath *)realDataIndexPath:(NSIndexPath *)sourceIndexPath;


/**
 获取本视图的高度
 */
- (CGFloat)fetchCycleViewHeight;

/**
 注入数据,且刷新
 */
- (void)injectData:(NSArray<NSString *> *)data;

/**
 根据下标取数据
 */
- (id)fetchDataWithIndexPath:(NSIndexPath *)indexPath;



/**
 初始化方法
 */
- (instancetype)new NS_UNAVAILABLE;
- (instancetype)init __attribute__((unavailable("原始初始化方法被禁用,请使用下面的初始化方法")));
- (instancetype)initWithConfigModel:(nonnull HTCycleViewConfigModel *)cycleModel;
@end

NS_ASSUME_NONNULL_END
