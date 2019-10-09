//
//  HTCycleNormalView.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/9/26.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCycleNormalView.h"
@implementation HTCycleNormalView

#pragma mark - DataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.configModel.cellClassName forIndexPath:indexPath];
    NSIndexPath *tempIndex = [self realDataIndexPath:indexPath];
    [self configCell:cell indexPath:tempIndex collectionView:collectionView];
    return cell;
}

- (void)configCell:(HTCycleViewNormalStyleCell *)cell indexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView {
    NSString *imgPath = [self fetchDataWithIndexPath:indexPath];
    [cell.contentImageView bw_setJHGImageWithImagePath:imgPath];
}

- (void)injectData:(NSArray<NSString *> *)data {
    if (data.count > 0) {
        // if first not string throw exception
        id first = data.firstObject;
        if (![first isKindOfClass:[NSString class]]) {
            @throw [NSException exceptionWithName:@"HTCycleView Method Crash" reason:@"data constans some element not string" userInfo:nil];
        }else {
            self.data = data;
        }
    }
}

@end
