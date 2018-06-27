//
//  HZYTabbarController.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/27.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "HZYTabbarController.h"
#import "HomeViewController.h"
#import "BaseNavigationController.h"
@interface HZYTabbarButton : UIControl
/** buttonImgView */
@property(nonatomic,strong)UIImageView *buttonImgView;

/** buttonImgView */
@property(nonatomic,strong)UIImageView *backGroundImgView;

/** buttonTitleLable */
@property(nonatomic,strong)UILabel *buttonTitleLable;
@end

@implementation HZYTabbarButton
- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.backGroundImgView];
        [self addSubview:self.buttonImgView];
        [self addSubview:self.buttonTitleLable];
        [self layoutPageViews];
    }
    return self;
}

- (void)layoutPageViews{
    [self.backGroundImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.buttonImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.center.mas_equalTo(self).centerOffset(CGPointMake(0, -5));
    }];
    
    [self.buttonTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buttonImgView.mas_bottom);
        make.left.offset(0);
        make.bottom.offset(0);
        make.right.offset(0);
    }];
}

#pragma mark - Setter && Getter
- (UIImageView *)buttonImgView{
    if (!_buttonImgView) {
        _buttonImgView = [[UIImageView alloc] init];
    }
    return _buttonImgView;
}

- (UIImageView *)backGroundImgView{
    if (!_backGroundImgView) {
        _backGroundImgView = [[UIImageView alloc] init];
    }
    return _backGroundImgView;
}

- (UILabel *)buttonTitleLable{
    if (!_buttonTitleLable) {
        _buttonTitleLable = [UILabel creatLabelWithText:nil textColor:[UIColor grayColor] fontSize:9];
    }
    return _buttonTitleLable;
}
@end



@interface HZYTabbarController ()
/** seletedImageArray */
@property(nonatomic,strong)NSArray *seletedImageArray;

/** UnseletedImageArray */
@property(nonatomic,strong)NSArray *unseletedImageArray;
@end


@implementation HZYTabbarController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_initSubVC];
    [self p_initCostomTabbar];
}

#pragma mark - Reseponse
- (void)barBtnClickAction:(UIButton *)sender{
    // last unselected
    HZYTabbarButton *lastBtn = [self.view viewWithTag:100 + self.selectedIndex];
    lastBtn.buttonImgView.image = [UIImage imageNamed:self.unseletedImageArray[self.selectedIndex]];
    lastBtn.buttonTitleLable.textColor = [UIColor grayColor];

    
    
    // current selected
    self.selectedIndex = sender.tag - 100;
    HZYTabbarButton *currentBtn = [self.view viewWithTag:sender.tag];
    currentBtn.buttonImgView.image = [UIImage imageNamed:self.seletedImageArray[self.selectedIndex]];
    lastBtn.buttonTitleLable.textColor = [UIColor blackColor];
}

#pragma mark - private
- (void)p_initSubVC{
    HomeViewController *vc1 = [[HomeViewController alloc] init];
    vc1.title = @"1控制器";
    BaseNavigationController *nav1 = [[BaseNavigationController alloc] initWithRootViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    BaseNavigationController *nav2 = [[BaseNavigationController alloc] initWithRootViewController:vc2];
    vc2.view.backgroundColor = [UIColor redColor];
    
    [vc2.navigationItem setTitle:@"2控制器"];
    vc2.title = @"2控制器";
    UIViewController *vc3 = [[UIViewController alloc] init];
    BaseNavigationController *nav3 = [[BaseNavigationController alloc] initWithRootViewController:vc3];
    vc3.view.backgroundColor = [UIColor grayColor];
    vc3.title = @"3控制器";
    NSArray *subVCArr = @[nav1,nav2,nav3];
    for (int i = 0; i < subVCArr.count; i++) {
        [self addChildViewController:subVCArr[i]];
    }
}

- (void)p_initCostomTabbar{
    NSArray *titleNameArray = @[@"第一页",@"第二页",@"第三页"];
    for (int i = 0; i < titleNameArray.count; i++) {
        HZYTabbarButton *barButton = [[HZYTabbarButton alloc]
                                      init];
        barButton.tag = 100 + i;
        barButton.buttonImgView.image = [UIImage imageNamed:self.unseletedImageArray[i]];
        barButton.buttonTitleLable.textColor = [UIColor grayColor];
        barButton.buttonTitleLable.text = titleNameArray[i];
        if (i == 0) {// first select
            barButton.buttonImgView.image = [UIImage imageNamed:self.seletedImageArray[i]];
            barButton.buttonTitleLable.textColor = [UIColor blackColor];
        }
        [barButton addTarget:self action:@selector(barBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.customBar addSubview:barButton];
        [barButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(0);
            make.left.offset(i * SCREEN_W / titleNameArray.count);
            make.bottom.offset(0);
            make.width.offset(SCREEN_W / titleNameArray.count);
        }];
    }
}

#pragma mark - Setter && Getter
- (NSArray *)seletedImageArray{
    if (!_seletedImageArray) {
        _seletedImageArray = @[@"Home_selected",@"Discover_selected",@"Person_selected"];
    }
    return _seletedImageArray;
}

- (NSArray *)unseletedImageArray{
    if (!_unseletedImageArray) {
        _unseletedImageArray = @[@"Home_unselected",@"Discover_unselected",@"Person_unselected"];
    }
    return _unseletedImageArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
