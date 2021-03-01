//
//  MyProfileViewComponents.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/3.
//

import Foundation
class ProfileHeader: TTProfileHeader {
    // 编辑资料小按钮
    lazy var settingButton: TTButton = {
        var settingButton = TTButton.init(text: "", iconName: "Profile_setting", type: .justIcon)
        return settingButton
    }()
    
    // 添加相片视图
    lazy var addPhotoBanner: TTAddPhotoBanner = {
        var addPhotoBanner = TTAddPhotoBanner.init { (config) in
            
        }
//        addPhotoBanner.spacing = 4
//        addPhotoBanner.distribution = .fillEqually
        return addPhotoBanner
    }()

    
    // 根据用户信息初始化
     init(model: Profile) {
        super.init(frame: .zero)
        
        addSubviews([avatar,mainTitle,subTitle,genderIcon,settingButton,addPhotoBanner])
        
        // layout
        settingButton.snp.makeConstraints { (make) in
            make.top.equalTo(53)
            make.right.equalTo(-inset)
        }
        
        avatar.snp.makeConstraints { (make) in
            make.top.equalTo(settingButton.snp.bottom).offset(21)
            make.size.equalTo(64)
            make.left.equalTo(0)
        }
        
        mainTitle.snp.makeConstraints { (make) in
            make.top.equalTo(avatar.snp.top).offset(ver(9))
            make.left.equalTo(avatar.snp.right).offset(hor(12))
        }
        
        genderIcon.snp.makeConstraints { (make) in
            make.left.equalTo(mainTitle.snp.right).offset(hor(6))
            make.centerY.equalTo(mainTitle)
        }
        
        subTitle.snp.makeConstraints { (make) in
            make.bottom.equalTo(avatar.snp.bottom).offset(ver(-8))
            make.left.equalTo(mainTitle)
        }
        
        addPhotoBanner.snp.makeConstraints { (make) in
            make.right.equalTo(hor(-12))
            make.centerY.equalTo(avatar)
        }
                                 
        // config
        avatar.backgroundColor  = .green
     }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        settingButton.circle()
        genderIcon.circle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



