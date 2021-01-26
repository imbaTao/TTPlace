//
//  TTCarousel.m
//  iCarouselExample
//
//  Created by Mr.hong on 2021/1/4.
//

#import "TTCarousel.h"
#import "UIImageView+WebCache.h"
#import "TTCarouselPageControl.h"


@interface TTCarousel()<iCarouselDataSource,iCarouselDelegate>

/**
 itemSize
 */
@property(nonatomic, readwrite, assign)CGSize itemSize;

@end

@implementation TTCarousel


// 初始化添加pageControll
- (instancetype)initWithItems:(NSArray *)items itemSize:(CGSize)itemSize
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.layer.masksToBounds = true;
        
        self.items = [items mutableCopy];
        self.itemSize = itemSize;
        
        self.dataSource = self;
        self.delegate = self;
        
        
//        TTCarouselPageControl *pageControl = [[TTCarouselPageControl alloc] initWithPageCount:items.count itemSize:CGSizeMake(5, 5)];
//        pageControl.backgroundColor = [UIColor redColor];
//        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
//        pageControl.pageIndicatorTintColor = [UIColor grayColor];
//        [self addSubview:pageControl];
//        pageControl.type = iCarouselTypeLinear;
//        [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(carousel1.mas_bottom);
//            make.left.right.equalTo(carousel1);
//            make.height.offset(20);
//        }];
        
        
//        self.pageControl = [[TTCarousel alloc] init];
//        self.pageControl.hidden = true;
//        self.pageControl.currentPage = 0;
//        self.pageControl.numberOfPages = 3;
//        self.pageControl.pageIndicatorTintColor = [UIColor redColor];
//        self.pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
//        [self addSubview:self.pageControl];
        
        
        
        
        // layout
//        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.offset(0);
//            make.center.mas_equalTo(self);
//            make.bottom.offset(0);
//            make.height.offset(20);
//        }];
        
        
        
        
        
        
        
        
        [self reloadData];
    }
    return self;
}

#pragma mark - delegate



- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return (NSInteger)self.items.count;
}



- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    UIView *_view;
    if (view == nil) {
        _view = [[UIView alloc] init];
        _view.frame = CGRectMake(0, 0, self.itemSize.width, self.itemSize.height);
        UIImageView *imageView = [[UIImageView alloc] init];
        [_view addSubview:imageView];
        imageView.frame = view.frame;
          
        // 图片加载
        NSString *urlStr = self.items[index];
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    }else {
        _view = view;
    }
    return _view;
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value;
        }
        case iCarouselOptionFadeMax:
        {
//            if (self.carousel.type == iCarouselTypeCustom)
//            {
//                //set opacity based on distance from camera
//                return 0.0;
//            }
//            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
//    NSNumber *item = (self.items)[(NSUInteger)index];
    
//    NSLog(@"Tapped view number: %@", item);
    
    
    self.itemDidSelected(index);
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    NSLog(@"Index: %@", @(self.currentItemIndex));
//    self.indexDidChange(self.currentItemIndex);
    
//    self.pageControl.currentPage = self.currentItemIndex;
}

- (void)carouselDidEndDecelerating:(iCarousel *)carousel {
    NSLog(@"333");
    self.indexDidChange(carousel.currentItemIndex);
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel {
    NSLog(@"2222");
    self.indexDidChange(carousel.currentItemIndex);
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate {
    self.indexDidChange(carousel.currentItemIndex);
    NSLog(@"1111");
}



@end
