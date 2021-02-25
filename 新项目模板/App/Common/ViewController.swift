//
//  ViewController.swift
//  NewSwiftProjectModul
//
//  Created by Mr.hong on 2020/11/3.
//

import UIKit

class ViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarDefaultConfig()
        tabbarShowOrHiddenSignal.onNext(self.isTabbarChildrenVC)
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
        
        // 设置默认返回
        configLeftItem(iconName: "NavigationBarBack") { [weak self] in
            self?.backAction()
        }
    }
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    // 默认是不隐藏导航栏的
    func navigationBarDefaultConfig() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
    }

}

