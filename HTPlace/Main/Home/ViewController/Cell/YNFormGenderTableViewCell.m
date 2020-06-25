//
//  YNFormGenderTableViewCell.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/25.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "YNFormGenderTableViewCell.h"

@implementation YNFormGenderTableViewCell

- (void)setupUI {
    self.manButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.manButton setImage:[UIImage imageNamed:@"性别男1"] forState:UIControlStateNormal];
    [self.manButton setImage:[UIImage imageNamed:@"性别男2"] forState:UIControlStateSelected];
    [self addSubview:self.manButton];
    [self.manButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(-56);
        make.bottom.offset(-5);
        make.size.mas_equalTo(CGSizeMake(56, 56));
    }];
    
    self.womanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.womanButton setImage:[UIImage imageNamed:@"性别女1"] forState:UIControlStateNormal];
    [self.womanButton setImage:[UIImage imageNamed:@"性别女2"] forState:UIControlStateSelected];
    [self addSubview:self.womanButton];
    [self.womanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(56);
        make.bottom.offset(-5);
        make.size.mas_equalTo(CGSizeMake(56, 56));
    }];

    
    @weakify(self);
     [[self.manButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self);
         self.manButton.selected = true;
         self.womanButton.selected = false;
         self.model.content = @"1";
     }];
    
     [[self.womanButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self);
         self.manButton.selected = false;
         self.womanButton.selected = true;
         self.model.content = @"2";
     }];
}

- (void)setModel:(YNFormTableViewFormModel *)model {
    _model = model;
    if ([model.content isEqualToString:@"1"]) {
        [self.manButton setSelected:true];
        [self.womanButton setSelected:false];
    }else {
        [self.manButton setSelected:false];
        [self.womanButton setSelected:true];
    }
}

@end
