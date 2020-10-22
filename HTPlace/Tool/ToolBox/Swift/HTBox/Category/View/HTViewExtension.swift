//
//  HTViewExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/24.
//  Copyright © 2020 刘超. All rights reserved.
//

import Foundation
extension UIView {
    // 初始化布局
    func setupLayout() {
        
    }
    
    // 初始化各种事件
     func setupAction() {
    
    }
    
    
    // 倒圆角
    func settingCornerRadius(_ radius: CGFloat) {
       self.layer.cornerRadius = radius
       self.layer.masksToBounds = true
    }
}


