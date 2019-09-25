//
//  VipPrivilegeDesCell.m
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/30.
//  Copyright © 2019 HT. All rights reserved.
//

#import "VipPrivilegeDesCell.h"

@interface VipPrivilegeDesCell ()
/**
 会员尊享特权提示语
 */
@property(nonatomic, readwrite, strong)UILabel *tips;

@end

@implementation VipPrivilegeDesCell
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupPageViews];
    }
    return self;
}


- (void)setupPageViews {
    // setup
    self.tips = [UILabel customFont:[UIFont boldFontSize:15] color:rgba(59, 59, 59, 1) textAlignment:NSTextAlignmentLeft placeholder:@"会员尊享特权"];
    [self addSubview:self.tips];
    
    UIView *segementLine = [[UIView alloc] init];
    segementLine.backgroundColor = rgba(242, 242, 242, 1);
    
    [self addSubview:segementLine];
    
    
    
    
    // layout
    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(16);
        make.left.offset(13);
    }];
    
    [segementLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tips.mas_baseline).offset(14);
        make.left.equalTo(self.tips.mas_left);
        make.right.offset(-14);
    }];
}
@end
