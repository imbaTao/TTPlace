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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarDefaultConfig()
            
    }
    

    @objc func injected() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       navigationBarDefaultConfig()
    }

    
    // 默认是不隐藏导航栏的
    func navigationBarDefaultConfig() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
}
