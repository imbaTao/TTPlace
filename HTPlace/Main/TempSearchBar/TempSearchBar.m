//
//  TempSearchBar.m
//  HTPlace
//
//  Created by hong on 2020/1/6.
//  Copyright © 2020 HZY. All rights reserved.
//

#import "TempSearchBar.h"

@implementation TempSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.searchTF];
        [self addSubview:self.searchImageV];
        self.backgroundColor = UIColor.brownColor;
        self.layer.cornerRadius = 30.f / 2.0;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    //高度一致保持在30pt
    if (frame.size.height != 30.f) {
        frame.size.height = 30;
    }
    [super setFrame:frame];
}

- (void)setSearchPlaceholder:(NSString *)searchPlaceholder {
    _searchPlaceholder = searchPlaceholder;
    NSMutableAttributedString *attributePlaceholder = [[NSMutableAttributedString alloc] initWithString:_searchPlaceholder];
//    [attributePlaceholder addAttribute:NSForegroundColorAttributeName value:BWColor999999 range:NSMakeRange(0, _searchPlaceholder.length)];
//    [attributePlaceholder addAttribute:NSFontAttributeName value:BWSYS_FONT(13) range:NSMakeRange(0, _searchPlaceholder.length)];
    self.searchTF.attributedPlaceholder = attributePlaceholder;
}

//适配iOS11h导航栏
- (CGSize)intrinsicContentSize {
    //        return UILayoutFittingExpandedSize;
    return CGSizeMake(SCREEN_W - 108, 30);
}

- (void)layoutSubviews {
    [self.searchImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    [self.searchTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(0);
        make.left.equalTo(self.searchImageV.mas_right).offset(4);
        make.top.offset(5);
    }];
}

- (UIImageView *)searchImageV {
    if (!_searchImageV) {
        _searchImageV = [[UIImageView alloc] init];
//        [_searchImageV bw_setImageWithImageString:THEM.navModel.NavigationBarSearchBarImg];
    }
    return _searchImageV;
}

- (UITextField *)searchTF {
    if (!_searchTF) {
        _searchTF = [[UITextField alloc] init];
        _searchTF.returnKeyType = YES;
        _searchTF.textColor = UIColor.blackColor;
//        _searchTF.font = BWSYS_FONT(13);
        _searchTF.tintColor = UIColor.redColor;
        _searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _searchTF;
}

@end
