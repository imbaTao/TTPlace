//
//  TTCommonUIExtension.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/10/27.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation


// 寻找控制器栈顶某个类型的控制器
//func fetchSomeoneVCWithClass<T: NSObject>() -> T {
//    if let rootController = rootWindow().rootViewController {
//        rootController.children.flatMap { (child) in
//
//        }
//    }
//}


// 主tabbar
func topTabbarVC() -> TTTabbarViewController? {
    if let rootWindowVC = rootWindow().rootViewController {
        if rootWindowVC.isKind(of: TTTabbarViewController.self) {
              return rootWindow().rootViewController as! TTTabbarViewController
        }
    }
     return nil
}

// 顶部导航
func topNav() -> UINavigationController? {
   // 如果跟控制器是 UINavigationController
   if (rootWindow().rootViewController?.isKind(of: UINavigationController.self)) != nil {
       if let tabbar: UITabBarController = (rootWindow().rootViewController as? UITabBarController) {
               let nav =  tabbar.children[tabbar.selectedIndex] as! UINavigationController
               return nav
       }else if let navitationVC: UINavigationController = (rootWindow().rootViewController as? UINavigationController) {
            return navitationVC
        }
      }
      return nil
}

// 根据字符串获取类名
func TTClassFromString(classNames: String) -> AnyClass {
    // 工程名
    let workName = Bundle.main.infoDictionary?["CFBundleExecutable"] as! String
    return NSClassFromString("\(workName).\(classNames)")!
}


extension UIEdgeInsets {
    public init(sameValue: CGFloat)  {
        self.init()
        self.top = sameValue
        self.left = sameValue
        self.right = sameValue
        self.bottom = sameValue
//         return UIEdgeInsets.init(top: value, left: value, bottom: value, right: value)
    }
    
    
   
}
