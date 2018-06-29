//
//  HomeCollectionView.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/29.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "HomeCollectionView.h"
@implementation HomeCollectionView
#pragma mark - DataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = (HomeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:self.cellID forIndexPath:indexPath];
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
        [self addSubview:self.backGroundImgView];
        [self addSubview:self.iconImgView];
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews{
    [self.backGroundImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.8);
        make.height.equalTo(self.iconImgView.mas_width);
    }];
}
#pragma mark - Setter && Getter
- (UIImageView *)backGroundImgView{
    if (!_backGroundImgView) {
        _backGroundImgView = [[UIImageView alloc] init];
        _backGroundImgView.backgroundColor = [UIColor redColor];
    }
    return _backGroundImgView;
}

- (UIImageView *)iconImgView{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.backgroundColor = [UIColor yellowColor];
    }
    return _iconImgView;
}
@end
