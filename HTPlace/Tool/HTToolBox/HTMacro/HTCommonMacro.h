//
//  HTCommonUserMacro.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/10/9.
//  Copyright © 2019 xiongbenwan. All rights reserved.



// AppDelegate
#define APPDELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])

// 获取系统版本号
#define SYSTEMVERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// 获取当前app版本号
#define APPVERSION [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"]

// 获取app名字
#define APPNAME [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleDisplayName"]

// 获取BundleId
#define APPBUNDLEID [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleIdentifier"]
