//
//  HomeCollectionView.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/29.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "HomeCollectionView.h"
@interface HomeCollectionView()
/** 单行 */
@property(nonatomic,strong)UICollectionViewFlowLayout *rowFlowLayout;

/** 多列 */
@property(nonatomic,strong)UICollectionViewFlowLayout *colFlowLayout;




@end


@implementation HomeCollectionView
- (instancetype)initWithLayout:(UICollectionViewFlowLayout *)layout cellClass:(id)class identifier:(NSString *)identifier{
    self = [super initWithLayout:layout cellClass:class identifier:identifier];
    if (self) {
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        [self addGestureRecognizer:longPressGesture];
    }
    return self;
}


- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    //获取此次点击的坐标，根据坐标获取cell对应的indexPath
    CGPoint point = [longPress locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
    //根据长按手势的状态进行处理。
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            //当没有点击到cell的时候不进行处理
            if (!indexPath) {
                break;
            }
            //开始移动
            [self beginInteractiveMovementForItemAtIndexPath:indexPath];
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程中更新位置坐标
            [self updateInteractiveMovementTargetPosition:point];
            break;
        case UIGestureRecognizerStateEnded:
            //停止移动调用此方法
            [self endInteractiveMovement];
            break;
        default:
            //取消移动
            [self cancelInteractiveMovement];
            break;
    }
}


#pragma mark - DataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = (HomeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:self.cellID forIndexPath:indexPath];
    cell.titleLB.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.cellDelegate homeCollectionViewCellSelected:indexPath];
}

////每个单元格的大小size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(30,30);
//}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath
           toIndexPath:(NSIndexPath *)destinationIndexPath{
//    [self performBatchUpdates:^{
//        NSLog(@"%ld",sourceIndexPath.row);
//        NSLog(@"%ld",destinationIndexPath.row);
//    } completion:nil];
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}

#pragma mark - Setter && Getter
- (UICollectionViewFlowLayout *)rowFlowLayout{
    if (!_rowFlowLayout) {
        _rowFlowLayout =  [[UICollectionViewFlowLayout alloc] init];
        _rowFlowLayout.minimumLineSpacing = -10;
        _rowFlowLayout.minimumInteritemSpacing = 0;
        _rowFlowLayout.itemSize = CGSizeMake(SCREEN_W - 20,50);
    }
    return _rowFlowLayout;
}

- (UICollectionViewFlowLayout *)colFlowLayout{
    if (!_colFlowLayout) {
        _colFlowLayout =  [[UICollectionViewFlowLayout alloc] init];
        _colFlowLayout.minimumLineSpacing = 1;
        _colFlowLayout.minimumInteritemSpacing = 1;
        _colFlowLayout.itemSize = CGSizeMake((SCREEN_W - 40)  / 3, (SCREEN_W - 40)  / 3);
    }
    return _colFlowLayout;
}

- (void)setRowOrCol:(ComposingType)rowOrCol{
    _rowOrCol = rowOrCol;
    if (_rowOrCol == Row) {
        [self setCollectionViewLayout:self.rowFlowLayout animated:YES];
    }else{
        [self setCollectionViewLayout:self.colFlowLayout animated:YES];
    }
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
        _backGroundImgView.layer.shadowOpacity = 0.8;
        // 纵轴Y轴偏4个pt
         _backGroundImgView.layer.shadowOffset = CGSizeMake(0, 3);
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
