//
//  MyVipCell.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/3/1.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

class MyVipCell: TTTableViewCell {
    override func makeUI() {
        super.makeUI()
        addSubviews([leftImageView,mainLabel,subLabel])
        
        leftImageView.snp.makeConstraints { (make) in
            make.left.equalTo(22)
            make.centerY.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { (make) in
            make.top.right.equalTo(0)
            make.left.equalTo(leftImageView.snp.right).offset(23)
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(mainLabel)
        }
    }
}
