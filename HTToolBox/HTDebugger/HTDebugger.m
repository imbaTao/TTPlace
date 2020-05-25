//
//  HTDebugger.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/29.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTDebugger.h"
#import "HTCommonTabbarController.h"
#import "HTNetworking.h"
#import <SVProgressHUD.h>



//#import "HTSVIndefiniteAnimatedView.h"

#define ISDEBUGER 0

#ifdef ISHTPlace
//#import <BRPickerView.h>
//#import <AuthenticationServices/AuthenticationServices.h>
//#import "TempSearchBar.h"
#endif

#import "HTHud.h"


@interface HTDebuggerViewController: UIViewController

@end
@implementation HTDebuggerViewController {
    NSMutableArray *_testArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:true animated:false];
}

- (void)viewDidLoad {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}
@end



@implementation HTDebugger

singleM();
- (BOOL)debugerWithKewindow:(UIWindow *)window {
    // 这个暂时用不了了
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    if (!ISDEBUGER) {
        return false;
    }else {
   // BWLog(@"我走了");
        
        // 默认跳转测试控制器
        UIViewController *testVC = [[HTDebuggerViewController alloc] init];
//         JHGMyWalletBillViewController *billVC = [[JHGMyWalletBillViewController alloc] init];
//           testVC = billVC;
        
//        JHGCommisionManageScrollPageViewController *comVC =  [[JHGCommisionManageScrollPageViewController alloc] initWithTitles:[@[@"累计佣金",@"交易中",@"冻结中",@"已结算",@"已退返佣金"] mutableCopy] className:@"JHGCommisionManageViewController" topInterVal:0 height:80 pageHeight:SCREEN_H - NavigationBarHeight autoWidth:true addPageView:true];
//        comVC.shopId = @"69270";
////        66023
//        testVC = comVC;
        
     

//        JHGCommisionManageScrollPageViewController *commisionManageVC = [[JHGCommisionManageScrollPageViewController alloc] initWithTitles:[@[@"累计佣金",@"交易中",@"冻结中",@"已结算",@"已退返佣金"] mutableCopy] className:@"JHGCommisionManageViewController" topInterVal:0 height:80 pageHeight:SCREEN_H - NavigationBarHeight autoWidth:true addPageView:true];
//        testVC = commisionManageVC;
        
        
        
        
        

        
        /** ----------------------------- 分割线 ------------------------------ */
        UITabBarController *tab = [[UITabBarController alloc] init];
        tab.tabBar.hidden = true;
        [tab.tabBar removeFromSuperview];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:testVC];
        [tab setViewControllers:@[nav]];
        [window makeKeyAndVisible];
        window.rootViewController = tab;
        return true;
    }
}


@end


