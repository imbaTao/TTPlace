//
//  HTCommonUserMacro.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/10/9.
//  Copyright © 2019 xiongbenwan. All rights reserved.




// 屏幕宽高
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height




// 状态栏高度
#define StatusBarHeight ([UIApplication sharedApplication].statusBarFrame.size.height)

// 导航栏高度
#define NavigationBarHeight (StatusBarHeight + 44)

// 标签栏高度
#define TabBarHeight (StatusBarHeight > 20 ? 83 : 49)

// 底部安全区域高度
#define TabBarBottomHeight (StatusBarHeight > 20 ? 34 : 0)

// 顶部新增高度
#define StatusBarTopHeight (StatusBarHeight > 20 ? 24 : 0)

// AppDelegate
#define APPDELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

// 获取当前ios版本号
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// 获取当前app版本号
#define APP_VER [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"]

// 获取app名字
#define APP_NAME [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleDisplayName"]

// 获取BundleId
#define BundleID [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleIdentifier"]


