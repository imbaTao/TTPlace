//
//  TabbarController.swift
//  HTPlace
//
//  Created by Mr.hong on 2020/10/22.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation


class TabbarController: HTTabbarViewController {
    override init(itemModels: [HTTabbarViewControllerItemModel]) {
        // 在初始化之前，设置configuration
        super.init(itemModels: itemModels)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        baseTabbar()?.configTuber(2)
    }
    
    // 是否可以变更页面
    override func canChangePage(index: Int)  -> Bool {
        // 这里控制，页面是否可以切换
//        if index == 1 {
//            return false
//        }
        return true
    }
    
    // tabbar点击
    override func itemDidSelected(index: Int) {
          print("\(index)")
    }
    
    // 双击下标
    override func doubleClickAction(index: Int) {
        print("双击了某个下标\(index)")
    }
}
