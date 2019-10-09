//
//  HTBaseCollectionView.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/6/18.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTBaseCollectionView.h"

@implementation HTBaseCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout identifer:(NSString *)identifer cellClassString:(NSString *)classString {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.cellID = identifer;
        if (classString.length == 0) {
            classString = @"UICollectionViewCell";
        }
        [self registerClass:NSClassFromString(classString) forCellWithReuseIdentifier:identifer];
        self.delegate = self;
        self.dataSource = self;
        self.showsHorizontalScrollIndicator = false;
        self.showsVerticalScrollIndicator = false;
    }
    return self;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 这里子类复写
    UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Setter && Getter
- (void)setData:(NSMutableArray *)data {
    _data = data;
    [self reloadData];
}


@end
