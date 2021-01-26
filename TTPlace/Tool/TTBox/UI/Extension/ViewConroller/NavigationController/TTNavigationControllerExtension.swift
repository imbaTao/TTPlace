//
//  TTNavigationControllerExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/9/2.
//  Copyright © 2020 刘超. All rights reserved.
//

import UIKit

// 导航栏左侧按钮
class TTNavitaionLeftButtonItem: UIView {
    // 因为平时的按钮需要设置偏移，且位置不对,且点击作用域也太小
    
    // 把按钮包一下
    init(button: UIButton) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: 44, height: 44))
        self.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UINavigationController {

}



