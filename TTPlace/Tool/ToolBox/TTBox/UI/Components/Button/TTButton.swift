//
//  TTButton.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/10/29.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
enum TTButtonType {
    case navBarLeftItem
    case navBarRightItem
    case iconOnTheTop
    case iconOnTheLeft
    case iconOnTheBottom
    case iconOnTheRight
    case onlyText
    case onlyIcon
}


// 仿系统button
class TTButton: UIControl {
    
    // 主内容
    let contentView = UIStackView()
    
    
    lazy var containerView: UIView = {
        var containerView = UIView()
        contentView.addArrangedSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        return containerView
    }()
    
    // 图标
    let icon = UIImageView.empty()
    
    // 背景图
    let backGroundIcon = UIImageView.empty()
    
    // 内容
    let titleLable = UILabel.regular(size: 12, textColor: .black)
    
    // 文字图片之间的间隔
    var intervalBetweenIconAndText: CGFloat = 5
    
    //  子视图间距
    var insideEdges = UIEdgeInsets.zero
    
    // 根据名字初始化
    init(text: String = "",textColor: UIColor = .white,backgourndColor: UIColor = .clear,font: UIFont = .regular(15),iconName: String = "",backGroundIconName: String = "", type: TTButtonType,intervalBetweenIconAndText: CGFloat = 5,edges: UIEdgeInsets = .zero,insideEdges: UIEdgeInsets = .zero,height: CGFloat? = nil,cornerRadius: CGFloat = 0,clickAction: ( ()->())? = nil) {
        super.init(frame: .zero)
        
        self.insideEdges = insideEdges
    
        // 如果有背景色
        if backGroundIconName.count > 0 {
            addSubview(backGroundIcon)
            backGroundIcon.image = UIImage.name("")
            backGroundIcon.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        
        // 赋值间距
        self.intervalBetweenIconAndText = intervalBetweenIconAndText
        
        // 赋值图片
        icon.image = .name(iconName)
        
        // 图片不可以被拉伸
        icon.setContentHuggingPriority(.required, for: .horizontal)
        icon.setContentHuggingPriority(.required, for: .vertical)
        
        // 赋值内容
        titleLable.text = text
        titleLable.textColor = textColor
        titleLable.font = font
        
        // 背景色
        self.backgroundColor = backgourndColor
        
        // 默认设置无法被拉伸,只可以内部自己撑开
//         contentView.contentHuggingPriority(for: .horizontal)
//         contentView.setContentHuggingPriority(.required, for: .horizontal)
        
        // 设置false 不然无法点击
        contentView.isUserInteractionEnabled = false
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(edges)
        }
        
        if height != nil {
            self.snp.makeConstraints { (make) in
                make.height.equalTo(height!)
            }
        }
    
        
        // 布局
        layoutWithType(type: type)
        

        // 点击事件直接用闭包返回出去,方便书写
        if clickAction != nil {
            self.rx.controlEvent(.touchUpInside).subscribe(onNext: {(_) in
                clickAction!()
            }).disposed(by: rx.disposeBag)
        }
    
        
        // 如果有圆角
        if cornerRadius > 0 {
            self.cornerRadius = cornerRadius
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutWithType(type: TTButtonType) {
        switch type {
        case .navBarLeftItem:
            contentView.axis = .horizontal
            contentView.distribution = .equalCentering
            contentView.spacing = intervalBetweenIconAndText
            
            // 纵轴的排列方式
            contentView.alignment = .center
            
            // 添加布局
            contentView.addArrangedSubview(icon)
            contentView.addArrangedSubview(titleLable)
        case .navBarRightItem:
            contentView.axis = .horizontal
            contentView.distribution = .equalCentering
            contentView.spacing = intervalBetweenIconAndText
            contentView.alignment = .center
            
            // 添加布局
            contentView.addArrangedSubview(titleLable)
            contentView.addArrangedSubview(icon)
        case .iconOnTheTop:
            contentView.axis = .vertical
            contentView.distribution = .fill
            contentView.spacing = intervalBetweenIconAndText
            contentView.alignment = .center
            
            // 添加布局
            contentView.addArrangedSubview(icon)
            contentView.addArrangedSubview(titleLable)
            
        case .iconOnTheBottom:
            contentView.axis = .vertical
            contentView.distribution = .fillProportionally
            contentView.spacing = intervalBetweenIconAndText
            contentView.alignment = .center
            
            // 添加布局
            contentView.addArrangedSubview(titleLable)
            contentView.addArrangedSubview(icon)
        case .iconOnTheLeft:
            contentView.axis = .horizontal
//            contentView.distribution = .equalCentering
            contentView.spacing = intervalBetweenIconAndText
            
            // 纵轴的排列方式
            contentView.alignment = .center
            
            // 添加布局
            contentView.addArrangedSubview(icon)
            contentView.addArrangedSubview(titleLable)
        case .iconOnTheRight:
            contentView.axis = .horizontal
            contentView.distribution = .equalCentering
            contentView.spacing = intervalBetweenIconAndText
            contentView.alignment = .center
            
            // 添加布局
            contentView.addArrangedSubview(titleLable)
            contentView.addArrangedSubview(icon)
        case .onlyText:
            
            contentView.distribution = .fill
            
            // 添加布局
//            contentView.addArrangedSubview(titleLable)

            contentView.snp.remakeConstraints { (make) in
                make.edges.equalToSuperview()
            }
            
            containerView.addSubview(titleLable)

            containerView.snp.remakeConstraints { (make) in
                make.center.equalToSuperview()
            }
            
            titleLable.snp.makeConstraints { (make) in
                make.edges.equalTo(insideEdges)
            }
        case .onlyIcon:
//            contentView.axis = .horizontal
//            contentView.distribution = .fillProportionally
//            contentView.alignment = .center
//
//            // 添加布局
//            contentView.addArrangedSubview(icon)
            addSubview(icon)
            icon.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
        }
    }
    
    // 反正在这个视图
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        // 判断点是否在范围内
////        if CGRect.contains(CGRect.init(origin: point, size: self.bounds.size)) {
////            return true
////        }
//
//
////        if (CGRectContainsPoint(CGRectInset(self.bounds, -20, -20), point)) {
////            return YES;
////        }
//        return false;
//    }
}


extension UIButton {
    func title(_ title: String) {
        setTitle(title, for: .normal)
    }
}
