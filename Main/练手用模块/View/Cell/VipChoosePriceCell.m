////
////  VipChoosePriceCell.m
////  HTToolBox
////
////  Created by Mr.hong on 2019/7/25.
////  Copyright © 2019 HT. All rights reserved.
////
//
//#import "VipChoosePriceCell.h"
//
//
//@implementation VipChoosePriceCell
//#pragma mark - Setter && Getter
//- (UICollectionView *)priceCollectionView {
//    if (!_priceCollectionView) {
//        _priceCollectionView = [UICollectionView creatWithFlowLayout:[UICollectionViewFlowLayout creatWithLineSpacing:18 InteritemSpacing:0 sectionInset:UIEdgeInsetsMake(0, 15, 0, -15) itemSize:CGSizeMake(95, 105)] classString:@"VipChoosePriceCollectionViewCell"];
//        _priceCollectionView.clipsToBounds = false;;
//        _priceCollectionView.layer.masksToBounds = false;
//        [self addSubview:_priceCollectionView];
//        [_priceCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.offset(20);
//            make.left.offset(0);
//            make.right.offset(0);
//            make.bottom.mas_equalTo(self.buyButton.mas_top).offset(-20);
//        }];
//    }
//    return _priceCollectionView;
//}
//
//- (UIButton *)buyButton {
//    if (!_buyButton) {
//        _buyButton = [[UIButton alloc] init];
//        _buyButton.titleLabel.font = [UIFont fontSize:17];
//        [_buyButton setTitle:@"---" forState:UIControlStateNormal];
//        [_buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_buyButton settingCornerRadius:20];
//        _buyButton.backgroundColor = rgba(251, 94, 94, 1);
//        [self addSubview:_buyButton];
//        [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.offset(40);
//            make.left.offset(15);
//            make.right.offset(-15);
//            make.bottom.offset(-15);
//        }];
//    }
//    return _buyButton;
//}
//@end
