//
//  TTCarousel.h
//  iCarouselExample
//
//  Created by Mr.hong on 2021/1/4.
//

#import "iCarousel.h"
#import "TTCarouselPageControl.h"
NS_ASSUME_NONNULL_BEGIN

@interface TTCarousel : iCarousel

/**
 当前下标改变block
 */
@property(nonatomic, readwrite, copy)void(^indexDidChange)(NSInteger index);

/**
 选中当前下标block
 */
@property(nonatomic, readwrite, copy)void(^itemDidSelected)(NSInteger index);


/**
 轮播图数据源
 */
@property(nonatomic, readwrite, strong)NSMutableArray <NSString *>*items;



/**
 自定义的pageControl
 */
//@property(nonatomic, readwrite, strong)UIPageControl *pageControl;

- (instancetype)initWithItems:(NSArray *)items itemSize:(CGSize)itemSize;

@end

NS_ASSUME_NONNULL_END
