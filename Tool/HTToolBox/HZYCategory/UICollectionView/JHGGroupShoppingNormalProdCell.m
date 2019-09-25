//
//  JHGGroupShoppingNormalProdCell.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/31.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "JHGGroupShoppingNormalProdCell.h"

@interface JHGGroupShoppingNormalProdCell()

/**
 这个layer要预存
 */
@property(nonatomic, readwrite, strong)CAGradientLayer *buttonGradientLayer;
@end

@implementation JHGGroupShoppingNormalProdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _prodIcon = [[UIImageView alloc] init];
    _prodIcon.image = [UIImage imageNamed:@"JHGAboutUsLogo"];
    _prodIcon.backgroundColor = [UIColor orangeColor];
    [self addSubview:_prodIcon];
    
    
    _prodNameLB = [UILabel size:14 color:rgba(51, 51, 51, 1) textAlignment:NSTextAlignmentLeft placeholder:@"苹果手机苹果手机苹果手手是手机苹果手机苹果手机苹果在..."];
    _prodNameLB.numberOfLines = 2;
    [self addSubview:_prodNameLB];
    
    
    _personCount = [UILabel size:13 color:rgba(222, 49, 33, 1) textAlignment:NSTextAlignmentLeft placeholder:@"2人拼"];
    [self addSubview:_personCount];
    
    
    _price = [UILabel size:14 color:rgba(222, 49, 33, 1) textAlignment:NSTextAlignmentLeft placeholder:@""];
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:@"￥1999.90"];
    [priceStr yy_setFont:[UIFont boldFontSize:14] range:NSMakeRange(0, 1)];
    [priceStr yy_setFont:[UIFont boldFontSize:19] range:NSMakeRange(1, priceStr.length - 1)];
    _price.attributedText = priceStr;
    [self addSubview:_price];
    
    
    _groupProdCount = [UILabel size:12 color:rgba(153, 153, 153, 1) textAlignment:NSTextAlignmentLeft placeholder:@"已拼191件"];
    [self addSubview:_groupProdCount];
    
    
    _groupButton = [UIButton creatByTitle:@"去拼团" titleColor:rgba(255, 255, 255, 1) fontSize:14];
    _groupButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_groupButton];
    if (!self.buttonGradientLayer) {
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self);
            self.buttonGradientLayer = [self.groupButton settingGrandientAndShadowWithOffset:CGSizeMake(0, 1.5) shadowColor:rgba(229, 66, 21, 0.5) opacity:0.5 rect:self.groupButton.bounds colors:@[rgba(255, 61, 51, 1),rgba(255, 110, 22, 1)] cornerRadius:15 shadowRadius:4];
        });
    }
    
    UIView *segementLine = [[UIView alloc] init];
    segementLine.backgroundColor = rgba(245, 245, 245, 1);
    [self addSubview:segementLine];

    
    // layout
    [_prodIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(10);
        make.size.mas_equalTo(CGSizeMake(128, 128));
    }];
    
    [_prodNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(16);
        make.left.mas_equalTo(self.prodIcon.mas_right).offset(10);
        make.right.offset(-13);
    }];
    
    [_personCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.prodNameLB);
        make.baseline.mas_equalTo(self.mas_bottom).offset(-37);
        make.left.equalTo(self.prodNameLB);
    }];
    
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.personCount.mas_right).offset(9);
        make.baseline.equalTo(self.personCount.mas_baseline);
    }];
    
    [_groupProdCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.baseline.mas_equalTo(self.mas_bottom).offset(-14);
        make.left.equalTo(self.prodNameLB);
    }];
    
    [_groupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-10);
        make.right.offset(-15);
        make.size.mas_equalTo(CGSizeMake(65, 30));
    }];
    
    [segementLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.prodIcon);
        make.right.equalTo(self.prodNameLB);
        make.height.offset(0.5);
        make.bottom.offset(0);
    }];
}

@end
