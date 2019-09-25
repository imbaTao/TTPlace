//
//  HTCycleView.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/30.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCycleView.h"




@implementation HTPageControl
- (void)setCurrentPage:(NSInteger)page {
    [super setCurrentPage:page];
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 4;
        size.width = 4;
        subview.layer.cornerRadius = 2;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
    }
}
@end

@interface HTCycleView()



/**
 是否自动循环
 */
@property(nonatomic, readwrite, assign)BOOL autoCycle;



/**
 轮播数量
 */
@property(nonatomic, readwrite, assign)NSInteger maxCycleCount;


/**
 CellID
 */
@property(nonatomic, readwrite, copy)NSString *cellID;



/**
 当前下标
 */
@property(nonatomic, readwrite, strong)NSIndexPath *currentIndexPath;


/**
 是否始终允许滚动
 */
@property(nonatomic, readwrite, assign)BOOL alwaysAllowScorllEnabel;

/**
 是否显示pageControl
 */
@property(nonatomic, readwrite, assign)BOOL showPageControl;

/**
 flowLayout
 */
@property(nonatomic, readwrite, strong)UICollectionViewFlowLayout *flowLayout;


/**
 滚动方向
 */
@property(nonatomic, readwrite, assign)UICollectionViewScrollDirection d;


/**
 是否在拖动
 */
@property(nonatomic, readwrite, assign)BOOL isDragging;






@end

@implementation HTCycleView

static NSInteger const RepeatMutiply = 10000;

- (instancetype)initWithFlowLayout:(UICollectionViewFlowLayout *)flowLayout pageEnabled:(BOOL)pageEnabled cellClassName:(NSString *)cellClassName autoCyle:(BOOL)autoCyle itemCountInOnePage:(NSInteger)itemCountInOnePage pageBottomOffSet:(CGFloat)pageBottomOffSet alwaysAllowScorllEnabel:(BOOL)alwaysAllowScorllEnabel showPageControl:(BOOL)showPageControl scrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    self = [super init];
    if (self) {
        self.autoCycle = autoCyle;
        self.cellID = cellClassName;
        self.itemCountInOnePage = itemCountInOnePage;
        self.alwaysAllowScorllEnabel = alwaysAllowScorllEnabel;
        self.showPageControl = showPageControl;
        
        self.d = scrollDirection;
        self.autoCycle = true;
        

        // setupUI
        self.cycleBoard = [UICollectionView creatWithFlowLayout:flowLayout classString:cellClassName];
        self.cycleBoard.delegate = self;
        self.cycleBoard.dataSource = self;
        self.cycleBoard.pagingEnabled = pageEnabled;
        if (!alwaysAllowScorllEnabel) {
             self.cycleBoard.scrollEnabled = false;
        }
        
        [self addSubview:self.cycleBoard];
        [self.cycleBoard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(0);
            make.right.offset(0);
            make.bottom.offset(-pageBottomOffSet);
        }];
        
        
        // 如果自动轮循
        [RACObserve(self, autoCycle) subscribeNext:^(id  _Nullable x) {
            // 先停止上一个
//            [self timerStop];
            
            if (self.autoCycle) {
                @weakify(self);
                // 创建一个定时器专门控制服务器时间
                [[[RACSignal interval:3.0 onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:[self rac_signalForSelector:@selector(timerStop)]] subscribeNext:^(NSDate * _Nullable x) {
                    @strongify(self);
                    
                    // 不处于拉拽状态就可以自动滚动
                    if (!self.isDragging) {
                        NSInteger section =  self.currentIndexPath.section + 1;
                        if (section > self.data.count * RepeatMutiply * self.itemCountInOnePage - 1) {
                            section =  self.currentIndexPath.section;
                        }
                    
                    // 展示当前页
                        self.currentIndexPath = [NSIndexPath indexPathForRow:self.itemCountInOnePage - 1 inSection:section];
                
                    
                        if (self.data.count > 0) {
                            
                            [self p_scrollToCurrentIndexPathAnimated:true];
                            
//                            [self.cycleBoard scrollToItemAtIndexPath:self.currentIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:true];
                        }
                    }
                }];
            }else {
                [self timerStop];
            }
        }];
    }
    return self;
}


- (void)p_scrollToCurrentIndexPathAnimated:(BOOL)animated {
    
    // 水平滑动
    if (self.d == UICollectionViewScrollDirectionHorizontal) {
        // 计算偏移量
        CGFloat offsetX = self.currentIndexPath.section * self.cycleBoard.frame.size.width;
        [self.cycleBoard setContentOffset:CGPointMake(offsetX, 0) animated:animated];
    }else {
        // 纵向滑动
        CGFloat offsetY = self.currentIndexPath.section * self.cycleBoard.frame.size.height;
        [self.cycleBoard setContentOffset:CGPointMake(0, offsetY) animated:animated];
    }
    
    // 如果现实pageControl
    if (self.showPageControl) {
        self.pageControl.currentPage = self.currentIndexPath.section % RepeatMutiply % self.data.count;
    }
}

- (void)timerStop {
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellID forIndexPath:indexPath];
    NSIndexPath *tempIndex = [self realDataIndexPath:indexPath];
    [self configCell:cell indexPath:tempIndex collectionView:collectionView];
    return cell;
}

- (void)configCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath collectionView:(id)collectionView {
    // 如果是空组，则隐藏那个cell
    if ([self.data[indexPath.section][indexPath.row] isKindOfClass:[NSString class]]) {
        cell.hidden = true;
    }else {
        // 取出模型
        cell.hidden = false;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.data.count * self.itemCountInOnePage * RepeatMutiply;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *dataArray = self.data[section % self.data.count % self.itemCountInOnePage];
    if (dataArray.count >= self.itemCountInOnePage) {
          return self.itemCountInOnePage;
    }else {
        return dataArray.count;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSIndexPath *)realDataIndexPath:(NSIndexPath *)sourceIndexPath {
    return [NSIndexPath indexPathForRow:sourceIndexPath.row inSection:sourceIndexPath.section % RepeatMutiply % self.data.count];
}




//设置每个item的尺寸
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(90, 130);
//}

//header的size
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(0, 40);
//}

//设置每个item的UIEdgeInsets
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 15, 0, 15);
//}

////设置每个item水平间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}
//
//
////设置每个item垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 15;
//}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
//#pragma mark -- 返回头视图
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusableView = nil;
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        HomeCollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"offlineID" forIndexPath:indexPath];
//        header.headeLab.text = [dict objectForSafeKey:@"组头"];
//        reusableView = header;
//    }
//    //如果是头视图
//    return reusableView;
//}

#pragma mark - 滚动代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
     self.isDragging = true;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging &&    !scrollView.decelerating;
    if (scrollToScrollStop) {
        [self scrollViewDidEndScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        // 停止类型3
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            [self scrollViewDidEndScroll];
        }
    }
}

- (void)scrollViewDidEndScroll {
    // 将collectionView在控制器view的中心点转化成collectionView上的坐标
    CGPoint pInView = [self.cycleBoard.superview convertPoint:self.cycleBoard.center toView:self.cycleBoard];
    
    // 获取这一点的indexPath
    NSIndexPath *indexPath = [self.cycleBoard indexPathForItemAtPoint:pInView];
    
    if (self.showPageControl) {
        self.pageControl.currentPage = indexPath.section % RepeatMutiply % self.data.count;
    }
    
    // 标记拖拽状态为false，记录拖拽完的下标
    self.isDragging = false;
    self.currentIndexPath = indexPath;
}


- (CGFloat)fetchCycleViewHeight {
    return self.flowLayout.itemSize.height * self.itemCountInOnePage;
}

#pragma mark - Setter && Getter
- (void)setData:(NSArray *)data {
    _data = data;
    
    // 当组数小于
    if (data.count <= self.itemCountInOnePage) {
        self.autoCycle = false;
        
        // 始终允许滚动后，也需要通过数量来限制滚动
        if (self.alwaysAllowScorllEnabel) {
            self.cycleBoard.scrollEnabled = data.count <= 1 ? false : true;
        }
    }
    
    
    // 子线程处理数据
    dispatch_async(dispatch_queue_create("sub", DISPATCH_QUEUE_CONCURRENT), ^{
        [self dataProcessing:self.data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
             [self layoutIfNeeded];
            
            // 回主线程刷新
//            [self.cycleBoard reloadData];
            
            
           
            // 滚动到中间位置
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
                self.currentIndexPath = [NSIndexPath indexPathForRow:self.itemCountInOnePage - 1 inSection:self.data.count * self.itemCountInOnePage * RepeatMutiply * 0.5];
            
                // 如果要显示pageControl
                if (self.showPageControl) {
                    self.pageControl.numberOfPages = self.maxCycleCount = self.data.count;
                    
                    self.pageControl.currentPage = self.currentIndexPath.section % RepeatMutiply % self.data.count;
                }
            
                [self p_scrollToCurrentIndexPathAnimated:false];
            
//                UICollectionViewLayoutAttributes *attributes = [self.cycleBoard layoutAttributesForItemAtIndexPath:self.currentIndexPath];
//
//                CGRect rect = attributes.frame;
//
//                [self.cycleBoard setContentOffset:CGPointMake(self.cycleBoard.frame.origin.x, rect.origin.y) animated:YES];

            
            
            
//                [self.cycleBoard scrollToItemAtIndexPath:self.currentIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:false];
//            });
        });
    });
}


// 数据加工
- (void)dataProcessing:(NSArray *)data {
    // 这里是吧数据分个组，每组三个
    NSMutableArray *tempGoup = [NSMutableArray array];
    for (int i = 0; i < data.count; i++) {
        if (i % self.itemCountInOnePage == 0) {
            NSMutableArray *subGoup = [NSMutableArray array];
            if (i + self.itemCountInOnePage - 1 < data.count - 1) {
                [subGoup addObjectsFromArray:[data subarrayWithRange:NSMakeRange(i, self.itemCountInOnePage)]];
            }else {
                [subGoup addObjectsFromArray:[data subarrayWithRange:NSMakeRange(i, data.count - i)]];
                for (NSInteger i = subGoup.count; i < self.itemCountInOnePage; i++) {
                    [subGoup addObject:@"empty"];
                    if (subGoup.count == self.itemCountInOnePage) {
                        break;
                    }
                }
            }
            [tempGoup addObject:subGoup];
        }
    }
    _data = tempGoup;
}

- (HTPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[HTPageControl alloc] init];
        _pageControl.userInteractionEnabled = false; _pageControl.currentPageIndicatorTintColor = rgba(222, 49, 33, 1);
        _pageControl.pageIndicatorTintColor = rgba(221, 221, 221, 1);
        [self addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.bottom.offset(0);
            make.height.offset(30);
        }];
    }
    return _pageControl;
}

- (NSInteger)maxCycleCount {
    if (!_maxCycleCount) {
        _maxCycleCount = 1;
    }
    return _maxCycleCount;
}
@end
