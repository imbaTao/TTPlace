//
//  HomeViewController.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HZY. All rights reserved.
//
#pragma mark - VC
#import "HomeViewController.h"

#pragma mark - View
#import "HomeCollectionView.h"

#pragma mark - ExampleVC
#import "ShowExampleViewController.h"
#import "HZYBubbleVC.h"


#import "NSCodingLearnMethod.h"
#import <objc/runtime.h>
@interface HomeViewController ()<HomeCollectionViewDelegate>
/** HomeCollectionView */
@property(nonatomic,strong)HomeCollectionView *homeCollectionView;

/** tempView */
@property(nonatomic,strong)UIButton *tempView;

/** bubbleVC */
@property(nonatomic,strong)HZYBubbleVC *bubbleVC;
@end


@implementation HomeViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[HZYTabbarController share] showTabbar];
}

- (void)viewWillDisappear:(BOOL)animated{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_configNavi];
    [self.view addSubview:self.homeCollectionView];
    [self layoutPageViews];
    _homeCollectionView.rowOrCol = Row;
}




- (void)layoutPageViews{
    self.homeCollectionView.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    [self.homeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    

//    NSString *dateStr = @"2018-7-25";
//    NSDateFormatter *fomater = [[NSDateFormatter alloc] init];
//    fomater.dateFormat = @"yyyy-MM-dd";
//    fomater.timeZone =  [NSTimeZone defaultTimeZone];
//    [fomater dateFromString:dateStr];
    
    
//    self.tempView = [[UIButton alloc] initWithFrame:CGRectMake(200, 30, 50, 50)];
//    self.tempView.backgroundColor = [UIColor redColor];
//    [self.tempView addTarget:self action:@selector(bublleAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.tempView];
//    Method originalMethod = class_getClassMethod([NSString class], @selector(lowercaseString));
//    Method swappedMethod = class_getClassMethod([NSString class], @selector(uppercaseString));
//    method_exchangeImplementations(originalMethod, swappedMethod);
//
//    NSString *string = @"ThIs iS tHe StRiNg";
//    NSString *lowercaseString = [string lowercaseString];
//    NSLog(@"%@",lowercaseString);
//    NSString *uppercaseString = [string uppercaseString];
//    NSLog(@"%@",uppercaseString);
    
}


#pragma mark - HomeCollectionViewCellDelegate
- (void)homeCollectionViewCellSelected:(NSIndexPath *)indexPath{
//    ShowExampleViewController *vc = [[ShowExampleViewController alloc] initWithType:indexPath.row];
//    [self.navigationController pushViewController:vc animated:true];
//    _homeCollectionView.rowOrCol =  !_homeCollectionView.rowOrCol;
//    HomeCollectionViewCell *cell = (HomeCollectionViewCell *)[self.homeCollectionView cellForItemAtIndexPath:indexPath];
    
    
    self.bubbleVC = [[HZYBubbleVC alloc] initWithTitleArr:@[@"播放",@"重命名",@"删除"] picNameArr:@[@"Bubble_Play",@"Bubble_Rename",@"Bubble_Delete"] appointView:self.view width:SCREEN_W * 0.9 haveHeader:true];
    [self.bubbleVC showBubbleWithVC:self];
}



#pragma mark - Response
- (void)bublleAction{
    [self.bubbleVC showBubbleWithVC:self];
}

- (void)searchFiles{
    
}

- (void)menuAction{
    
}
#pragma mark - Setter && Getter
- (HomeCollectionView *)homeCollectionView{
    if (!_homeCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 4;
        layout.minimumInteritemSpacing = 4;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake((SCREEN_W - 60)  / 5, (SCREEN_W - 60) / 5);
        _homeCollectionView = [[HomeCollectionView alloc] initWithLayout:layout cellClass:[HomeCollectionViewCell class] identifier:@"CellID"];
        _homeCollectionView.cellDelegate = self;
    }
    return _homeCollectionView;
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//}


#pragma mark - private
- (void)p_configNavi{
    [self hiddenLeftBtn];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(searchFiles) image:[UIImage imageNamed:@"search"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(menuAction) image:[UIImage imageNamed:@"menu"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
