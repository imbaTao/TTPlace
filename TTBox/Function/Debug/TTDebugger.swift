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
    var debuging = 0

    var window: UIWindow?
    init(window: UIWindow) {
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?
            .load()

        self.window = window

        if debuging == 1 {
            self.debugger()
        }
    }

    func debugger() {

        //        let testVC: UIViewController = ProfileVC()
        //
        ////        let tabbar = UITabBarController()
        //        let nav = UINavigationController.init(rootViewController: testVC)
        ////       tabbar.addChild(nav)
        ////
        //        window!.rootViewController = nav
        //        window!.makeKeyAndVisible()

        //        NetManager.shared.fetchNeedTokenWebUrl(.test) { (url) in
        //            let testVC = WebVC.init(url)
        //            //        let tabbar = UITabBarController()
        //                    let nav = UINavigationController.init(rootViewController: testVC)
        //            //       tabbar.addChild(nav)
        //            //
        //            self.window!.rootViewController = nav
        //            self.window!.makeKeyAndVisible()
        //        }

    }
}
