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
<<<<<<< HEAD

=======
//#import "HTNetworking.h"
>>>>>>> 09d562466c7179e718c22a081ea76fc33792e621
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self p_configWindow];

    
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.2];
    //    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setShouldTintImages:NO];
    [SVProgressHUD setCornerRadius:5.f];
    
//
//    //        return @"http://192.168.0.86:8033/v1/";//本地环境-娟姐
//    //        return @"http://192.168.16.40:8033/v1/";//本地环境-志伟哥
//    //    return @"http://api.jihuigou.net/v1/";//测试地址
//    return @"https://api.91jhg.com/v1/";//正式环境
//
//    //    return @"http://192.168.0.86:8011/";//本地环境-娟姐
//    //    return @"http://192.168.16.40:8040/";//本地环境地址--志伟哥
//    //    return @"http://gateway.jihuigou.net/";//测试地址
//    return @"https://gateway.91jhg.com/";//正式环境地址

    [self networkingConfig];
    
    
//    HTNetworkingDomainModel *domainModel = [[HTNetworkingDomainModel alloc] init];
//    domainModel.localDomain = @"http://192.168.0.86:8033/v1/";
//    domainModel.testDomain = @"http://api.jihuigou.net/v1/";
//    domainModel.releaseDomain = @"https://gateway.91jhg.com/";
//    [HTNetworking setupNetworkingWithDomainModel:domainModel dataKeys:@"Data" messageKey:@"Message" codeKey:@"Code" successCode:1 netEnvironment:HTNetworkingEnvironmentTest];
    
    
    [WXApi registerApp:@"wx9989621fbe68b03b" universalLink:@"https://www.ta521.com/fenxiang/apple-app-site-association/"];
    
    // 传入window开始调试
    if (HTDEBUGGER(self.window)) {
        return YES;
    }
  
    return YES;
}

- (void)networkingConfig {
    
}



#pragma mark - private
- (void)p_configWindow{
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    HomeViewController *testVC = [[HomeViewController alloc] init];
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:testVC];
    self.window.rootViewController = nv;
    [self.window makeKeyAndVisible];
}



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
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
