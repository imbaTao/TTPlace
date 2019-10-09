//
//  HTDebugger.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/29.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTDebugger.h"

#import "HTCycleViewManager.h"
#import "JHGProductCommonDetailViewController.h"
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
        
//        HTCommonTableViewModel *vm = [[HTCommonTableViewModel alloc] init];
//        vm.canPullUp = false;
//        vm.canPulldown = false;
//        testVC = [[JHGProductCommonDetailViewController alloc] initWithViewModel:vm];
        
        // 已加入调试队列的vc名字
        self.vcNames = @[
                         @"HTDebuggerViewController",
                         ];
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
@interface  HTDebuggerViewController : UIViewController<HTCycleViewDelegate>

/**
 tempView
 */
@property(nonatomic, readwrite, strong)HTCommonCollectionView *tempView;

@end

@implementation HTDebuggerViewController
- (void)viewDidLoad {
    [self injected];
}

- (void)injected
{
    for (UIView *value in self.view.subviews) {
        [value removeFromSuperview];
    }
    
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout creatWithLineSpacing:18 InteritemSpacing:0 sectionInset:UIEdgeInsetsZero itemSize:CGSizeMake(30, 20) scrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    _tempView = [[HTCommonCollectionView alloc] initWithFrame:CGRectZero layout:layout cellClassNames:nil delegateTarget:nil];
    [self.view addSubview:_tempView];
    
    [_tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
    }];
    
    [[_tempView rac_signalForSelector:@selector(configureCell:atIndexPath:tableView:)] subscribeNext:^(RACTuple * _Nullable x) {
        HTCommonCollectionView *cell = x.first;
        cell.backgroundColor = [UIColor grayColor];
    }];
    
    _tempView.data = [@[@1] mutableCopy];
    
//  HTCycleView *cyleView = [HTCycleViewManager creatCyleViewWithStyle:HTCycleViewStyleNormalStyle size:CGSizeMake(BWScreenWidth, 200)];
//    cyleView.delegate = self;
//    [self.view addSubview:cyleView];
//    [cyleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(BWNavigationBarHeight);
//        make.left.offset(0);
//        make.size.mas_equalTo(CGSizeMake(BWScreenWidth, 200));
//    }];
//    cyleView.backgroundColor = [UIColor redColor];
//
//    [cyleView injectData:@[@"activity/201907041725451280_720x432.png",@"activity/201809061802425693_720x340.jpg",@"activity/201809061801228350_720x340.jpg",@"activity/201809061800416787_720x340.jpg",@"activity/201906050952203678_720x340.jpg"]];
}








@end
