//
//  TTBoxScreen.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/19.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation
import UIKit

// 屏幕宽
var SCREEN_W: CGFloat {
    return UIScreen.main.bounds.size.width
    
//    // 是否横屏
//    if UIApplication.shared.statusBarOrientation.isLandscape {
//        return max(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height)
//    }else {
//        return UIScreen.main.bounds.size.width
//    }
}

// 屏幕高
var SCREEN_H: CGFloat {
    return UIScreen.main.bounds.size.height
    
    
//    if UIApplication.shared.statusBarOrientation.isLandscape {
//        return min(UIScreen.main.bounds.size.width,UIScreen.main.bounds.size.height)
//    }else {
//        return UIScreen.main.bounds.size.height
//    }
}

// 状态栏高度
var StatusBarHeight: CGFloat {
    return UIApplication.shared.statusBarFrame.size.height
}

// 导航栏高度
var NavigationBarHeight: CGFloat {
    return StatusBarHeight + 44
}

// 安全区顶部高度
//let SafeTopHeight =  CGFloat(StatusBarHeight > 20.0 ? 34.0 : 0)

// 安全区底部高度
let SafeBottomHeight = CGFloat(StatusBarHeight > 20.0 ? 34.0 : 0.0)

// 系统tabbar高度
//let TabbarBottomHeight =  CGFloat(StatusBarHeight > 20.0 ? 83.0 : 49.0)

/************************  屏幕尺寸  ***************************/
/// 屏幕bounds
let SCREEN_BOUNDS = UIScreen.main.bounds

// iPhone4
let isIphone4 = SCREEN_H < 568 ? true : false

// iPhone 5
let isIphone5 = SCREEN_H == 568 ? true : false

// iPhone 6
let isIphone6 = SCREEN_H == 667 ? true : false

// iphone 6P
let isIphone6P = SCREEN_H == 736 ? true : false

// iphone X
let isIphoneX = SCREEN_H >= 812 ? true : false

// navigationBarHeight
let kNavigationBarHeight: CGFloat = isIphoneX ? 88 : 64

// tabBarHeight
let kTabBarHeight: CGFloat = isIphoneX ? 49 + 34 : 49

// 有刘海
let HaveSafeArea = SCREEN_H >= 812 ? true : false

// 根window
func rootWindow() -> UIWindow {
    // 倒叙 遍历
    for tWindow in UIApplication.shared.windows.reversed() {
        // 找到满足条件的window
        if tWindow.isHidden == false,let effName = NSClassFromString("UITextEffectsWindow"),tWindow.isKind(of: effName) == false,let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow"),tWindow.isKind(of: keyboardWindowClass) == false {
            return tWindow
        }
    }
    
    if let keyWindow = UIApplication.shared.keyWindow {
        return keyWindow
    }

    // 最后肯定有值
    return (UIApplication.shared.delegate!.window!!)
}


