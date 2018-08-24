//
//  HZYWaterFallCollectionView.m
//  HZYToolBox
//
//  Created by hong  on 2018/8/23.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "HZYWaterFallCollectionView.h"

#define CellHeight (SCREEN_W - 32)/3 /0.655
#define CellWidth (SCREEN_W - CellInterVal  * 4)/3
#define CellInterVal 8
@implementation HZYWaterFallCollectionView
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    HZYWaterFallModel *waterFallModel = self.dataArray[indexPath.row];
    switch (waterFallModel.direction) {
        case Portait:return CGSizeMake(CellWidth, CellHeight);break;
        case Landscape:return CGSizeMake((SCREEN_W - CellInterVal * 3 - CellWidth), CellHeight);break;
        default:return CGSizeMake(CellWidth, CellHeight);break;
    }
}

//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 8, 8, 8);//分别为上、左、下、右
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellID forIndexPath:indexPath];
    cell.backgroundColor = RGB(arc4random()%255, arc4random()%255, arc4random()%255);
    return cell;
}
@end
