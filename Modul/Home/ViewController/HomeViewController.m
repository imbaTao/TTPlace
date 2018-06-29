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

@interface HomeViewController ()<HomeCollectionViewDelegate>
/** HomeCollectionView */
@property(nonatomic,strong)HomeCollectionView *homeCollectionView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_configNavi];
    [self.view addSubview:self.homeCollectionView];
    [self layoutPageViews];
    self.homeCollectionView.modelArray = @[@"1",@"2",@"3",@"4"];
}

- (void)layoutPageViews{
    [self.homeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


#pragma mark - HomeCollectionViewCellDelegate
- (void)homeCollectionViewCellSelected:(NSIndexPath *)indexPath{
    
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
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(SCREEN_W / 4, SCREEN_H / 4);
        _homeCollectionView = [[HomeCollectionView alloc] initWithLayout:layout cellClass:[HomeCollectionViewCell class] identifier:@"CellID"];
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
