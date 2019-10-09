//
//  HTBaseTableView.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/6/18.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTBaseTableView.h"

@implementation HTBaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style identifer:(nonnull NSString *)identifer cellClassString:(nonnull NSString *)classString {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        
        self.cellID = identifer;
        if (classString.length == 0) {
            classString = @"UITableViewCell";
        }
        self.estimatedRowHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.translatesAutoresizingMaskIntoConstraints = false;
        }
        
        [self registerClass:NSClassFromString(classString) forCellReuseIdentifier:identifer];
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellID];
    return cell;
}

#pragma mark - Setter && Getter
- (void)setData:(NSMutableArray *)data {
    _data = data;
    [self reloadData];
}

@end
