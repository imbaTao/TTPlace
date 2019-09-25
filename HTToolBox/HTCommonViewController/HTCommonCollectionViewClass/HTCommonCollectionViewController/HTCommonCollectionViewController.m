//
//  HTCommonCollectionViewController.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/26.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCommonCollectionViewController.h"
#import "UICollectionView+HTCollectionView.h"

#import "HTCommonCollectionViewModel.h"
#import "NSObject+RACKVOWrapper.h"

@interface HTCommonCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>


/**
 vm
 */
@property(nonatomic, readwrite, strong)HTCommonCollectionViewModel *vm;

@end

@implementation HTCommonCollectionViewController
@synthesize  vm = _vm;
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)p_setupMainView {
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.vm.flowLayout];
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.collectionView.showsVerticalScrollIndicator = false;
    
    // 注册cell
    for (NSString *cellName in self.vm.cellNames) {
         [self.collectionView registerClass:NSClassFromString(cellName) forCellWithReuseIdentifier:cellName];
    }
    
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
