//
//  HTDebugger.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/29.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTDebugger.h"
#import "HTDebuggerViewController.h"
#import "HTCommonTabbarController.h"


#define ISDEBUGER 1
@implementation HTDebugger

singleM();
- (BOOL)debugerWithKewindow:(UIWindow *)window {
    
    if (!window) {
      window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
      window.backgroundColor = [UIColor whiteColor];
      [window makeKeyAndVisible];
      [UIApplication sharedApplication].delegate.window = window;
    }
    
    // 这个暂时用不了了
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    if (!ISDEBUGER) {
        return false;
    }else {
        // 默认跳转测试控制器
        UIViewController *testVC = [[HTDebuggerViewController alloc] init];
//         JHGMyWalletBillViewController *billVC = [[JHGMyWalletBillViewController alloc] init];
        
        

        
        /** ----------------------------- 分割线 ------------------------------ */
        UITabBarController *tab = [[UITabBarController alloc] init];
        tab.tabBar.hidden = true;
        [tab.tabBar removeFromSuperview];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:testVC];
        [tab setViewControllers:@[nav]];
        window.rootViewController = tab;
        return true;
    }
}


@end


