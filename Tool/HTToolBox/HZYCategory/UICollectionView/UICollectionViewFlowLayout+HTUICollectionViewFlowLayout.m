//
//  UICollectionViewFlowLayout+HTUICollectionViewFlowLayout.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/30.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "UICollectionViewFlowLayout+HTUICollectionViewFlowLayout.h"

@implementation UICollectionViewFlowLayout (HTUICollectionViewFlowLayout)

+(instancetype)creatWithLineSpacing:(CGFloat)LineSpacing  InteritemSpacing:(CGFloat)InteritemSpacing sectionInset:(UIEdgeInsets)sectionInset itemSize:(CGSize)itemSize scrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = LineSpacing;
    layout.minimumInteritemSpacing = InteritemSpacing;
    layout.scrollDirection = scrollDirection;
    layout.itemSize = itemSize;
    layout.sectionInset = sectionInset;
    return layout;
}




@end
