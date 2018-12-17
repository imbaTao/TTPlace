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

@interface HomeViewController ()<HomeCollectionViewDelegate>

/** HomeCollectionView */
@property(nonatomic,strong)HomeCollectionView *homeCollectionView;

@end


@implementation HomeViewController{
    UIImageView *imageV;
}

// 1.文件监听
// 2.图片截取
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

static a = 0;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    switch (a) {
        case 0:
            HUD_Loading;
            break;
        case 1:
            HUD_Right(@"正确");
            break;
        case 2:
            HUD_Error(@"错误");
         
            break;
        default:
            break;
    }
    a++;
    if (a==3) {
        a=0;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_configNavi];
}

- (void)layoutPageViews{
    self.homeCollectionView.dataArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
    [self.homeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeBtn.frame = CGRectMake(SCREEN_W - 120, SCREEN_H - 200, 70, 70);
    changeBtn.backgroundColor = [UIColor redColor];
    [changeBtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeBtn];
}

#pragma mark - HomeCollectionViewCellDelegate
- (void)homeCollectionViewCellSelected:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = (HomeCollectionViewCell *)[self.homeCollectionView cellForItemAtIndexPath:indexPath];
    if (!cell.isSelected) {
        cell.isSelected = true;
        cell.backgroundColor = [UIColor orangeColor];
    }else{
        cell.isSelected = false;
        cell.backgroundColor = [UIColor blackColor];
    }
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

#pragma mark - private
- (void)p_configNavi{
//    [self hiddenLeftBtn];
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(searchFiles) image:[UIImage imageNamed:@"search"]];
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(menuAction) image:[UIImage imageNamed:@"menu"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
