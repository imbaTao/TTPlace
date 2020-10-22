//
//  TabbarController.swift
//  HTPlace
//
//  Created by Mr.hong on 2020/10/22.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation


class TabbarController: HTTabbarViewController {
    
    
    // 是否可以变更页面
    override func canChangePage() -> Bool {
        return true
    }
    
    
    // tabbar点击
    func itemDidSelected(item: QMUIButton) {
        
    }
}
