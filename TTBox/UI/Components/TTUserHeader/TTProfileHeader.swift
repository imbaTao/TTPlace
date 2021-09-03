//
//  TTProfileHeader.swift
//  TTBox
//
//  Created by Mr.hong on 2020/12/3.
//

import UIKit


// 每次写icon都要新建倒圆角，不如监听赋值时倒转角
class TTAvatar: UIImageView {
    var isNeedCirclRadius = true
    override func layoutSubviews() {
        super.layoutSubviews()
        if isNeedCirclRadius {
            self.cornerRadius = self.size.height / 2
        }
    }
}

// 用户资料一般都包含这些，don't repeat your self
class TTProfileHeader: UIView {
    lazy var avatar: TTAvatar = {
        var avatar = TTAvatar.name("TTAvatar_default")
        return avatar
    }()
    
    lazy var mainTitle: UILabel = {
        var mainTitle = UILabel.medium(size: 18,textColor: rgba(51, 51, 51, 1),text: "昵称")
        return mainTitle
    }()
    
    lazy var subTitle: UILabel = {
        var subTitle = UILabel.regular(size: 13,textColor: rgba(102, 102, 102, 1))
        return subTitle
    }()
    
    
    // default is man
    lazy var genderIcon: TTButton = {
        var genderIcon = TTButton.init(text: "18", iconName: "TTAvatar_man", type: .iconOnTheLeft, intervalBetweenIconAndText: 5,padding: .init(top: 2, left: 7, bottom: 2, right: 7)) {
        }
        
        //  woman rgba(253, 141, 183, 1)
        genderIcon.backgroundColor = rgba(15, 214, 255, 1)
        return genderIcon
    }()
    
}
