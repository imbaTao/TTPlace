//
//  VipChoosePriceCollectionViewCell.m
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/26.
//  Copyright © 2019 HT. All rights reserved.
//

#import "VipChoosePriceCollectionViewCell.h"
@interface VipChoosePriceCollectionViewCell()
/**
 面板视图
 */
@property(nonatomic, readwrite, strong)UIView *boardView;

@end

@implementation VipChoosePriceCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self priceDes];
        [self nowPrice];
        [self sourcePrice];
        [self tips];
        [self recommendFlag];
    }
    return self;
}


#pragma mark - Setter && Getter
- (UIView *)boardView {
    if (!_boardView) {
        _boardView = [[UIView alloc] init];
        [self.boardView settingCornerRadius:5 maskToBounds:false];
        [self addSubview:_boardView];
        _boardView.layer.borderColor = rgba(242, 131, 131, 1).CGColor;
        _boardView.layer.borderWidth = 1;
        [_boardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _boardView;
}

- (UILabel *)recommendFlag {
    if (!_recommendFlag) {
        _recommendFlag = [UILabel customFont:[UIFont mediumFontSize:9] color:rgba(255, 255, 255, 1) textAlignment:NSTextAlignmentCenter placeholder:@"1231123123"];
        _recommendFlag.backgroundColor = rgba(248, 73, 72, 1);
        [self addSubview:_recommendFlag];
        [_recommendFlag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(0);
            make.top.offset(-5);
            make.size.mas_equalTo(CGSizeMake(32, 16));
        }];
        [_recommendFlag setCornerWithByRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomLeft radius:9];
    }
    return _recommendFlag;
}

- (UILabel *)priceDes {
    if (!_priceDes) {
        _priceDes = [UILabel customFont:[UIFont mediumFontSize:11] color:rgba(7, 7, 7, 1) textAlignment:NSTextAlignmentCenter placeholder:@"连续包年"];
        [self.boardView addSubview:_priceDes];
        [_priceDes mas_makeConstraints:^(MASConstraintMaker *make) {
            make.baseline.mas_equalTo(self.recommendFlag.mas_bottom).offset(18);
            make.centerX.mas_equalTo(self);
        }];
    }
    return _priceDes;
}

- (UILabel *)nowPrice {
    if (!_nowPrice) {
        _nowPrice = [UILabel customFont:[UIFont boldFontSize:26] color:rgba(232, 72, 98, 1) textAlignment:NSTextAlignmentCenter placeholder:@"￥199"];
        [self.boardView addSubview:_nowPrice];
        [_nowPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.baseline.mas_equalTo(self.priceDes.mas_baseline).offset(32);
            make.centerX.mas_equalTo(self);
        }];
    }
    return _nowPrice;
}

- (UILabel *)sourcePrice {
    if (!_sourcePrice) {
        _sourcePrice = [UILabel customFont:[UIFont fontSize:12] color:rgba(108, 108, 108, 1) textAlignment:NSTextAlignmentCenter placeholder:@"￥399"];
        [self.boardView addSubview:_sourcePrice];
        [_sourcePrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.baseline.mas_equalTo(self.nowPrice.mas_baseline).offset(16);
            make.centerX.mas_equalTo(self);
        }];
    }
    return _sourcePrice;
}

- (UILabel *)tips {
    if (!_tips) {
        _tips = [UILabel size:9 color:rgba(108, 108, 108, 1) textAlignment:NSTextAlignmentCenter placeholder:@"----"];
        [self.boardView addSubview:_tips];
        [_tips mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.offset(-10);
            make.centerX.mas_equalTo(self);
        }];
    }
    return _tips;
}
@end
