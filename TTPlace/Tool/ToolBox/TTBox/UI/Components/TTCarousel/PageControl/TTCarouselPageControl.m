//
//  TTCarouselPageControl.m
//  testC
//
//  Created by Mr.hong on 2021/1/4.
//

#import "TTCarouselPageControl.h"
#import "Masonry.h"
@interface TTCarouselPageControl()
/**
 size
 */
@property(nonatomic, readwrite, assign)CGSize itemSize;

/**
 items
 */
@property(nonatomic, readwrite, strong)NSMutableArray *items;

/**
 当前下标
 */
@property(nonatomic, readwrite, assign)NSInteger index;
@end

@implementation TTCarouselPageControl

- (instancetype)initWithPageCount:(NSInteger)pageCount  itemSize:(CGSize)itemSize spacing:(CGFloat)spacing {
    self = [super initWithFrame: CGRectZero];
    if (self) {
        // 如何排列的
        self.axis = UILayoutConstraintAxisHorizontal;
        self.distribution = UIStackViewDistributionEqualSpacing;
//        self.alignment =
        self.spacing = spacing;
        
        
        self.index = 0;
        self.itemSize = itemSize;
   
      
        self.layer.masksToBounds = true;
        self.userInteractionEnabled = false;
        
        self.numberOfPages = pageCount;
    }
    return self;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    [self creatItems];
}

- (void)creatItems {
    for (UIImageView *item in self.items) {
        [item removeFromSuperview];
    }
    
    // 如果没有页码数，那么就不显示
    if (self.numberOfPages <= 1) {
        return;
    }
    
    self.items = [NSMutableArray array];
    for (int i = 0; i < self.numberOfPages; i++) {
        UIImageView *item = [[UIImageView alloc] init];
      
        item.tag = 100 + i;
        item.backgroundColor = self.pageIndicatorTintColor;
        if (i == 0) {
            item.backgroundColor = self.currentPageIndicatorTintColor;
        }
    
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.itemSize);
        }];
        item.layer.cornerRadius = self.itemSize.height / 2.0;
        [self.items addObject:item];
        [self addArrangedSubview:item];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 默认选中首个下标
    [self refreshIndicatorWithCurrentIndex:self.index];
}


// 刷新指示器下标
- (void)refreshIndicatorWithCurrentIndex:(NSInteger)index {
    for (UIView *item in self.items) {
        if (item.tag - 100 == index) {
            
            NSLog(@"1");
            item.backgroundColor = self.currentPageIndicatorTintColor;
        }else {
            NSLog(@"2");
            item.backgroundColor = self.pageIndicatorTintColor;
        }
    }
}

@end
