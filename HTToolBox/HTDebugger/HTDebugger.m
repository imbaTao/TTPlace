//
//  HTDebugger.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/29.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTDebugger.h"
#import "HomeViewController.h"
#import "HTBaseCollectionView.h"

#define ISDEBUGER 1


@interface HTDebugger ()


@end
@implementation HTDebugger
singleM();

- (BOOL)debugerWithKewindow:(UIWindow *)window {
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    
    if (!ISDEBUGER) {
         return false;
    }else {
        // 要调试第几个VC
        self.debugVcIndex = 0;
        
        UIViewController *testVC;
        // 已加入调试队列的vc名字
        self.vcNames = @[
                         @"HTDebuggerViewController",
                         @"HomeViewController",
                         ];
        
//        HTCommonTableViewModel *vm = [[HTCommonTableViewModel alloc] init];
//        vm.canPullUp = false;
//        vm.canPulldown = false;
//        testVC = [[HomeViewController alloc] initWithViewModel:vm];
        if (!testVC) {
            testVC =  [[NSClassFromString(self.vcNames[self.debugVcIndex]) alloc] init];
        }
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:testVC];
        [window makeKeyAndVisible];
        window.rootViewController = nav;
        return true;
    }
}

@end


@interface  HTDebuggerViewController : UIViewController<UICollectionViewDataSource>
/**
 <#description#>
 */
@property(nonatomic, readwrite, strong)UICollectionView *prodlist;
@end

@implementation HTDebuggerViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 要使用默认导航栏页面的话，需要设置为nil，否则没有导航栏下面的那根线
    
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.translucent = true;
}

- (void)viewDidLoad {
    [self prodlist];
}

- (void)injected
{
    for (UIView *value in self.view.subviews) {
        [value removeFromSuperview];
    }
    
//    self.view.backgroundColor = UIColor.redColor;
    _prodlist = nil;
    [self prodlist];
    
    
}


- (UICollectionView *)prodlist {
    if (!_prodlist) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 15;
        
        CGFloat cellWidth = (SCREEN_W - 15 * 2 - 13 * 2 - layout.minimumLineSpacing * 2) / 3;
        
        CGFloat mutiply = 140.0 / 111.0;
        CGFloat cellHeight = cellWidth * mutiply;
        
        
        
        UIView *board = [[UIView alloc] init];
        board.backgroundColor = [UIColor yellowColor];
        [self.view addSubview:board];
        [board mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(13);
            make.right.offset(-13);
            make.top.offset(0);
            make.height.offset(cellHeight);
        }];
        
        
        layout.itemSize = CGSizeMake(cellWidth, cellHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _prodlist = [[HTBaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout identifer:@"UICollectionViewCell" cellClassString:@"UICollectionViewCell"];
        _prodlist.scrollEnabled = false;
        _prodlist.backgroundColor = [UIColor clearColor];
        _prodlist.dataSource = self;
        _prodlist.layer.masksToBounds = true;
        _prodlist.layer.cornerRadius = 4;
        [board addSubview:_prodlist];
        [_prodlist mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.offset(100);
//            make.left.offset(0);
//            make.right.offset(0);
//            make.height.offset(cellHeight);
            
            make.edges.equalTo(board);
        }];
    }
    return _prodlist;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 这里子类复写
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}
@end
