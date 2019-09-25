//
//  HTCommonTableViewModel.m
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/16.
//  Copyright © 2019 HT. All rights reserved.
//

#import "HTCommonTableViewModel.h"

@implementation HTCommonTableViewModel
- (void)vm {
    [super vm];
    self.page = 1;
    self.pageSize = 10;
    
    /// request remote data
    @weakify(self)
    self.fetchDataSourceCommand = [[RACCommand alloc] initWithSignalBlock:^(NSNumber *page) {
        @strongify(self)
        return [[self fetchDataWithPage:page.unsignedIntegerValue] takeUntil:self.rac_willDeallocSignal];
    }];
}

- (id)fetchLocalData {
    return nil;
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

- (RACSubject *)refreshSubject {
    if (!_refreshSubject) {
        _refreshSubject = [RACSubject subject];
    }
    return _refreshSubject;
}
@end
