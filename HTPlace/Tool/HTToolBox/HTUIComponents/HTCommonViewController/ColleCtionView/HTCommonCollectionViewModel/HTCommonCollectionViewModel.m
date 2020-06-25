//
//  HTCommonCollectionViewModel.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/26.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCommonCollectionViewModel.h"

@implementation HTCommonCollectionViewModel
- (id)fetchLocalData {
    return nil;
}

- (id)modelDataWithIndexPath:(NSIndexPath *)indexPath {
    return self.data[indexPath.row];
}

#pragma mark - 数据源设置

// 多少组
- (NSInteger)numberOfSections {
    return 1;
}

// 每组里多少个,默认1个
- (NSInteger)itemsInSection:(NSInteger)sections {
    return self.data.count;
}

- (void)reloadData {
    [self.refreshSubject sendNext:nil];
}

- (NSUInteger)offsetForPage:(NSUInteger)page {
    return (page - 1) * self.pageSize;
}

- (RACSignal *)fetchDataWithPage:(NSUInteger)page {
    return [RACSignal empty];
}

@end
