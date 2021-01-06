//
//  TTCarouselPageControl.h
//  testC
//
//  Created by Mr.hong on 2021/1/4.
//

#import "TTCarousel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTCarouselPageControl : UIView

@property(nonatomic, readwrite, assign)NSInteger currentPage;
@property(nonatomic, readwrite, assign)NSInteger numberOfPages;
@property(nonatomic, readwrite, strong)UIColor *pageIndicatorTintColor;
@property(nonatomic, readwrite, strong)UIColor *currentPageIndicatorTintColor;


- (instancetype)initWithPageCount:(NSInteger)pageCount controlSize:(CGSize)controlSize  itemSize:(CGSize)itemSize;



// 刷新指示器下标
- (void)refreshIndicatorWithCurrentIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
