//
//  HTCommonTableView.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/10/9.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCommonTableView.h"

@interface HTCommonTableView ()


@end

@implementation HTCommonTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style cellClassNames:(nullable NSArray *)cellClassNames delegateTarget:(nullable id)target {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.cellClassNames = cellClassNames;
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        [self registerClass:NSClassFromString(@"HTCommonTableViewCell") forCellReuseIdentifier:@"HTCommonTableViewCell"];
        if (@available(iOS 11.0, *)) {
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
             self.translatesAutoresizingMaskIntoConstraints = false;
        }

        for (NSString *name in cellClassNames) {
            [self registerClass:NSClassFromString(name) forCellReuseIdentifier:name];
        }
        
        // no delegate target,then self become delegator
        if (!target) {
            target = self;
        }
        self.delegate = target;
        self.dataSource = target;
    }
    return self;
}


#pragma mark - DataSource 数据源方法只有自己单独成为代理才会用到
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    if (self.style == UITableViewStylePlain) {
        return self.data.count;
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.style == UITableViewStylePlain) {
        return 1;
    }else {
        return self.data.count;;
    }
}


// 代理方法必须复写
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (self.cellClassNames.count > 0) {
         cell = [tableView dequeueReusableCellWithIdentifier:self.cellClassNames[0]];
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"HTCommonTableViewCell"];
    }
    [self configureCell:cell atIndexPath:indexPath tableView:tableView];
    return cell;
}

#pragma mark - Setter && Getter
- (void)setData:(NSMutableArray *)data {
    _data = data;
    [self reloadData];
}

@end
