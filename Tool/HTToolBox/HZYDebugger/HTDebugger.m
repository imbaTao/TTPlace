//
//  HTDebugger.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/29.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTDebugger.h"
#import "JHGGroupShoppingHomeVC.h"

#import "JHGGroupShoppingOrderVC.h"


#import "HTDebuggerViewController.h"


@implementation HTDebugger
+ (BOOL)debugerWithKewindow:(UIWindow *)window {
//    return  false;
//     测试控制器
//    JHGGroupShoppingHomeVC *testVC = [[JHGGroupShoppingHomeVC alloc] initWithTitles:@[@"推荐"] className:@"JHGGroupShoppingHomePageVC" topInterVal:27 + 24 height:27 autoWith:false];
    
    
//  JHGGroupShoppingOrderVC *testVC = [[JHGGroupShoppingOrderVC alloc] initWithTitles:@[@"全部",@"进行中",@"成功",@"失败"] className:@"JHGGroupShoppingOrderPageVC" topInterVal:0 height:27 autoWith:true];
    
    

    
    
    
    HTDebuggerViewController *testVC = [[HTDebuggerViewController alloc] init];

    UIViewController *view = testVC;

//    UIViewController *view1 = [[UIViewController alloc] init];
//    view1.title = @"测试控制器2";
//    UIViewController *view2 = [[UIViewController alloc] init];
//
//    UITabBarController *testTabbar = [[UITabBarController alloc] init];
//    view2.title = @"测试控制器3";
//
//
//
//    [testTabbar addChildViewController:view];
//    [testTabbar addChildViewController:view1];
//    [testTabbar addChildViewController:view2];
//    [testTabbar.navigationController setNavigationBarHidden:false animated:NO];
//
//    UINavigationBar *appearance = [UINavigationBar appearance];
//    [appearance setTranslucent:YES];
//
//
//    BWBaseViewController *view3 = [[BWBaseViewController alloc] init];
//    view3.title = @"测试控制器3";
    
    
    BWBaseNavController *platformNav = [[BWBaseNavController alloc] initWithRootViewController:view];
//    [view3.navigationController pushViewController:testTabbar animated:true];

    
    [window makeKeyAndVisible];
    window.rootViewController = platformNav;

     [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    
    return true;
}
@end
