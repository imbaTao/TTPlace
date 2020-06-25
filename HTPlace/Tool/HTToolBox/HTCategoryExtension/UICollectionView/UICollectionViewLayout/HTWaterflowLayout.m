//
//  HTWaterflowLayout.m
//  瀑布流布局
//
//  Created by liucai on 2017/8/14.
//  Copyright © 2017年 liucai. All rights reserved.
//

#import "HTWaterflowLayout.h"

@implementation HTWaterflowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    //初始化字典
    self.maxYDic = [NSMutableDictionary dictionary];
    self.attributesArr = [NSMutableArray array];
    
    if (self.maxYDic) {
        [self.maxYDic removeAllObjects];
    }
    for (int i = 0; i < self.numberOfColums; i++) {
        //        self.maxYDic[@(i)] = @(self.sectionInsets.top);
        [self.maxYDic setObject:@(self.sectionInsets.top) forKey:@(i)];
    }
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < itemCount; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [self.attributesArr addObject:attributes];
    }
}

//瀑布流一般只能竖直滑动 只需计算contentSize.height即可
- (CGSize)collectionViewContentSize {
    //最长那列的下标
    __block NSNumber *maxIndex = @(0);
    //便利字典 找出最长的那一列
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //如果maxIndex的最大y值小于obj,则让maxIndex等于obj所属那列
        if ([self.maxYDic[maxIndex] floatValue] < [obj floatValue]) {
            maxIndex = key;
        }
    }];
    //collectionView 的contentSize.height 等于最长列的最大Y值 + 下内边距
    return CGSizeMake(0, [self.maxYDic[maxIndex] floatValue] + self.sectionInsets.bottom);
}

//该方法主要用来设置每个item的attributes 在这里 我们只需要简单的设置每个item的attributes.frame即可
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat collectionW = self.collectionView.frame.size.width;
    
    //item宽度 = (collectionView.frame.size.with - (左边距 + 右边距) - (总列数 - 1) * 列间距) / 列数
    CGFloat itemW = floor((collectionW - (self.sectionInsets.left + self.sectionInsets.right) - (self.numberOfColums - 1) * self.interitemSpacing) / self.numberOfColums);
    
    /**
     *  接下来 计算item的坐标  要想计算item的坐标 就必须知道最短的那一列  便利字典  找出最短列  以及其最大Y值
     
     item.y = 最短列最大Y值 + 行间距
     item.x = 左边距 + (itemW  + 列间距) * 最短列
     */
    
    //找出最短列
    __block NSNumber *minIndex = @0;
    [self.maxYDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self.maxYDic[minIndex] floatValue] > [obj floatValue]) {
            minIndex = key;
        }
    }];
    CGFloat itemX = self.sectionInsets.left + (itemW + self.interitemSpacing) * minIndex.integerValue;
    CGFloat itemY = self.lineSpacing + [self.maxYDic[minIndex] floatValue];
    
    //  随机值
    CGFloat itemH = 0;
    
    
    //计算itemH
    if (self.calculateitemHBlock) {
        itemH = self.calculateitemHBlock(itemW,indexPath);
    }
    //最后设置attributes.frame 并更新字典
    UICollectionViewLayoutAttributes *attirbutes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attirbutes.frame = CGRectMake(itemX, itemY, itemW, itemH);
    
    //更新字典中最短列的最大Y值
    //    self.maxYDic[minIndex] = @(CGRectGetMaxY(attirbutes.frame));
    [self.maxYDic setObject:@(CGRectGetMaxY(attirbutes.frame)) forKey:minIndex];
    
    return attirbutes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributesArr;
}

@end
