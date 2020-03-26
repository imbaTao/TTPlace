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
//#import "JHGCommisionManageScrollPageViewController.h"


#define ISDEBUGER 0

#ifdef ISHTPlace
//#import <BRPickerView.h>
//#import <AuthenticationServices/AuthenticationServices.h>
//#import "TempSearchBar.h"
#endif

#import "HTHud.h"


@interface HTDebuggerViewController: UIViewController

/**
 testArray
 */
//@property(nonatomic, readwrite, strong)NSMutableArray *testArray;

@end
@implementation HTDebuggerViewController {
    NSMutableArray *_testArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:true animated:false];
}

- (void)viewDidLoad {
    // 加载
//     [HTHud showLoadingWithView:nil];
    
//    BWShowLodding;
    
//    [SVProgressHUD setAnimationDelay:5];
    
    
//    [HTHud showLoadingWithView:nil];
    
    // 蒙版不可点击类
    // [[HTHud showLoadingWithView:nil] isMask];
    
    // 隐藏
    // [HTHud removeAllHUD];
    
//    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
//    [SVProgressHUD show];
//    [SVProgressHUD showWithStatus:@"加载中"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    JHGShareModel *infoModel = [JHGShareModel modelWithType:JHGShareInfoTypeNormalProd ID:self.redPacketID];
//       infoModel.redPacketID = self.redPacketID;
//       infoModel.orderID = self.orderID;
//       [ShareHelper shareWithInfoModel:infoModel completionHandle:^(BOOL result) {
//           if (result) {
//               [selfWeak animationHidden];
//           }
//           sender.userInteractionEnabled = YES;
//       }];
    
    // 点击
    NSLog(@"点击到了");
    
//    [[HTHud showMesseage:@"服务器错误，请稍后尝试！" showView:nil] changeHiddenTimeWithDelayTimeInterval:3 animate:true];
//    BWShowHint(@"我是是伐啦可接受的了；副科级啊；离开当奸夫；阿拉基；东风路科技啊");
    
//    UIViewController *newVC = [[UIViewController alloc] init];
//    [self.navigationController pushViewController:newVC animated:true];
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

