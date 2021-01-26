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
import Kingfisher
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
    init(text: String = "",textColor: UIColor = .white,backgourndColor: UIColor = .clear,font: UIFont = .regular(15),iconName: String = "",iconImage: UIImage? = nil,backGroundIconName: String = "",backGroundIconImage: UIImage? = nil, type: TTButtonType,intervalBetweenIconAndText: CGFloat = 5,edges: UIEdgeInsets = .zero,insideEdges: UIEdgeInsets = .zero,height: CGFloat? = nil,cornerRadius: CGFloat = 0,clickAction: ( ()->())? = nil) {
        super.init(frame: .zero)
        
        self.insideEdges = insideEdges
    
        if backGroundIconImage != nil {
            backGroundIcon.image = backGroundIconImage!
            addSubview(backGroundIcon)
            backGroundIcon.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }else {
            // 如果有背景色
            if backGroundIconName.count > 0 {
                addSubview(backGroundIcon)
                backGroundIcon.image = UIImage.name("")
                backGroundIcon.snp.makeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
            }
        }
        
        
        
        // 赋值间距
        self.intervalBetweenIconAndText = intervalBetweenIconAndText
        
        
        // 有图片直接赋值
        if iconImage != nil {
            icon.image = iconImage!
        }else {
            if iconName.contains(".gif") {
                if let path = Bundle.main.path(forResource:iconName,ofType: "gif") {
                    let url = URL(fileURLWithPath: path)
    //                let p = locaf
    //                let provider = LocalFileImageDataProvider(fileURL: url)
    //                icon.kf.setImage(with: provider)
                }
                
            }else {
                // 赋值图片
                icon.image = .name(iconName)
            }
        }
        
     
   
        
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
            titleLable.textAlignment = .center
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
        
        
        self.addObserver(self, forKeyPath: "state", options: [.new,.old], context: nil)
        
    }
    
    override class func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "state" {
            print(change.value)
        }
    }

    
    
    func setTitle(_ title: String?, for state: UIControl.State) {
        let button = UIButton.init()
        
        
        
//        open func setTitle(_ title: String?, for state: UIControl.State) // default is nil. title is assumed to be single line
//
//        open func setTitleColor(_ color: UIColor?, for state: UIControl.State) // default is nil. use opaque white
//
//        open func setTitleShadowColor(_ color: UIColor?, for state: UIControl.State) // default is nil. use 50% black
//
//        open func setImage(_ image: UIImage?, for state: UIControl.State) // default is nil. should be same size if different for different states
//
//        open func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) // default is nil
//
//        @available(iOS 13.0, *)
//        open func setPreferredSymbolConfiguration(_ configuration: UIImage.SymbolConfiguration?, forImageIn state: UIControl.State)
//
//        @available(iOS 6.0, *)
//        open func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State) // default is nil. title is assumed to be single line
//
//
//        open func title(for state: UIControl.State) -> String? // these getters only take a single state value
//
//        open func titleColor(for state: UIControl.State) -> UIColor?
//
//        open func titleShadowColor(for state: UIControl.State) -> UIColor?
//
//        open func image(for state: UIControl.State) -> UIImage?
//
//        open func backgroundImage(for state: UIControl.State) -> UIImage?
//
//        @available(iOS 13.0, *)
//        open func preferredSymbolConfigurationForImage(in state: UIControl.State) -> UIImage.SymbolConfiguration?
//
//        @available(iOS 6.0, *)
//        open func attributedTitle(for state: UIControl.State) -> NSAttributedString?
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
