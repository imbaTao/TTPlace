//
//  BaseViewController.swift
//  HTPlace
//
//  Created by Mr.hong on 2020/10/26.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit


// 系统导航栏太烦躁，，各种需要改 ,不想用
class HTNavigationBar: UIView {
    
}




class BaseViewController: UIViewController {
    
    // 是否是tabbar的子控制器
    var isTabbarChildrenVC = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarDefaultConfig()
        
        // 显示
        tabbarShowOrHiddenSignal.onNext(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 显示
        tabbarShowOrHiddenSignal.onNext(false)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfig()
        navigationBarDefaultConfig()
    }

    // 默认设置
    func defaultConfig() {
        self.view.backgroundColor = .white
        
        // 去掉导航栏横线
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // 默认是不隐藏导航栏的
    func navigationBarDefaultConfig() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
}
