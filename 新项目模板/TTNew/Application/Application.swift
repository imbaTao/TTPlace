//
//  Application.swift
//  TTNew
//
//  Created by Mr.hong on 2020/11/23.
//

import UIKit

final class Application: NSObject {
    static let shared = Application()
    let userManager: UserManager
    var window: UIWindow?
    
    private override init() {
        userManager = UserManager.shared
        super.init()
        
    }
    


    // 展示第一个页面，有可能是登录，有可能是直接主页面
    func configuerFirstInterface(window: UIWindow?) {

        // debug某个界面,跳转测试控制器
        let debugger = TTDebugger(window: self.window!)
        if debugger.debuging == 1 {
            return;
        }

        // window
        self.window = window == nil ? UIWindow() : window
        
        // 解包
        if let window = self.window {
            window.frame = UIScreen.main.bounds;
            window.makeKeyAndVisible()
            window.backgroundColor = .white
            
            // 账号是否登录
            if userManager.isLogin {
                navigator.show(segue: .tabs, sender: nil,transition: .root(in: window))
            }else {
                // 弹出注册页
                // 完成后，回调这个函数
                userManager.isLogin = true
                configuerFirstInterface(window: window)
            }
        }
    }
        
    

    
    func presentTestScreen(in window: UIWindow?) {
//        guard let window = window, let provider = provider else { return }
//        let viewModel = UserViewModel(user: User(), provider: provider)
//        navigator.show(segue: .userDetails(viewModel: viewModel), sender: nil, transition: .root(in: window))
    }
        
        
}
