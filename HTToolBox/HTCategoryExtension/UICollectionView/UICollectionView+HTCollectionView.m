//
//  UICollectionView+collectionViewTool.m
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/26.
//  Copyright © 2019 HT. All rights reserved.
//

#import "UICollectionView+HTCollectionView.h"

@implementation UICollectionView (HTCollectionView)

+(instancetype)creatWithFlowLayout:(UICollectionViewFlowLayout *)flowLayout classString:(NSString *)classString {
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [collectionView registerClass:NSClassFromString(classString) forCellWithReuseIdentifier:classString];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = false;
    collectionView.showsVerticalScrollIndicator = false;
    return collectionView;
}


@end
