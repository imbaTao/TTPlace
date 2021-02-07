//
//  TTCustomTextFiledContainer.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/7.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

class TTCustomTextFiledContainer: View {
    // 文本输入
    let textFiled = TTTextFiled()
    
    // 边距
    var edge = UIEdgeInsets.zero {
        didSet {
            textFiled.snp.makeConstraints { (make) in
                make.edges.equalTo(edge)
            }
        }
    }
    
    override func makeUI() {
        super.makeUI()
        addSubview(textFiled)
        textFiled.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

