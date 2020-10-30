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
    case iconOnTheTop
    case iconOnTheLeft
    case iconOnTheBottom
    case iconOnTheRight
    
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
        
        self.backgroundColor = .red
        
        // 赋值间距
        intervalBetweenIconAndText = interval
        
        // 赋值图片
        icon.image = .name(iconName)
        
        // 图片不可以被拉伸
//        icon.setContentHuggingPriority(.required, for: .horizontal)
//        icon.setContentHuggingPriority(.required, for: .vertical)
        
        // 赋值内容
        titleLable.text = text
        
        
        // 默认设置无法被拉伸,只可以内部自己撑开
//         contentView.contentHuggingPriority(for: .horizontal)
//         contentView.setContentHuggingPriority(.required, for: .horizontal)
        
        // 设置false 不然无法点击
        contentView.isUserInteractionEnabled = false
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // 布局
        layoutWithType(type: type)
        
        
        
        
        // 点击事件直接用闭包返回出去,方便书写
        self.rx.controlEvent(.touchUpInside).subscribe(onNext: {(_) in
            clickAction()
        }).disposed(by: rx.disposeBag)
        
        
        
        
//        let longPress = UILongPressGestureRecognizer.init()
//        self.rx.lon
        
        
//        self.addTarget(self, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        
//        self.rx.controlEvent(.touchUpInside).subscribe(onNext: {(_) in
//                   clickAction()
//               }).disposed(by: rx.disposeBag)
        
        // 监听状态变化
//        self.rx.observe(State.self, "state").subscribe(onNext: { value in
////            print("new address is \(value)")
//
//            if let state = value {
//                switch state {
//                case .normal:
//                    print("正常状态")
//                case .selected:
//                     print("选中了")
//                case .highlighted:
//                    print("高亮了")
//                default:
//                     print("无状态")
//                }
//            }
//
//
//
//
//
//
////            print("\(value)")
//        }).disposed(by: rx.disposeBag)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutWithType(type: HTButtonType) {
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
            contentView.distribution = .fillProportionally
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
            contentView.distribution = .equalCentering
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
