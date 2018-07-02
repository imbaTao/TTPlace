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
#import "ShowExample_UIView.h"


@interface HomeViewController ()<HomeCollectionViewDelegate>
/** HomeCollectionView */
@property(nonatomic,strong)HomeCollectionView *homeCollectionView;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[HZYTabbarController share] isHaveBar:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_configNavi];
    [self.view addSubview:self.homeCollectionView];
    [self layoutPageViews];
    self.homeCollectionView.dataArray = @[@"UIView",@"2",@"3",@"4"];
}

- (void)layoutPageViews{
    [self.homeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


#pragma mark - HomeCollectionViewCellDelegate
- (void)homeCollectionViewCellSelected:(NSIndexPath *)indexPath{
    BaseViewController *vc;
    switch (indexPath.row) {
        case 0:vc = [[ShowExample_UIView alloc] init]; break;// UIView
        default:break;
    }
    [self.navigationController pushViewController:vc animated:true];
}

#pragma mark - Response
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
        layout.itemSize = CGSizeMake((SCREEN_W - 20)  / 5, (SCREEN_W - 20) / 5);
        _homeCollectionView = [[HomeCollectionView alloc] initWithLayout:layout cellClass:[HomeCollectionViewCell class] identifier:@"CellID"];
        _homeCollectionView.cellDelegate = self;
    }
    return _homeCollectionView;
}


#pragma mark - private
- (void)p_configNavi{
    self.view.backgroundColor = [UIColor orangeColor];
    [self hiddenLeftBtn];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(searchFiles) image:[UIImage imageNamed:@"search"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(menuAction) image:[UIImage imageNamed:@"menu"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
