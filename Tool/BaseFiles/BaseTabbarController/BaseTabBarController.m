//
//  BaseTabBarController.m
//  HTToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HT. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseTabbarView.h"
@interface BaseTabBarController ()<BaseTabbarViewDelegate>
/** tabbarView */
@property(nonatomic,strong)BaseTabbarView *customBar;

/** isDisplayTabbar */
@property(nonatomic,assign)BOOL isDisplayTabbar;
@end

#define BarHeight 49
@implementation BaseTabBarController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isDisplayTabbar = true;
    [self.tabBar removeFromSuperview];
    [self.tabBar setHidden:YES];
    self.tabBar.userInteractionEnabled = false;
    [self.view addSubview:self.customBar];
    [self.customBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.height.offset(49);
        make.left.offset(0);
        make.right.offset(0);
    }];
}



#pragma mark - BarViewDelegate
- (void)changeBarIndexWithIndex:(NSInteger)index{
    self.selectedIndex = index;
}

- (BaseTabbarView *)customBar{
    if (!_customBar) {
        _customBar = [[BaseTabbarView alloc] init];
        _customBar.delegate = self;
    }
    return _customBar;
}

#pragma mark - private
- (void)showTabbar{
     if (!self.isDisplayTabbar) {
         [UIView animateWithDuration:0.5 animations:^{
             [self.customBar mas_remakeConstraints:^(MASConstraintMaker *make) {
                 make.bottom.offset(0);
                 make.height.offset(49);
                 make.left.offset(0);
                 make.right.offset(0);
             }];
             [self.view layoutIfNeeded];
         }completion:^(BOOL finished) {
             self.isDisplayTabbar = true;
         }];
     }
}

- (void)hiddeTabbar{
    if (self.isDisplayTabbar) {
        [UIView animateWithDuration:0.5 animations:^{
            [self.customBar mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.offset(BarHeight);
                make.height.offset(49);
                make.left.offset(0);
                make.right.offset(0);
            }];
            [self.view layoutIfNeeded];
        }completion:^(BOOL finished) {
            self.isDisplayTabbar = false;
        }];
    }
}

- (BOOL)isDisplayedInScreen{
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect intersectionRect = CGRectIntersection(self.customBar.frame, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    return TRUE;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end

