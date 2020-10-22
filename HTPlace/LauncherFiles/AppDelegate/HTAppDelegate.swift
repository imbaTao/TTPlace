//
//  AppDelegate.swift
//  HTSwiftLearn
//
//  Created by Mr.hong on 2019/8/22.
//  Copyright © 2019 Mr.hong. All rights reserved.
//

import UIKit

@UIApplicationMain
/**
 swift学习计划 目标纯swift
 1.初步项目工程搭建
 2.以oc老项目练手，使用RXSwift
 3.swift ui
 */


/**
 初步搭建
 1.window设置,debugger设置
 */
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // debug时需要的，hotReloading
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
        

        
        self.window = UIWindow()
        self.window?.frame = UIScreen.main.bounds;
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = .white
        
        
        // debug某个界面,跳转测试控制器
         let debugger = HTDebugger(window: self.window!)
           if debugger.debuging {
               return true;
           }
        
        self.configuerFirstInterface()
        
        // 正常逻辑
        return true
    }
    
    
    // 展示第一个页面，有可能是登录，有可能是直接主页面
    func configuerFirstInterface() {
        
        // 账号是否登录
        if Account.isLogin {
            
            // tabbar 模型数量
            let models = [
                HTTabbarViewControllerItemModel(normalImageName: "homeUnselected", selectedImageName: "homeSelected", itemContent: "home", selected: true),
                HTTabbarViewControllerItemModel(normalImageName: "personUnselected", selectedImageName: "personSelected", itemContent: "mine", selected: true),
//                HTTabbarViewControllerItemModel(unSelectImageName: "", selectedImageName: "", itemContent: "", selected: true),
//                HTTabbarViewControllerItemModel(unSelectImageName: "", selectedImageName: "", itemContent: "", selected: true),
            ]
            
            
            // 导航栏结构是，tabbar 持有 5个 navigationController ,然后navigationController 各自持有一个viewController
            let tabbarVC = TabbarController.init(itemModels: models)
            
            var vcArray = [UIViewController]()
            
            //  主要的几个控制器
            let homeVC = UIViewController()
            homeVC.view.backgroundColor = .red
            
            let mineVC = UIViewController()
            mineVC.view.backgroundColor = .blue
            
            // 数组控制vc的添加
             vcArray.append(homeVC)
             vcArray.append(mineVC)
            
            
            // 遍历数组，不用每次去写单独导航栏
           let _ = vcArray.map { (vc) in
                let nav = UINavigationController(rootViewController: vc)
                tabbarVC.addChild(nav)
            }
            
            
            // 这个属性，几乎所有首页的控制器都需要写,或者统一使用跳转方法，在跳转方法里进行设置
//            tabbar.hidesBottomBarWhenPushed = true;
            
            self.window?.rootViewController = tabbarVC;
        }else {
            // 弹出注册页
            // 完成后，回调这个函数
            Account.isLogin = true
            configuerFirstInterface()
        }
    }
    

    // app进入前台
    func applicationWillResignActive(_ application: UIApplication) {

    }
    
   // app进入后台
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
