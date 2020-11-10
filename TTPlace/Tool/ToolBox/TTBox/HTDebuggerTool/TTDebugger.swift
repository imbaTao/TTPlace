//
//  TTDebugger.swift
//  TTSwiftLearn
//
//  Created by Mr.hong on 2019/8/22.
//  Copyright © 2019 Mr.hong. All rights reserved.
//

import UIKit



class TTDebugger {

    // 是否启用debug拦截控制器
    var debuging = false;
    
    var window: UIWindow?
    init(window: UIWindow) {
         Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
        
        self.window = window;
        
        if debuging {
            self.debugger()
        }
    }

    
    func debugger() {
//        let testVC: UIViewController = fetchVCWithClassName(clasName: "LoginViewController")
         let testVC:UIViewController = UIViewController()
        let tabbar = UITabBarController()
        let nav = UINavigationController.init(rootViewController: testVC)
       tabbar.addChild(nav)
       tabbar.hidesBottomBarWhenPushed = true;
        
        window!.rootViewController = tabbar
        window!.makeKeyAndVisible()
    }
}



