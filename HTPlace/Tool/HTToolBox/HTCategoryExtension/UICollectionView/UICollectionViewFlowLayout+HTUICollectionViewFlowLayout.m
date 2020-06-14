//
//  UICollectionViewFlowLayout+HTUICollectionViewFlowLayout.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/30.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "UICollectionViewFlowLayout+HTUICollectionViewFlowLayout.h"

@implementation UICollectionViewFlowLayout (HTUICollectionViewFlowLayout)

/**
 当横向排布时，lineSpacing是两个item左右之间的间距,interitemSpacing为0,注意collectionView高度不能＞item高度两倍，不然换行
 当纵向排布是, lineSpacing是两个item上下之间的间距，interitemSpacing是左右间距
 */
+ (instancetype)creatWithLineSpacing:(CGFloat)lineSpacing  InteritemSpacing:(CGFloat)interitemSpacing itemCount:(NSInteger)itemCount sectionInset:(UIEdgeInsets)sectionInset sourceSize:(CGSize)sourceSize needChangeSize:(BOOL)needChangeSize scrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = lineSpacing;
    layout.minimumInteritemSpacing = interitemSpacing;
    layout.scrollDirection = scrollDirection;
    layout.sectionInset = sectionInset;
    
    CGFloat itemAllWidth = 0;
    
    // 如果是纵向排列
    if (layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        itemAllWidth = SCREEN_W - sectionInset.left - sectionInset.right - interitemSpacing * (itemCount - 1);
    }else {
        // 横向排列
        itemAllWidth = SCREEN_W - sectionInset.left - sectionInset.right - lineSpacing * (itemCount - 1);
    }
    
    if (needChangeSize) {
        NSInteger cellWidth = itemAllWidth / itemCount;
        CGFloat mutiply = sourceSize.height / sourceSize.width;
        NSInteger cellHeight = cellWidth * mutiply;
        layout.itemSize = CGSizeMake(cellWidth, cellHeight);
    }else {
        layout.itemSize = sourceSize;
    }
    
    return layout;
}



+ (instancetype)creatWithLineSpacing:(CGFloat)LineSpacing  InteritemSpacing:(CGFloat)InteritemSpacing sectionInset:(UIEdgeInsets)sectionInset itemSize:(CGSize)itemSize scrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = LineSpacing;
    layout.minimumInteritemSpacing = InteritemSpacing;
    layout.scrollDirection = scrollDirection;
    layout.itemSize = itemSize;
    layout.sectionInset = sectionInset;
    return layout;
}

@end
