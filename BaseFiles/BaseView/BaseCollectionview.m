//
//  BaseCollectionview.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/29.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "BaseCollectionview.h"

@implementation BaseCollectionview
- (instancetype)initWithLayout:(UICollectionViewFlowLayout *)layout cellClass:(id)class identifier:(NSString *)identifier{
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:class forCellWithReuseIdentifier:identifier];
        self.delegate = self;
        self.dataSource = self;
        self.cellID = identifier;
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

// sub rewrite
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell  *cell = [collectionView cellForItemAtIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Setter && Getter
- (void)setModelArray:(NSMutableArray *)dataArray{
    if (dataArray != _dataArray) {
        _dataArray = dataArray;
        [self reloadData];
    }
}

@end
