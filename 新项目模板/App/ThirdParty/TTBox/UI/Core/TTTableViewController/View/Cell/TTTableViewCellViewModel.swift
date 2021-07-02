//
//  TableViewCellViewModel.swift
//  TTBox
//
//  Created by Mr.hong on 2021/1/9.
//

import UIKit

class TTTableViewCellViewModel: BaseTableViewCellViewModel {
    let mainContent = BehaviorRelay<String?>(value: nil)
    let subContent = BehaviorRelay<String?>(value: nil)
    let secondSubContent = BehaviorRelay<String?>(value: nil)
    let attributedContent = BehaviorRelay<NSAttributedString?>(value: nil)

    
    let avatarImage = BehaviorRelay<UIImage?>(value: nil)
    let leftImage = BehaviorRelay<UIImage?>(value: nil)
    let centerImage = BehaviorRelay<UIImage?>(value: nil)
    let rightImage = BehaviorRelay<UIImage?>(value: nil)
    
    let avatarImageUrl = BehaviorRelay<String?>(value: nil)
    let leftImageUrl = BehaviorRelay<String?>(value: nil)
    let centerImageUrl = BehaviorRelay<String?>(value: nil)
    let rightImageUrl = BehaviorRelay<String?>(value: nil)

    
    
    // 根据信号隐藏图片
    let hiddAvatar = BehaviorRelay<Bool>(value: false)
    let hideLeftImage = BehaviorRelay<Bool>(value: false)
    let hideCenterImage = BehaviorRelay<Bool>(value: false)
    let hideRightImage = BehaviorRelay<Bool>(value: false)
    
}


class BaseTableViewCellViewModel: HandyJSON {
    required init() {
        
    }
}

class TableViewCellViewModel: NSObject {
    let title = BehaviorRelay<String?>(value: nil)
    let detail = BehaviorRelay<String?>(value: nil)
    let secondDetail = BehaviorRelay<String?>(value: nil)
    let attributedDetail = BehaviorRelay<NSAttributedString?>(value: nil)
    let image = BehaviorRelay<UIImage?>(value: nil)
    let imageUrl = BehaviorRelay<String?>(value: nil)
    let badge = BehaviorRelay<UIImage?>(value: nil)
    let badgeColor = BehaviorRelay<UIColor?>(value: nil)
    let hidesDisclosure = BehaviorRelay<Bool>(value: false)

    let mainContent = BehaviorRelay<String?>(value: nil)
    let subContent = BehaviorRelay<String?>(value: nil)
    let secondSubContent = BehaviorRelay<String?>(value: nil)
    let attributedContent = BehaviorRelay<NSAttributedString?>(value: nil)

    
    let avatarImage = BehaviorRelay<UIImage?>(value: nil)
    let leftImage = BehaviorRelay<UIImage?>(value: nil)
    let centerImage = BehaviorRelay<UIImage?>(value: nil)
    let rightImage = BehaviorRelay<UIImage?>(value: nil)
    
    let avatarImageUrl = BehaviorRelay<String?>(value: nil)
    let leftImageUrl = BehaviorRelay<String?>(value: nil)
    let centerImageUrl = BehaviorRelay<String?>(value: nil)
    let rightImageUrl = BehaviorRelay<String?>(value: nil)

    
    
    // 根据信号隐藏图片
    let hiddAvatar = BehaviorRelay<Bool>(value: false)
    let hideLeftImage = BehaviorRelay<Bool>(value: false)
    let hideCenterImage = BehaviorRelay<Bool>(value: false)
    let hideRightImage = BehaviorRelay<Bool>(value: false)
    
    // 是否显示分割线
    let hasBottomLine = BehaviorRelay<Bool>(value: false)
}

