//
//  HTCommonCollectionViewController.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/26.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCommonCollectionViewController.h"
#import "UICollectionView+HTCollectionView.h"

#import "NSObject+RACKVOWrapper.h"
#import "HTCommonCollectionView.h"

@interface HTCommonCollectionViewController ()

@end

@implementation HTCommonCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)p_setupMainView {
    self.collectionView = [[HTCommonCollectionView alloc] initWithFrame:CGRectZero layout:self.vm.flowLayout cellClassNames:self.vm.classNames delegateTarget:self];
    
    [self.view addSubview:self.collectionView];
    
    // layout
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    // 这里只是方便控制头部刷新,不会造成崩溃
    self.tableView = self.collectionView;
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.vm numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.vm itemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.vm.cellNames[0] forIndexPath:indexPath];
    
    // Configure the cell
    [self configureCell:cell atIndexPath:indexPath collectionView:collectionView];
    return cell;
}

- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView {
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.vm itemSize:indexPath];
}

#pragma mark - 头部大小
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}


// 创建一个继承collectionReusableView的类,用法类比tableViewcell
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    return reusableView;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end

