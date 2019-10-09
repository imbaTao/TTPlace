//
//  HTCycleViewConfigModel.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/19.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTCycleViewConfigModel : NSObject

/**
 页面布局相关
 */
@property(nonatomic, readwrite, strong)UICollectionViewFlowLayout *flowLayout;

/**
 分页中cell的类名
 */
@property(nonatomic, readwrite)NSString *cellClassName;

/**
 是否分页，默认是true
 */
@property(nonatomic, readwrite)BOOL pageEnabled;

/**
 是否自动滚动 默认是true
 */
@property(nonatomic, readwrite)BOOL autoCycle;

/**
 每页显示的数量 默认是一页一个
 */
@property(nonatomic, readwrite,assign)NSInteger itemCountInOnePage;

/**
 是否允许手势拖动滚动 默认是ture
 */
@property(nonatomic, readwrite)BOOL allowScorllEnabel;

/**
 运行的时间
 */
@property(nonatomic, readwrite, assign)NSInteger workingTime;


/**
 是否显示页码指示器 默认为true
 */
@property(nonatomic, readwrite)BOOL showPageControl;


/**
 滚动的方向 默认是横向
 */
@property(nonatomic, readwrite, assign)UICollectionViewScrollDirection scrollDirection;


/**
 当前下标
 */
@property(nonatomic, readwrite, strong)NSIndexPath *currentIndexPath;

/**
 是否在拖动
 */
@property(nonatomic, readwrite, assign)BOOL isDragging;

/**
 每几秒钟滚一次,默认3s/次
 */
@property(nonatomic, readwrite, assign)NSInteger scrollInterval;


/**
 重复几组,默认5000组
 */
@property(nonatomic, readonly, assign)NSInteger repeatMutiply;

// ban
- (instancetype)new NS_UNAVAILABLE;
- (instancetype)init __attribute__((unavailable("请使用下面的初始化方法")));

// available
- (instancetype)initWithFlowLayout:(nonnull UICollectionViewFlowLayout *)flowLayout cellClassName:(nonnull NSString *)cellClassName;
@end

NS_ASSUME_NONNULL_END
