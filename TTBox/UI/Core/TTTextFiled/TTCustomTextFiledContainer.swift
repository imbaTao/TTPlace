//
//  TTCustomTextFiledContainer.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/7.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

class TTCustomTextFiledContainer: View {
    
    var clickMask = TTControll()
    
    // 文本输入
    var textFiled = TTTextFiled()
    
    // 边距
    var edge = UIEdgeInsets.zero {
        didSet {
            textFiled.snp.remakeConstraints { (make) in
                make.edges.equalTo(edge)
            }
        }
    }
    
    override func makeUI() {
        super.makeUI()
        addSubviews([textFiled,clickMask])
        textFiled.snp.makeConstraints { (make) in
            make.edges.equalTo(edge)
        }
        
        clickMask.snp.makeConstraints { (make) in
            make.edges.equalTo(edge)
        }
        
        // config
        clickMask.isUserInteractionEnabled = false
    }
    
    
    // 替换自定义textFiled
    func replaceCustomTextFiled(_ newTextFiled: TTTextFiled) {
        self.textFiled.removeFromSuperview()
        self.textFiled = newTextFiled
        makeUI()
    }
    
    func config(borderColor: UIColor,corner: CGFloat = 8.0) {
        self.borderColor = borderColor
        self.borderWidth = 1
        self.cornerRadius = corner
        
    }
}

