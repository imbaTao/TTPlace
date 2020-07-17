//
//  YNFormAboutInfoDetailController.m
//  HTPlace
//
//  Created by Mr.hong on 2020/7/9.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "YNFormAboutInfoDetailController.h"

@interface YNFormAboutInfoDetailController ()<UIScrollViewDelegate>
/**
 imageView
 */
@property(nonatomic, readwrite, strong)UIImageView *imageView;

@end

@implementation YNFormAboutInfoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#if DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(hotReload) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    });
#endif
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 84, SCREEN_W, SCREEN_W)];
    scrollView.contentSize = CGSizeMake(SCREEN_W, SCREEN_H);
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.zoomScale = 1;
    scrollView.minimumZoomScale = 0.5;
    scrollView.maximumZoomScale = 2;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    
    UIImage *image = [UIImage imageNamed:@"1"];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_W * image.size.height / image.size.width)];
    self.imageView.image  = image;
    self.imageView.contentMode =  UIViewContentModeScaleAspectFill;
    [scrollView addSubview:self.imageView];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NSLog(@"%@ ---frame",NSStringFromCGRect(self.imageView.frame));
      CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentInset.left - scrollView.contentInset.right - scrollView.contentSize.width) * 0.5, 0.0);
      CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentInset.top - scrollView.contentInset.bottom - scrollView.contentSize.height) * 0.5, 0.0);
      
      self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                          scrollView.contentSize.height * 0.5 + offsetY);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

// 热刷新UI代码，不用可以注释掉，不调用
- (void)hotReload {
    [self removeAllViews:self.view];
    [self viewDidLoad];
}

// 热刷新UI代码，不用可以注释掉，不调用
- (void)removeAllViews:(UIView *)view {
    while (view.subviews.count) {
        UIView* child = view.subviews.lastObject;
        [child removeFromSuperview];
    }
}

@end
