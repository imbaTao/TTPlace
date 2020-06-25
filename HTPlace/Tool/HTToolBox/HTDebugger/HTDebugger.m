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
#import "HTFPSLabel.h"
#define ISDEBUGER 0

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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        HTFPSLabel *label = [[HTFPSLabel alloc] initWithFrame:CGRectMake(120, StatusBarTopHeight, 50, 20)];
        if (window.safeAreaInsets.top > 0) {
             label.x = 30;
             label.y = 0;
         }
        [window addSubview:label];
    });
    if (!ISDEBUGER) {
        return false;
    }else {
        // 默认跳转测试控制器
        UIViewController *testVC = [[HTDebuggerViewController alloc] init];

        
        
//         SelectIdentityController EnterpriseInfoCompleteController
//        PersonalAuthController 个人
        
        
//        CampusInfoCompleteController
        
//        CampusCertificationController //校园 组织认证
        testVC = [[NSClassFromString(@"PersonalAuthController") alloc] init];
        
        
        
        
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


