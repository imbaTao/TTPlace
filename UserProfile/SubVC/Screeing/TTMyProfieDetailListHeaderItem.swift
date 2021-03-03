//
//  TTMyProfieDetailListHeaderItem.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/3/3.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

//MARK: - 自定义item
class TTMyProfieDetailListHeaderItem: TTStaticListSectionItem {
    
    // 这里用个按钮做点击选中效果,标题有单独自定义控件
    lazy var backGroundView: UIButton = {
        var backGroundView = UIButton.button()
        backGroundView.setBackgroundImage(.init(color: rgba(244, 244, 244, 1), size: ttSize(351, 88)), for: .normal)
        //            backGroundView.setBackgroundImage(.init(color: #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1), size: ttSize(351, 88)), for: .selected)
        return backGroundView
    }()
    
    
    override func setupItem() {
        super.setupItem()
        
        // 先设置size
        self.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: SCREEN_W, height: 88))
        }
        
        addSubviews([backGroundView,mainLabel,subLabel,leftImageView,rightImageView])
        
        // layout
        backGroundView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(inset)
            make.top.bottom.equalToSuperview()
        }
        
        leftImageView.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.size.equalTo(52)
            make.centerY.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftImageView.snp.right).offset(inset)
            make.top.equalTo(inset)
            make.centerY.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.right.equalTo(rightImageView.snp.left).offset(-hor(3))
            make.centerY.equalToSuperview()
            make.width.equalTo(98)
        }
        
        rightImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-inset * 2)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        
        
        // config
        backGroundView.cornerRadius = 31
        rightImageView.image = R.image.profile_screeing_edit()
        
        mainLabel.font = .medium(16)
        mainLabel.textColor = .mainTextColor2
        
        subLabel.font = .medium(16)
        subLabel.textColor = .mainTextColor
        subLabel.textAlignment = .right
    }
}
