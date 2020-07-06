//
//  YNFormLocationDetailCell.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/27.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "YNFormLocationDetailCell.h"

@implementation YNFormLocationDetailCell

- (void)setupUI {
    self.contentLabel = [UILabel regularFontWithSize:16 color:rgba(102, 102, 102, 1)];
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.centerY.equalTo(self);
    }];
    
    self.segementLine = [[UIView alloc] init];
    self.segementLine.backgroundColor =  rgba(0, 0, 0, 0.04);
    [self addSubview:self.segementLine];
    [self.segementLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(11);
        make.bottom.offset(0);
        make.right.offset(-1);
        make.height.offset(1);
    }];
}

@end
