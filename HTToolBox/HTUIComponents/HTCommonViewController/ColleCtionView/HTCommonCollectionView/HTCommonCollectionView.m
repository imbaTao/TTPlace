//
//  HTCommonCollectionView.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/10/9.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCommonCollectionView.h"

@implementation HTCommonCollectionView


- (instancetype)initWithFrame:(CGRect)frame layout:(UICollectionViewFlowLayout *)layout cellClassNames:(NSArray *)cellClassNames delegateTarget:(nullable id)target {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.cellClassNames = cellClassNames;
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        [self registerClass:NSClassFromString(@"HTCommonCollectionViewCell") forCellWithReuseIdentifier:@"HTCommonCollectionViewCell"];
        
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.translatesAutoresizingMaskIntoConstraints = false;
        }
        
        for (NSString *name in cellClassNames) {
              [self registerClass:NSClassFromString(name) forCellWithReuseIdentifier:name];
        }
        
        // no delegate target,then self become delegator
        if (!target) {
            target = self;
        }
        self.delegate = target;
        self.dataSource = target;
    }
    return self;
}

- (instancetype)initWithlayout:(UICollectionViewFlowLayout *)layout cellClassNames:(NSArray *)cellClassNames delegateTarget:(id)target {
    self = [self initWithFrame:CGRectZero layout:layout cellClassNames:cellClassNames delegateTarget:target];
    if (self) {
        
    }
    return self;
}


#pragma mark - 数据源方法只有在单独自己用的时候生效
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    if (self.cellClassNames.count > 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellClassNames.firstObject forIndexPath:indexPath];
    }else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HTCommonCollectionViewCell" forIndexPath:indexPath];
    }
    [self configureCell:cell atIndexPath:indexPath collectionView:collectionView];
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView {
    
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return self.layout;
//}


#pragma mark - Setter && Getter
- (void)setData:(NSMutableArray *)data {
    _data = data;
    [self reloadData];
}

@end
