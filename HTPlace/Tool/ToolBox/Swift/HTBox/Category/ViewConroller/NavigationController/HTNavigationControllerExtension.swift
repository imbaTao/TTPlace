//
//  HTNavigationControllerExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/9/2.
//  Copyright © 2020 刘超. All rights reserved.
//

import UIKit

class HTNavigationControllerExtension {
    
    // 前提是tabbar是根控制器
    class func topNav() -> UINavigationController? {
        if (rootWindow().rootViewController?.isKind(of: UINavigationController.self)) != nil {
            if let tabbar: UITabBarController = (rootWindow().rootViewController as? UITabBarController) {
                    let nav =  tabbar.children[tabbar.selectedIndex] as! UINavigationController
                    return nav
                }
           }
           return nil
    }
}
