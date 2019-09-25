//
//  HTDebuggerViewController.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/7.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTDebuggerViewController.h"
//test
#import "HTCycleView.h"



#import "JHGGoupShoppingDetailHeaderView.h"

#import "JHGGroupShoppingOrderDetailPersonInfoCell.h"

// end
@interface HTDebuggerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 详情的collectionView
 */
@property(nonatomic, readwrite, strong)UICollectionView *detailCollectionView;

/**
 头部
 */
@property(nonatomic, readwrite, strong)JHGGoupShoppingDetailHeaderView *header;


/**
 JHGGroupShoppingOrderDetailPersonInfoCell
 */
@property(nonatomic, readwrite, strong)JHGGroupShoppingOrderDetailPersonInfoCell *cell;



@end

@implementation HTDebuggerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self layoutPageViews];
}

- (void)injected
{
    NSLog(@"I've been injected: %@", self);
    for (UIView *value in self.view.subviews) {
        [value removeFromSuperview];
    }
    
    [self layoutPageViews];
    
    
}


- (void)layoutPageViews {
    self.cell = [[JHGGroupShoppingOrderDetailPersonInfoCell alloc] init];
    [self.view addSubview:self.cell];
    [self.cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.right.offset(0);
        make.height.offset(107);
    }];
}


//- (void)layoutPageViews {
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    CGFloat width = (BWScreenWidth - 10 * 2 - 9) / 2;
//    CGFloat mutiply = 280.0 / 173;
//    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout creatWithLineSpacing:9 InteritemSpacing:9 sectionInset:UIEdgeInsetsMake(0, 10, 0, 10) itemSize:CGSizeMake(width, width * mutiply) scrollDirection:UICollectionViewScrollDirectionVertical];
//    self.detailCollectionView = [UICollectionView creatWithFlowLayout:flowLayout classString:@"JHGGroupShoppingDetailProdCell"];
//
//
//    JHGGroupShoppingDetailInfoModel *model = [[JHGGroupShoppingDetailInfoModel alloc] init];
//    model.status = JHGGroupShoppingStatusFailed;
//    model.groupCount = 1;
//    model.statusdes = @"拼团失败";
//    model.detaildes = @"注：款项已退，但银行退款至您的支付账户中间还需要1-5个工作日审核时间，因此退款可能会有一点延迟。";
//    model.failedTime = @"失败时间 2018/10/25  12:14:21";
//    self.header.infoModel = model;
//    self.header = [[JHGGoupShoppingDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, BWScreenWidth, 999) infoModel:model];;
//    // 每次Info模型变更的时候应该刷新一下重新计算高度
////    [self.detailCollectionView reloadData];
//
//
//
//
//
//
//
//    [self.detailCollectionView registerClass:[JHGGoupShoppingDetailHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JHGGoupShoppingDetailHeaderView"];
//
//    self.detailCollectionView.delegate = self;
//    self.detailCollectionView.dataSource = self;
//    [self.view addSubview:self.detailCollectionView];
//
//
//
//
//    // layout
//    [self.detailCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsMake(BWNavigationBarHeight, 0, 0, 0));
//    }];
//
//
//
//
////    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////
////    });
//}

#pragma mark - 设置表头方式二
// 要先设置表头大小
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(BWScreenWidth, [self.header fetchHeaderHeight]);
}


// 创建一个继承collectionReusableView的类,用法类比tableViewcell
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        JHGGoupShoppingDetailHeaderView *tempHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JHGGoupShoppingDetailHeaderView" forIndexPath:indexPath];
        JHGGroupShoppingDetailInfoModel *model = [[JHGGroupShoppingDetailInfoModel alloc] init];
        model.status = JHGGroupShoppingStatusFailed;
        model.groupCount = 1;
        model.statusdes = @"拼团失败";
        model.detaildes = @"注：款项已退，但银行退款至您的支付账户中间还需要1-5个工作日审核时间，因此退款可能会有一点延迟。";
        model.failedTime = @"失败时间 2018/10/25  12:14:21";
        
        
        tempHeaderView.infoModel = model;
        reusableView = tempHeaderView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        // 底部视图
    }
    return reusableView;
}


#pragma mark - delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 99;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JHGGroupShoppingDetailProdCell" forIndexPath:indexPath];
//    if (indexPath.row == 0) {
//        cell.icon.image = [UIImage imageNamed:@"JHGPresellHot"];
//        cell.captainFlag.hidden = false;
//        cell.borderView.hidden = false;
//    }else {
//        cell.icon.image = [UIImage imageNamed:@"JHGPresellHot"];
//        cell.captainFlag.hidden = true;
//        cell.borderView.hidden = true;
//    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
