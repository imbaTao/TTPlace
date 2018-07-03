//
//  HomeCollectionView.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/29.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "HomeCollectionView.h"
@implementation HomeCollectionView
//#pragma mark - Delegate
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 5;
//}

#pragma mark - DataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = (HomeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:self.cellID forIndexPath:indexPath];
    cell.titleLB.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.cellDelegate homeCollectionViewCellSelected:indexPath];
}


@end

#pragma mark - Cell
@implementation HomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1;
        [self addSubview:self.backGroundImgView];
        [self addSubview:self.titleLB];
//        [self addSubview:self.iconImgView];
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews{
    self.backGroundImgView.backgroundColor = [UIColor blackColor];
    [self.backGroundImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(4, 4, 4, 4));
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.offset(0);
        make.right.offset(0);
    }];
    
//    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//        make.width.equalTo(self).multipliedBy(0.8);
//        make.height.equalTo(self.iconImgView.mas_width);
//    }];
}
#pragma mark - Setter && Getter
- (UIImageView *)backGroundImgView{
    if (!_backGroundImgView) {
        _backGroundImgView = [[UIImageView alloc] init];
        _backGroundImgView.backgroundColor = [UIColor clearColor];
        _backGroundImgView.layer.shadowColor = [UIColor whiteColor].CGColor;
        _backGroundImgView.layer.shadowRadius = 4.0f;
        _backGroundImgView.layer.shadowOpacity = 0.8;
        // 纵轴Y轴偏4个pt
         _backGroundImgView.layer.shadowOffset = CGSizeMake(2, 4);
    }
    return _backGroundImgView;
}

- (UILabel *)titleLB{
    if (!_titleLB) {
        _titleLB = [UILabel creatLabelWithText:@"" textColor:[UIColor whiteColor] fontSize:14];
    }
    return _titleLB;
}

- (UIImageView *)iconImgView{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.backgroundColor = [UIColor yellowColor];
    }
    return _iconImgView;
}
@end
