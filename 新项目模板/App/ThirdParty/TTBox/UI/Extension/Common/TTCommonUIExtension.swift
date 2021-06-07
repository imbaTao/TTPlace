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
func topTabbarVC() -> UITabBarController? {
    if let rootWindowVC = rootWindow().rootViewController {
        if rootWindowVC.isKind(of: UITabBarController.self) {
              return rootWindow().rootViewController as! UITabBarController
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

// 控制器栈顶部的控制器
func topVC() -> UIViewController? {
//    if let selectedTabbarVC = topTabbarVC()?.selectedViewController {
//        if let topVC = selectedTabbarVC.navigationController?.viewControllers.last {
//            return topVC
//        }
//    }
    
    return UIViewController.currentViewController()
//    
//    print("topVC 为nil了")
//    return nil
}

extension UIViewController {
    
    class func currentViewController() -> UIViewController {
            let vc = UIApplication.shared.keyWindow?.rootViewController
            return UIViewController.findBestViewController(vc: vc!)
        }

    class func findBestViewController(vc : UIViewController) -> UIViewController {
            if vc.isKind(of:UISplitViewController.self) {
                let svc = vc as! UISplitViewController
                if svc.viewControllers.count > 0 {
                    return UIViewController.findBestViewController(vc: svc.viewControllers.last!)
                } else {
                    return vc
                }
            } else if vc.isKind(of: UINavigationController.self) {
                let nvc = vc as! UINavigationController
                if nvc.viewControllers.count > 0 {
                    return UIViewController.findBestViewController(vc: nvc.topViewController!)
                } else {
                    return vc
                }
            } else if vc.isKind(of: UITabBarController.self) {
                let tvc = vc as! UITabBarController
                if (tvc.viewControllers?.count)! > 0 {
                    return UIViewController.findBestViewController(vc: tvc.selectedViewController!)
                } else {
                    return vc
                }
            } else {
                return vc
            }
        
         // 以后改，有点麻烦，present控制器要注意
//        if vc.presentedViewController != nil  {
//            if vc.presentationController!.presentingViewController.isKind(of: UIAlertController.self) {
//                // 忽略alert控制器
//            }else {
//                return UIViewController.findBestViewController(vc: vc.topViewController!)
//            }
//        } else 
        }
    
    
    // 根据控制器类型获取控制器
    func fetchControllerWithType<T: UIViewController>(_ classType: T.Type) -> T? {
        if let nav = navigationController {
            for vc in nav.viewControllers {
                if let findVC = vc as? T {
                    return findVC
                }
            }
        }
        
        return nil
    }

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
