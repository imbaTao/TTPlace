//
//  AppDelegate.m
//  HTToolBox
//
//  Created by hong  on 2018/6/26.
//  Copyright © 2018年 HT. All rights reserved.
//

#import "AppDelegate.h"
#import <SVProgressHUD.h>

//#import "VipBuyViewController.h"
#import "HomeViewController.h"
//#import "HTNetworking.h"
@interface AppDelegate ()



@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    #if DEBUG
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(hotReload) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    #endif
    [self p_configWindow];

    
    // 传入window开始调试
    if (HTDEBUGGER(self.window)) {
        return YES;
    }
  
    return YES;
}



#pragma mark - private
- (void)p_configWindow{
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    self.window.backgroundColor = [UIColor whiteColor];
    HomeViewController *testVC = [[HomeViewController alloc] init];
    UINavigationController*nv = [[UINavigationController alloc] initWithRootViewController:testVC];
    self.window.rootViewController = nv;
//    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:testVC];
    self.window.rootViewController = testVC;
    [self.window makeKeyAndVisible];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
