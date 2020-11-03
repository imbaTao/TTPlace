//
//  HTExtension_controller.swift
//  HTSwiftUILearn
//
//  Created by hong on 2020/1/17.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit

extension UIViewController {
    // 初始化布局
   @objc func setupLayout() {
      
   }
   
   // 初始化各种事件
   @objc func setupAction() {
        
   }
    
    // 初始化各种数据
    @objc func setupData() {
        
    }
}


// 获取控制器
func fetchVCWithClassName(clasName: String) -> UIViewController {
   //1:动态获取命名空间, 没获取到直接返回错误空的控制器
    if  let vcClass: AnyClass? = HTClassFromString(classNames: clasName) {
        
        // Swift中如果想通过一个Class来创建一个对象, 必须告诉系统这个Class的确切类型
        if let typeClass = vcClass as? UIViewController.Type {
           let myVC = typeClass.init()
              return myVC
        }else {
           print("vcClass不能当做UIViewController")
        }
    }else {
        print("获取命名空间失败")
    }

    let falilerStr = "获取不到对应类\(clasName)控制器"
    assertionFailure(falilerStr)
   return emptyErrorVC()
}




private func emptyErrorVC() -> UIViewController {
    let errorVC = UIViewController()
        errorVC.title = "控制器类型不存在,请检查类名"
    return errorVC
}

