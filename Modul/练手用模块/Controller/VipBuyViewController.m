//
//  VipRenewHomeViewController.m
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/25.
//  Copyright © 2019 HT. All rights reserved.
//

#import "VipBuyViewController.h"

#import "VipHeadInfoView.h"
#import "VipChoosePriceCell.h"
@interface VipBuyViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 头部视图
 */
@property(nonatomic, readwrite, strong)VipHeadInfoView *headInfoView;


/**
 选择价格视图
 */
@property(nonatomic, readwrite, strong)VipChoosePriceCell *choosePriceCell;



/**
 <#description#>
 */
@property(nonatomic, readwrite, strong)UIView *tempView1;

/**
 <#description#>
 */
@property(nonatomic, readwrite, strong)UIView *tempView2;


@end

@implementation VipBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgba(242, 242, 242, 1);
    [self headInfoView];
    [self choosePriceCell];
    self.headInfoView.headIcon.image = [UIImage imageNamed:@"it"];
}


#pragma mark - 价格选择cell中的代理方法在控制器中实现
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VipChoosePriceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VipChoosePriceCollectionViewCell" forIndexPath:indexPath];
    [self configCell:cell indexPath:indexPath collectionView:collectionView];
    return cell;
}

- (void)configCell:(VipChoosePriceCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView {
    cell.priceDes.text = @"---";
    cell.nowPrice.text = @"---";
    cell.sourcePrice.text = @"---";
    
    
    cell.recommendFlag.hidden = indexPath.row != 0;
    [RACObserve(cell, selected) subscribeNext:^(id  _Nullable x) {
       cell.backgroundColor =  cell.selected ? rgba(253, 236, 239, 1) : rgba(255, 255, 255, 1);
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     [collectionView selectItemAtIndexPath:indexPath animated:false scrollPosition:UICollectionViewScrollPositionNone];
}

#pragma mark - Setter && Getter
- (VipChoosePriceCell *)choosePriceCell {
    if (!_choosePriceCell) {
        _choosePriceCell = [[VipChoosePriceCell alloc] init];
        _choosePriceCell.priceCollectionView.delegate = self;
        _choosePriceCell.priceCollectionView.dataSource = self;
        [self.view addSubview:_choosePriceCell];
        [_choosePriceCell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headInfoView.mas_bottom).offset(10);
            make.leading.trailing.equalTo(self.headInfoView);
            make.height.offset(200);
        }];
    }
    return _choosePriceCell;
}


- (VipHeadInfoView *)headInfoView {
    if (!_headInfoView) {
        _headInfoView = [[VipHeadInfoView alloc] init];
        [self.view addSubview:_headInfoView];
        [_headInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(30);
            make.left.offset(13);
            make.right.offset(-13);
            make.height.offset(115);
        }];
    }
    return _headInfoView;
}
@end
