//
//  VipHeadInfoView.m
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/25.
//  Copyright © 2019 HT. All rights reserved.
//

#import "VipHeadInfoView.h"
@implementation VipHeadInfoView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setCommonBoardRadiusAndShadow];
        [self headIcon];
        [self nickName];
        [self vipStatus];
        [self tips];
        [self vipInfo];
    }
    return self;
}



#pragma mark - Setter && Getter
- (UIImageView *)headIcon {
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc] init];
        [self addSubview:_headIcon];
        [_headIcon settingCornerRadius:35 maskToBounds:true];
        [_headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(15);
            make.size.mas_equalTo(CGSizeMake(70, 70));
        }];
    }
    return _headIcon;
}


- (UILabel *)nickName {
    if (!_nickName) {
        UIFont *font = [UIFont boldFontSize:17];
        _nickName = [UILabel customFont:font color:rgba(7, 7, 7, 1) textAlignment:NSTextAlignmentLeft placeholder:@"Mr.right"];
        [self addSubview:_nickName];
        [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headIcon.mas_top).offset(6);
            make.left.mas_equalTo(self.headIcon.mas_right).offset(9);
        }];
    }
    return _nickName;
}

- (HTLabel *)vipStatus {
    if (!_vipStatus) {
        _vipStatus = [[HTLabel alloc] initWithFrame:CGRectZero edges:UIEdgeInsetsMake(4, 4, 4, 4)];
        [_vipStatus settingCornerRadius:5 maskToBounds:true];
        _vipStatus.font = [UIFont fontSize:9];
        _vipStatus.textColor = rgba(255, 255, 255, 1);
        _vipStatus.textAlignment = NSTextAlignmentCenter;
        _vipStatus.text = @"---";
        _vipStatus.backgroundColor = rgba(136, 136, 136, 1);
        [self addSubview:_vipStatus];
        [_vipStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.nickName);
            make.left.mas_equalTo(self.nickName.mas_right).offset(7);
        }];
    }
    return _vipStatus;
}

- (HTLabel *)vipInfo {
    if (!_vipInfo) {
        _vipInfo = [[HTLabel alloc] initWithFrame:CGRectZero edges:UIEdgeInsetsMake(6, 12, 6, 22)];
        _vipInfo.font = [UIFont mediumFontSize:11];
        _vipInfo.textColor = rgba(255, 255, 255, 1);
        _vipInfo.textAlignment = NSTextAlignmentLeft;
        _vipInfo.text = @"---";
        _vipInfo.backgroundColor = rgba(251, 94, 94, 1);
        [self addSubview:_vipInfo];
        [_vipInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.vipStatus);
            make.right.offset(0);
            make.width.offset(80);
        }];
        
        [_vipInfo setCornerWithByRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft radius:11];
    }
    return _vipInfo;
}


- (UILabel *)tips {
    if (!_tips) {
        _tips = [UILabel size:11 color:rgba(8, 8, 8, 1) textAlignment:NSTextAlignmentLeft placeholder:@"---"];
        [self addSubview:_tips];
        [_tips mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.headIcon.mas_bottom).offset(-12);
            make.left.equalTo(self.nickName);
        }];
    }
    return _tips;
}

- (UIImageView *)vipLogo {
    if (!_vipLogo) {
        _vipLogo = [[UIImageView alloc] init];
    }
    return _vipLogo;
}

@end
