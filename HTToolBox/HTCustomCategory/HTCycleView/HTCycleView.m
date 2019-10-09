//
//  HTCycleView.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/30.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTCycleView.h"
#import "HTPageControl.h"

@interface HTCycleView()

/**
 轮播面板
 */
@property(nonatomic, readwrite, strong)UICollectionView *cycleBoard;

/**
 指示器
 */
@property(nonatomic, readwrite, strong)HTPageControl *pageControl;




@end

@implementation HTCycleView


// 重复组数的倍数
static NSInteger const RepeatMutiply = 2000;

// 滚动时间间隔
static NSInteger const ScrollInterval = 3;

- (instancetype)initWithConfigModel:(HTCycleViewConfigModel *)configModel
{
    self = [super init];
    if (self) {
        self.configModel = configModel;
        
        // setupUI
        self.cycleBoard = [UICollectionView creatWithFlowLayout:configModel.flowLayout classString:configModel.cellClassName];
        self.cycleBoard.delegate = self;
        self.cycleBoard.dataSource = self;
        self.cycleBoard.pagingEnabled = configModel.pageEnabled;
        self.cycleBoard.scrollEnabled = configModel.allowScorllEnabel;
        [self addSubview:self.cycleBoard];
        
        // layout
        [self.cycleBoard mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(0);
            make.right.offset(0);
            make.bottom.offset(0);
        }];
        
        // rac
        [self racConfig];
    }
    return self;
}

- (void)racConfig {
    @weakify(self);
    // 如果自动轮循
    [RACObserve(self.configModel, autoCycle) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        // 如果允许自动滚动
        if (self.configModel.autoCycle) {
            // 创建一个定时器专门控制服务器时间
            [[[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:[self rac_signalForSelector:@selector(timerStop)]] subscribeNext:^(NSDate * _Nullable x) {
                @strongify(self);
                
                // 不处于拉拽状态就允许自动滚动
                if (!self.configModel.isDragging && self.window != nil) {
                    
                    // 每秒时间加一秒,取模时间间隔为0时触发滚动
                    self.configModel.workingTime++;
                    
                    // 到达滚动周期了就滚动
                    if (self.configModel.workingTime % self.configModel.scrollInterval == 0) {
                        [self scrollToNextPage];
                    }
                }else {
                    // 处于不可滚动状态，重新倒计时
                    self.configModel.workingTime = 0;
                }
            }];
        }else {
            // 如果不允许自动滚动了，那么就停止定时器
            [self timerStop];
        }
    }];
}


#pragma mark - Method
// 往后滚动一页
- (void)scrollToNextPage {
    // 如果有数据才滚动
    if (self.data.count > 0) {
        // 检测下标
        if ([self checkCurrentPageIndexPath]) {
            
            // 下一页
            NSInteger nextSection =  self.configModel.currentIndexPath.section + 1;

            // 变动当前页下标
            self.configModel.currentIndexPath = [NSIndexPath indexPathForRow:self.configModel.itemCountInOnePage - 1 inSection:nextSection];
            [self p_scrollToCurrentIndexPathAnimated:true];
        }
    }
    self.configModel.workingTime = 0;
}

// 监测当前下标
- (BOOL)checkCurrentPageIndexPath {
    // 最大页数下标 = 数组中的个数 * 倍数 * 每页的数量 - 1
    NSInteger maxSecion = self.data.count * self.configModel.repeatMutiply * self.configModel.itemCountInOnePage - 1;
    
    // 下标为0或者等于最大组数了滚动回原点
    if (self.configModel.currentIndexPath.section == 0 || self.configModel.currentIndexPath.section == maxSecion) {
        [self scrollToOrigin];
        return false;
    }else {
        return true;
    }
}

// 滚动回原点
- (void)scrollToOrigin {
    // 初始下标,位于所有组数的中间一组,row是组元素中最后一个元素，section是中间section
    self.configModel.currentIndexPath = [NSIndexPath indexPathForRow:self.configModel.itemCountInOnePage - 1 inSection:self.data.count * self.configModel.itemCountInOnePage * self.configModel.repeatMutiply * 0.5];
    
    // 如果要显示pageControl
    [self p_scrollToCurrentIndexPathAnimated:false];
}

// 对外部提供注入数据的方法,子类复写
- (void)injectData:(NSArray<NSString *> *)data {
    
}

// 根据下标获取对应数据源
- (id)fetchDataWithIndexPath:(NSIndexPath *)indexPath {
    if (self.configModel.itemCountInOnePage > 1) {
        return self.data[indexPath.section][indexPath.row];
    }else{
        return self.data[indexPath.section];
    }
}

#pragma mark - DataSource && Delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.configModel.cellClassName forIndexPath:indexPath];
    NSIndexPath *tempIndex = [self realDataIndexPath:indexPath];
    // 如果每页的数量
    if (self.configModel.itemCountInOnePage > 1) {
        // 如果是空组，则隐藏那个cell并直接返回
        if ([self.data[tempIndex.section][tempIndex.row] isKindOfClass:[NSString class]]) {
            cell.hidden = true;
            return cell;
        }else {
            // 取出模型
            cell.hidden = false;
            [self configCell:cell indexPath:tempIndex collectionView:collectionView];
        }
    }else {
        [self configCell:cell indexPath:tempIndex collectionView:collectionView];
    }
    return cell;
}

- (void)configCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath collectionView:(id)collectionView {
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.data.count * self.configModel.itemCountInOnePage * self.configModel.repeatMutiply;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id firstData = self.data.firstObject;
    // 如果每页的数量大于0，那么要判断第一个元素是否是数组
    if (self.configModel.itemCountInOnePage > 1) {
        if ([firstData isKindOfClass:[NSArray class]]) {
            return self.configModel.itemCountInOnePage;
        }else {
            @throw [NSException exceptionWithName:@"HTCyleView 类抛出的异常" reason:@"当每页数据大于一个的时候,数据源中的元素必须是数组类型" userInfo:nil];
            return 0;
        }
    }else {
    // 单页返回数组的数量
        return 1;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 点击后初始化运行时间，避免点击的时候页面变了
    self.configModel.workingTime = 0;
    if ([self.delegate respondsToSelector:@selector(pageDidSelected:data:)]) {
        NSIndexPath *realIndexPath = [self realDataIndexPath:indexPath];
        if (self.configModel.itemCountInOnePage > 1) {
             [self.delegate pageDidSelected:realIndexPath data:self.data[realIndexPath.section][realIndexPath.row]];
        }else {
             [self.delegate pageDidSelected:realIndexPath data:self.data[realIndexPath.section]];
        }
    }
}

#pragma mark - 滚动代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
     self.configModel.isDragging = true;
    self.configModel.workingTime = 0;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.configModel.workingTime = 0;
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        [self scrollViewDidEndScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.configModel.workingTime = 0;
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
    
    if (self.configModel.showPageControl) {
        self.pageControl.currentPage = indexPath.section % self.configModel.repeatMutiply % self.data.count;
    }
    
    // 标记拖拽状态为false，记录拖拽完的下标
    self.configModel.isDragging = false;
    self.configModel.currentIndexPath = indexPath;
    
    [self checkCurrentPageIndexPath];
}

#pragma mark - private
// 私有方法滚动到当前下标
- (void)p_scrollToCurrentIndexPathAnimated:(BOOL)animated {
    // 水平滑动
    if (self.configModel.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        // 计算偏移量
        CGFloat offsetX = self.configModel.currentIndexPath.section * self.cycleBoard.frame.size.width;
        [self.cycleBoard setContentOffset:CGPointMake(offsetX, 0) animated:animated];
    }else {
        // 纵向滑动
        CGFloat offsetY = self.configModel.currentIndexPath.section * self.cycleBoard.frame.size.height;
        [self.cycleBoard setContentOffset:CGPointMake(0, offsetY) animated:animated];
    }
    
    // 如果显示pageControll，那么改变currentPage
    if (self.configModel.showPageControl) {
        self.pageControl.currentPage = self.configModel.currentIndexPath.section % self.configModel.repeatMutiply % self.data.count;
    }
}

// 停止定时器
- (void)timerStop {
    
}

// 计算后得到真实准确的下标
- (NSIndexPath *)realDataIndexPath:(NSIndexPath *)sourceIndexPath {
    return [NSIndexPath indexPathForRow:sourceIndexPath.row inSection:sourceIndexPath.section % self.configModel.repeatMutiply % self.data.count];
}

// 获取滚动视图整个的的高度（一般是给纵向滚动的视图用）
- (CGFloat)fetchCycleViewHeight {
    return self.configModel.flowLayout.itemSize.height * self.configModel.itemCountInOnePage;
}

#pragma mark - Setter && Getter
- (void)setData:(NSArray *)data {
    _data = data;
    
    // 当组数量小于一页之中的显示数量自动滚动置为false
    if (data.count <= self.configModel.itemCountInOnePage) {
        self.configModel.autoCycle = false;
        self.pageControl.hidden = true;
        
        // 始终允许滚动后，也需要通过数量来限制滚动
        if (self.configModel.allowScorllEnabel) {
            self.cycleBoard.scrollEnabled = data.count > self.configModel.itemCountInOnePage ? true : false;
        }
    }
    
    // 如果一页数据大于1个
    if (self.configModel.itemCountInOnePage > 1) {
        // 子线程处理数据
        dispatch_async(dispatch_queue_create("sub", DISPATCH_QUEUE_CONCURRENT), ^{
            [self dataProcessing:self.data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dataRefresh];
            });
        });
    }else {
        [self dataRefresh];
    }
}


// 数据加工
- (void)dataProcessing:(NSArray *)data {
    // 这里是吧数据分个组，每组三个
    NSMutableArray *tempGoup = [NSMutableArray array];
    for (int i = 0; i < data.count; i++) {
        if (i % self.configModel.itemCountInOnePage == 0) {
            NSMutableArray *subGoup = [NSMutableArray arrayWithCapacity:self.configModel.itemCountInOnePage];
            if (i + self.configModel.itemCountInOnePage - 1 < data.count - 1) {
                [subGoup addObjectsFromArray:[data subarrayWithRange:NSMakeRange(i, self.configModel.itemCountInOnePage)]];
            }else {
                [subGoup addObjectsFromArray:[data subarrayWithRange:NSMakeRange(i, data.count - i)]];
                for (NSInteger i = subGoup.count; i < self.configModel.itemCountInOnePage; i++) {
                    [subGoup addObject:@"empty"];
                    if (subGoup.count == self.configModel.itemCountInOnePage) {
                        break;
                    }
                }
            }
            [tempGoup addObject:subGoup];
        }
    }
    _data = tempGoup;
}

- (void)dataRefresh {
    // 需要先layout不然显示不对
    [self layoutIfNeeded];
    
    // 初始的一个下标
    self.configModel.currentIndexPath = [NSIndexPath indexPathForRow:self.configModel.itemCountInOnePage - 1 inSection:self.data.count * self.configModel.itemCountInOnePage * self.configModel.repeatMutiply * 0.5];
    

    // 如果要显示pageControl
    if (self.configModel.showPageControl) {
        self.pageControl.numberOfPages =  self.data.count;
        self.pageControl.currentPage = self.configModel.currentIndexPath.section % self.configModel.repeatMutiply % self.data.count;
    }
    
    [self p_scrollToCurrentIndexPathAnimated:false];
    [self.cycleBoard reloadData];
}

#pragma mark - Setter && Getter
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

@end
