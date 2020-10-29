//
//  HTButton.swift
//  HTPlace
//
//  Created by Mr.hong on 2020/10/29.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
enum HTButtonType {
    case navBarLeftItem
    case navBarRightItem
}


// 仿系统button
class HTButton: UIControl {
    
    // 父视图
    let contentView = UIStackView()
    
    // 图标
    let icon = UIImageView.empty()
    
    // 内容
    let titleLable = UILabel.regular(size: 12, textColor: .black)

    // 文字图片之间的间隔
    var intervalBetweenIconAndText: CGFloat = 5
    
    
    
    
    // 根据名字初始化
    init(text: String,iconName: String, type: HTButtonType,interval: CGFloat,clickAction: @escaping ()->()) {
        super.init(frame: .zero)
        
        
        // 赋值间距
        intervalBetweenIconAndText = interval
        
        // 赋值图片
        icon.image = .name(iconName)
        
        // 图片不可以被拉伸
        icon.setContentHuggingPriority(.required, for: .horizontal)
        icon.setContentHuggingPriority(.required, for: .vertical)
   
        titleLable.text = text
        
        // 设置false 不然无法点击
        contentView.isUserInteractionEnabled = false
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // 添加布局
        contentView.addArrangedSubview(icon)
        contentView.addArrangedSubview(titleLable)
        
        // 布局
        layoutWithType(type: type)
        
        // 点击事件直接返回出去
        self.rx.controlEvent(.touchUpInside).subscribe(onNext: {(_) in
            clickAction()
        }).disposed(by: rx.disposeBag)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutWithType(type: HTButtonType) {
        switch type {
            case .navBarLeftItem:
                contentView.axis = .horizontal
                contentView.distribution = .equalCentering
                contentView.spacing = 5
                contentView.backgroundColor = .red
                   
            
            
                // 导航栏的item，贴边,贴左边或右边
//                icon.snp.makeConstraints { (make) in
////                    make.left.equalToSuperview()
//                    make.centerY.equalToSuperview()
//                }
//
//                titleLable.snp.makeConstraints { (make) in
////                    make.left.equalTo(icon.snp.right).offset(intervalBetweenIconAndText)
//                    make.centerY.equalToSuperview()
//                }
              case .navBarRightItem:
                    // 导航栏的item，贴边,贴左边或右边
                   icon.snp.makeConstraints { (make) in
                       make.right.equalToSuperview()
                       make.centerY.equalToSuperview()
                   }
                   
                   titleLable.snp.makeConstraints { (make) in
                       make.right.equalTo(icon.snp.left).offset(-intervalBetweenIconAndText)
                       make.centerY.equalToSuperview()
                   }
        }
    }
}
