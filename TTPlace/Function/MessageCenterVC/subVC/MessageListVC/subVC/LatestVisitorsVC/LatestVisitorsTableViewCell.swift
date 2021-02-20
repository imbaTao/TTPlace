//
//  LatestVisitorsTableViewCell.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/20.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import UIKit

class LatestVisitorsTableViewCell: TTTableViewCell {
    
    // 指示点
    var indicationPoint = UIView()
    
    // 身份标识
    var identityFlag = TTButton.init(text: "红娘", textColor: .white, font: .regular(10),type: .justText, padding: .init(top: 2, left: 4, bottom: 2, right: 4))
    
    // 符合条件提示
    var tips = UILabel.medium(size: 14, textColor: rgba(102, 102, 102, 1), text: "条符合你的征友条件", alignment: .left)
    
    override func makeUI() {
        super.makeUI()
        addSubviews([avatar,indicationPoint,identityFlag,mainLabel,subLabel,secondSubLabel,tips])
        
        
        avatar.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(56)
        }
        
        indicationPoint.snp.makeConstraints { (make) in
            make.top.equalTo(avatar.snp.top).offset(5)
            make.right.equalTo(avatar.snp.right).offset(-3)
            
        }
        
        identityFlag.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.centerX.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatar.snp.top).offset(4)
            make.left.equalTo(avatar.snp.right).offset(inset)
            make.right.equalTo(secondSubLabel.snp.left).offset(-inset)
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.left.equalTo(mainLabel)
            make.bottom.equalTo(avatar.snp.bottom).offset(-4)
            make.right.equalTo(mainLabel)
        }
        
        secondSubLabel.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.centerY.equalTo(mainLabel)
        }
        
        tips.snp.makeConstraints { (make) in
            make.left.right.equalTo(mainLabel)
            make.top.equalTo(secondSubLabel.snp.bottom).offset(6)
        }
        
        // config
        indicationPoint.circle()
        indicationPoint.backgroundColor = .red
        identityFlag.cornerRadius = 2
        mainLabel.config(font: .medium(16), textColor: rgba(51, 51, 51, 1), text: "红娘：娜娜", alignment: .left, numberOfline: 1)
        subLabel.config(font: .medium(14), textColor: rgba(102, 102, 102, 1), text: "29岁｜广东", alignment: .left, numberOfline: 1)
        secondSubLabel.config(font: .regular(12), textColor: rgba(102, 102, 102, 1), text: "28分钟前", alignment: .right, numberOfline: 1)
    }
    
    
    
}
