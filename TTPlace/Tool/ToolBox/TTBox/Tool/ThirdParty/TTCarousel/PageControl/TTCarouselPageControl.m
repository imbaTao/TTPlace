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

- (instancetype)initWithPageCount:(NSInteger)pageCount controlSize:(CGSize)controlSize  itemSize:(CGSize)itemSize {
    self = [super initWithFrame:CGRectMake(0, 0, controlSize.width, controlSize.height)];
    if (self) {
        self.index = 0;
        self.itemSize = itemSize;
        self.numberOfPages = pageCount;
      
        self.layer.masksToBounds = true;
        self.userInteractionEnabled = false;
        
        [self creatItems];
    }
    return self;
}

- (void)creatItems {
    self.items = [NSMutableArray array];
    for (int i = 0; i < self.numberOfPages; i++) {
        UIImageView *item = [[UIImageView alloc] init];
        item.tag = 100 + i;
        item.backgroundColor = self.pageIndicatorTintColor;
        if (i == 0) {
            item.backgroundColor = self.currentPageIndicatorTintColor;
        }
        item.layer.cornerRadius = 0.75;
        [self addSubview:item];
        [self.items addObject:item];
    }
    
    CGFloat interval = 2.5;
    CGFloat w = (self.frame.size.width - (interval * (self.subviews.count - 1))) / self.subviews.count;
       CGFloat h = 1.5;
    
    // 修补间距
    CGFloat fixInterval = 0;
    // 如果宽度大于15
    if (w > 15) {
        w = 15;
        // 这是需要补的宽度
        fixInterval = (self.frame.size.width - (w * self.subviews.count + interval * (self.subviews.count - 1))) / 2;
    }

    [self.items mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:interval leadSpacing:fixInterval tailSpacing:fixInterval];
    [self.items mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.height.offset(h);
    }];
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
