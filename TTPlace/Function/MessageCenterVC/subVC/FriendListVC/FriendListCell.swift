//
//  FriendListCell.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/20.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import UIKit

class FriendListCell: TTTableViewCell {

    override func makeUI() {
        super.makeUI()
        addSubviews([avatar,mainLabel,subLabel])
        
        
        avatar.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(56)
        }
        
        mainLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatar.snp.top).offset(4)
            make.left.equalTo(avatar.snp.right).offset(inset)
            make.right.equalTo(0)
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.left.equalTo(mainLabel)
            make.bottom.equalTo(avatar.snp.bottom).offset(-4)
            make.right.equalTo(mainLabel)
        }
    
         
        // config
        mainLabel.config(font: .medium(16), textColor: rgba(51, 51, 51, 1), text: "红娘：娜娜", alignment: .left, numberOfline: 1)
        subLabel.config(font: .medium(14), textColor: rgba(102, 102, 102, 1), text: "29岁｜广东", alignment: .left, numberOfline: 1)
        secondSubLabel.config(font: .regular(12), textColor: rgba(102, 102, 102, 1), text: "28分钟前", alignment: .right, numberOfline: 1)
        
    }
}
