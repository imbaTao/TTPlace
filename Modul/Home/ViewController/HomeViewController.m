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

#import "NSCodingLearnMethod.h"
@interface HomeViewController ()<HomeCollectionViewDelegate>
/** HomeCollectionView */
@property(nonatomic,strong)HomeCollectionView *homeCollectionView;
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
    self.homeCollectionView.dataArray = @[@"UIView",@"UIButton",@"WebDatatransfer",@"share",@"waterFall"];
    
//    NSCodingLearnMethod *learn = [[NSCodingLearnMethod alloc] initWithName:@"哈哈" ID:1];
//    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:learn];
//    
//    NSData *unarchiverData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    NSLog(@"%@,%@",data,unarchiverData);
    
    
    
}

- (void)layoutPageViews{
    self.homeCollectionView.backgroundColor = [UIColor clearColor];
    [self.homeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
    

    NSString *dateStr = @"2018-7-25";
    NSDateFormatter *fomater = [[NSDateFormatter alloc] init];
    fomater.dateFormat = @"yyyy-MM-dd";
    fomater.timeZone =  [NSTimeZone defaultTimeZone];
    [fomater dateFromString:dateStr];
}


#pragma mark - HomeCollectionViewCellDelegate
- (void)homeCollectionViewCellSelected:(NSIndexPath *)indexPath{
    ShowExampleViewController *vc = [[ShowExampleViewController alloc] initWithType:indexPath.row];
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
        layout.itemSize = CGSizeMake((SCREEN_W - 60)  / 5, (SCREEN_W - 60) / 5);
        _homeCollectionView = [[HomeCollectionView alloc] initWithLayout:layout cellClass:[HomeCollectionViewCell class] identifier:@"CellID"];
        _homeCollectionView.cellDelegate = self;
    }
    return _homeCollectionView;
}


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
