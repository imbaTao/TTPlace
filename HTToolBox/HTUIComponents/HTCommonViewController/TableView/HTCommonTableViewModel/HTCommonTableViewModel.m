//
//  HTCommonTableViewModel.m
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/16.
//  Copyright © 2019 HT. All rights reserved.
//

#import "HTCommonTableViewModel.h"

@implementation HTCommonTableViewModel
@synthesize data = _data;
- (void)vm {
    [super vm];
    self.page = 0;
    self.pageSize = 10;
    self.canPullUp = true;
    self.canPulldown = true;
    self.style = UITableViewStyleGrouped;
    
    // request remote data
    @weakify(self)
    self.fetchDataSourceCommand = [[RACCommand alloc] initWithSignalBlock:^(NSNumber *page) {
        @strongify(self)
        NSInteger pageIndex = page.unsignedIntegerValue;
        if (pageIndex <= 0) {
            pageIndex = 1;
        }
        return [[self fetchDataWithPage:page.unsignedIntegerValue] takeUntil:self.rac_willDeallocSignal];
    }];
}

- (id)fetchLocalData {
    return nil;
}

- (id)modelDataWithIndexPath:(NSIndexPath *)indexPath {
    return self.data[indexPath.section];
}

#pragma mark - 数据源设置

// 多少组
- (NSInteger)numberOfSections {
    return self.data.count;
}

// 每组里多少个,默认1个
- (NSInteger)itemsInSection:(NSInteger)sections {
    return 1;
}

// 组头尾视图设置
- (CGFloat)sectionHeaderHeightOfRow:(NSInteger)section {
    return 0.01;
}

- (UIView *)sectionHeaderView:(NSInteger)section {
    return nil;
}

- (CGFloat)sectionFooterHeightOfRow:(NSInteger)section {
    return 1;
}

- (UIView *)sectionFooterView:(NSInteger)section {
    UIView *lineBoard = [[UIView alloc] init];
    lineBoard.backgroundColor = [UIColor clearColor];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [self segementLineColor];
    
    [lineBoard addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, [self segementInterval], 0, [self segementInterval]));
    }];
    return lineBoard;
}

- (CGFloat)heightOfRow:(NSIndexPath *)indexPath {
    return 44;
}

- (UIColor *)segementLineColor {
    return rgba(245, 245, 245, 1);
}


- (CGFloat)segementInterval {
    return 0;
}

- (void)reloadData {
    [self.refreshSubject sendNext:nil];
}

- (NSUInteger)offsetForPage:(NSUInteger)page {
    return (page - 1) * self.pageSize;
}

- (RACSignal *)fetchDataWithPage:(NSInteger)page {
    return [RACSignal empty];
}

#pragma mark - Setter && Getter
- (void)setData2:(NSArray *)data2 {
    _data2 = data2;
    
    // 这里这样写是因为kvo中不能用全局变量改变data 所以暂时用中转方案
    _data = data2;
}

- (RACSubject *)refreshSubject {
    if (!_refreshSubject) {
        _refreshSubject = [RACSubject subject];
    }
    return _refreshSubject;
}

- (NSString *)emptyIconPath {
    if (!_emptyIconPath) {
        _emptyIconPath = @"JHGStoreProductEmpty";
    }
    return _emptyIconPath;
}

- (NSString *)emtyTips {
    if (!_emtyTips) {
        _emtyTips = @"暂无商品信息";
    }
    return _emtyTips;
}

@end
