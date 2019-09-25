//
//  UIScrollView+HTRefresh.h
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/16.
//  Copyright © 2019 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (HTRefresh)
/**
 下拉刷新控件(刷新头)
 */
- (MJRefreshNormalHeader *)ht_addHeaderRefresh:(void(^)(MJRefreshNormalHeader *header))refreshingBlock;

/**
 添加上拉加载控件(刷新尾)
 */
- (MJRefreshAutoNormalFooter *)ht_addFooterRefresh:(void(^)(MJRefreshAutoNormalFooter *footer))refreshingBlock;
@end

NS_ASSUME_NONNULL_END
