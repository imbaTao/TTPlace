//
//  Application.swift
//  TTNew
//
//  Created by Mr.hong on 2020/11/23.
//

import UIKit
import RxSwift
import RxCocoa

final class Application: NSObject {
    static let shared = Application()
    let userManager: UserManager
    var window: UIWindow?
    
    private override init() {
        userManager = UserManager.shared
        super.init()
    }

    
    // 展示第一个页面，有可能是登录，有可能是直接主页面
    func configuerFirstInterface(window: inout UIWindow?) {

        if window == nil {
            window = UIWindow()
        }
        
        
        
        window!.frame = UIScreen.main.bounds;
        window!.makeKeyAndVisible()
        window!.backgroundColor = .white
        


        #if DEBUG
        
        // debug某个界面,跳转测试控制器
        let debugger = TTDebugger(window: window!)
        if debugger.debuging == 1 {
            return
        }
            
        // 登录成功显示tabbar
        
//        let viewModel = BlindDateListViewModel(provider: provider!)
//        navigator.show(segue: .blindDateList(viewMode: viewModel), sender: nil, transition: .root(in: window!))
        
//        navigator.show(segue: .blindDateRoom, sender: nil, transition: .root(in: window!))
        
        
//        return
        
//
//        self.window?.rootViewController = MyProfileDetailInfoVC()
//        self.window?.rootViewController = UINavigationController.init(rootViewController: MyProfileUploadWechatQRCodeVC())

        
        
//        userManager.isLogin = false
//        userManager.agreePolicy = false
        #endif
        
        

        
        self.window = window!
        
        // 账号是否登录
        if userManager.isLogin  {
            
            // 登录注册页,临时设置一个导航控制器，如果不完整需要导航控制跳转，否则会崩溃
            
            window!.rootViewController = UINavigationController()
            
//            // 检测账号资料完整性,不完整跳资料填写
//            userManager.checkUserInfoDataIntegrity {[weak self] in
//                // 登录成功显示tabbar
////                Application.shared.configureRootVC(Navigator.default.get(.tabs))
//
//                navigator.show(segue: .tabs, sender: nil,transition: .root(in: self!.window!))
////                navigator.show(segue: .tabs, sender: nil,transition: .root(in: self!.window!))
//            }
//
            
            // 启动app更新用户数据
//            userManager.requestLastUserInfo()
        }else {
            // 登录注册页
            navigator.show(segue: .login, sender: nil, transition: .root(in: self.window!))
          
//            window!.rootViewController = Navigator.default.get(.login)
        }
        
    }
    
    // 设置根控制器
    func configureRootVC(_ vc: UIViewController) {
        rootWindow().rootViewController = vc
    }

}
