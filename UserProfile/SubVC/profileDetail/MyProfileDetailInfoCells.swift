//
//  MyProfileCells.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/4.
//

import UIKit

class MyProfileDetailInfoCell: TTTableViewCell {
    override func makeUI() {
        super.makeUI()
        addSubviews([mainLabel,subLabel,rightImageView,segementLine])
        backgroundColor  = .white
        
        mainLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(inset)
        }
        
        rightImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-inset)
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualTo(12)
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.right.equalTo(rightImageView.snp.left).offset(-3)
            make.centerY.equalToSuperview()
        }
        
        segementLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
        }
        
        // config
        mainLabel.config(font: .medium(14), textColor: .mainTextColor)
        subLabel.config(font: .regular(14), textColor: .mainTextColor2)
        rightImageView.image = R.image.back1()
    }
    
    
    // 最后一个cell 要变更分割先
    func lastCellReLayoutSegmentLine() {
        segementLine.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(12)
            make.bottom.equalToSuperview()
            make.left.equalTo(0)
        }
    }
}


//MARK: - Vip Cell
class MyProfileDetailAvatarCell: MyProfileDetailInfoCell {
    
    override func makeUI() {
        super.makeUI()
        addSubview(avatar)
        
        mainLabel.snp.remakeConstraints { (make) in
            make.left.top.equalTo(inset)
        }
        
        subLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(mainLabel)
            make.top.equalTo(mainLabel.snp.bottom).offset(1)
        }
        
        avatar.snp.makeConstraints { (make) in
            make.right.equalTo(-inset)
            make.centerY.equalToSuperview()
            make.size.equalTo(48)
        }
    }
    
    // 设置数据
    func setModelData() {
        
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        backgroundImageView.roundCorners([.topLeft,.topRight], radius: 8)
        
        // 渐变色
//        checkButton.backGroundIcon.image = UIImage.gradientImage(colors: [rgba(254, 233, 204, 1),rgba(234, 213, 169, 1)], size: checkButton.size)
    }
}



