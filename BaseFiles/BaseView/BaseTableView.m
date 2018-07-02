//
//  BaseTableView.m
//  HZYToolBox
//
//  Created by hong  on 2018/7/2.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView
- (instancetype)initWithCellClass:(id)class identifier:(NSString *)identifier{
    self = [super init];
    if (self) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:class forCellReuseIdentifier:identifier];
        self.cellID = identifier;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.cellDelegate cellSelectedWithIndexPath:indexPath];
}

@end
