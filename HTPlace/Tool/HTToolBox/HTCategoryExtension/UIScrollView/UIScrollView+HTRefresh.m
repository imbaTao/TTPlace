//
//  UIScrollView+HTRefresh.m
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/16.
//  Copyright © 2019 HT. All rights reserved.
//

#import "UIScrollView+HTRefresh.h"

@implementation UIScrollView (HTRefresh)


#define HTRefreshStateLabelFontSize 14.0
#define HTRefreshStateLabelTextColor rgba(153,153,153, 1)
- (MJRefreshNormalHeader *)ht_addHeaderRefresh:(void(^)(MJRefreshNormalHeader *header))refreshingBlock {
    
    __weak __typeof(&*self) weakSelf = self;
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __weak __typeof(&*weakSelf) strongSelf = weakSelf;
        !refreshingBlock?:refreshingBlock((MJRefreshNormalHeader *)strongSelf.mj_header);
    }];
    mj_header.stateLabel.font = [UIFont fontSize:HTRefreshStateLabelFontSize];
    mj_header.stateLabel.textColor = HTRefreshStateLabelTextColor;
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = mj_header;
    return mj_header;
}

- (MJRefreshAutoNormalFooter *)ht_addFooterRefresh:(void(^)(MJRefreshAutoNormalFooter *footer))refreshingBlock {
    __weak __typeof(&*self) weakSelf = self;
    MJRefreshAutoNormalFooter *mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __weak __typeof(&*weakSelf) strongSelf = weakSelf;
        !refreshingBlock?:refreshingBlock((MJRefreshAutoNormalFooter *)strongSelf.mj_footer);
    }];

    mj_footer.stateLabel.font = [UIFont fontSize:HTRefreshStateLabelFontSize];
    mj_footer.stateLabel.textColor = HTRefreshStateLabelTextColor;
    
//    [mj_footer setTitle:@"..." forState:MJRefreshStateNoMoreData];
    self.mj_footer = mj_footer;
    return mj_footer;
}

@end
