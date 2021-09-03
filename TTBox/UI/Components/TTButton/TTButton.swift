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
    case iconOnTheTop
    case iconOnTheLeft
    case iconOnTheBottom
    case iconOnTheRight
    case justText
    case justIcon
    case doubleText
}


// 仿系统button
class TTButton: UIControl {

    // 自动扩充size视图
    let autoSizeView = TTAutoSizeView.init(padding: .zero)
    
    // 图标
    let icon = FLAnimatedImageView.empty()
    
    // 背景图
    lazy var backGroundIcon: UIImageView = {
        var backGroundIcon = UIImageView.empty()
        addSubview(backGroundIcon)
        backGroundIcon.snp.makeConstraints {(make) in
            make.edges.equalToSuperview()
        }
        sendSubviewToBack(backGroundIcon)
        return backGroundIcon
    }()
    
    // 内容
    let titleLable = UILabel.regular(size: 12, textColor: .black)
    
    // 子标题
    let subTitleLable = UILabel.regular(size: 12, textColor: .black)
    
    // 文字图片之间的间隔
    var intervalBetweenIconAndText: CGFloat = 5
    
    //  内间距
    var padding = UIEdgeInsets.zero
    
    // 扩大点击区域
    var increaseClickSize: CGSize?
    
    
    // 根据状态获取参数字典
    private var stateParameter = [String : Any]()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        makeUI()
    }
    
    func makeUI() {
        
        
    }
    
    
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        if let clickSize = increaseClickSize {
//            let rect = CGRect.init(x: point.x - clickSize.width / 2, y:point.y - clickSize.height / 2, width: clickSize.width, height: clickSize.height)
//            return rect.contains(point)
//        }else {
//            return super.point(inside: point, with: event)
//        }
//    }


    

    // 根据名字初始化
    init(text: String = "",textColor: UIColor = .white,subText: String = "",subTextColor: UIColor = .gray,backgourndColor: UIColor = .clear,font: UIFont = .regular(15),subTextFont:  UIFont = .regular(12),iconName: String = "",iconImage: UIImage? = nil,backGroundIconName: String = "",backGroundIconImage: UIImage? = nil, type: TTButtonType,intervalBetweenIconAndText: CGFloat = 5,padding: UIEdgeInsets = .zero,height: CGFloat? = nil,cornerRadius: CGFloat = 0,gifImageSize: CGSize = .zero,clickAction: ( ()->())? = nil) {
        super.init(frame: .zero)
        
        self.padding = padding

        // 赋值间距
        self.intervalBetweenIconAndText = intervalBetweenIconAndText
        
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
        

        
        // 有图片直接赋值
        if iconImage != nil {
            icon.image = iconImage!
        }else {
           
        }
        
        if iconName.count > 0 {
            icon.image = UIImage.name(iconName)
        }
        
        // 如果GIFImageSize > 0那么重新赋值约束
        if gifImageSize.width > 0 {
            setGiftImage(iconName, gifImageSize: gifImageSize)
        }
        icon.setContentHuggingPriority(.required, for: .horizontal)
        
        
        // 赋值间距
        self.intervalBetweenIconAndText = intervalBetweenIconAndText
        

        // 赋值内容
        titleLable.text = text
        titleLable.textColor = textColor
        titleLable.font = font
        
        subTitleLable.text = subText
        subTitleLable.textColor = subTextColor
        subTitleLable.font = subTextFont
        
        
        // 背景色
        self.backgroundColor = backgourndColor
        
        // 设置false 不然无法点击
        autoSizeView.isUserInteractionEnabled = false
        addSubview(autoSizeView)
        autoSizeView.snp.makeConstraints { (make) in
            make.edges.equalTo(padding)
        }
        
//        if height != nil {
//            self.snp.makeConstraints { (make) in
//                make.height.equalTo(height!)
//            }
//        }
//
        
        // 布局
        layoutWithType(type: type)
        
        // 如果有圆角
        if cornerRadius > 0 {
            self.cornerRadius = cornerRadius
        }
        
        // 点击事件直接用闭包返回出去,方便书写
        if clickAction != nil {
            self.rx.controlEvent(.touchUpInside).subscribe(onNext: {(_) in
                clickAction!()
            }).disposed(by: rx.disposeBag)
        }
    }
    
        // 根据名字初始化
         init(text: String = "",textColor: UIColor = .white,font: UIFont = .regular(15),iconImage: UIImage? = nil,backGroundIconImage: UIImage? = nil, type: TTButtonType,intervalBetweenIconAndText: CGFloat = 5,padding: UIEdgeInsets = .zero) {
            super.init(frame: .zero)
            self.padding = padding
        
            // 添加背景图
            if backGroundIconImage != nil {
                backGroundIcon.image = backGroundIconImage!
            }

            // 赋值间距
            self.intervalBetweenIconAndText = intervalBetweenIconAndText
            
            // 有图片直接赋值
            if iconImage != nil {
                icon.image = iconImage!
            }
            
            // 赋值内容
            titleLable.text = text
            titleLable.textColor = textColor
            titleLable.font = font
            
            // 设置false 不然无法点击,底视图是controll响应点击
            autoSizeView.isUserInteractionEnabled = false
            addSubview(autoSizeView)
            autoSizeView.snp.makeConstraints { (make) in
                make.edges.equalTo(padding)
            }
            
            // 布局
            layoutWithType(type: type)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    
    func layoutWithType(type: TTButtonType) {
        // 根据情况添加视图
        autoSizeView.t_addSubViews([icon,titleLable])
        
        switch type {
        case .iconOnTheTop:
            icon.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
            }
            
            titleLable.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(icon.snp.bottom).offset(intervalBetweenIconAndText)
                make.bottom.equalToSuperview()
            }
            
            titleLable.textAlignment = .center
        case .iconOnTheBottom:
            titleLable.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.centerX.equalToSuperview()
            }
            
            icon.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(titleLable.snp.bottom).offset(intervalBetweenIconAndText)
                make.bottom.equalToSuperview()
            }
            
            titleLable.textAlignment = .center
        case .iconOnTheLeft:
            
            icon.contentMode = .scaleAspectFit
            
            icon.snp.makeConstraints { (make) in
                make.top.left.bottom.equalToSuperview()
            }
            
            titleLable.snp.makeConstraints { (make) in
                make.top.bottom.right.equalToSuperview()
                make.left.equalTo(icon.snp.right).offset(intervalBetweenIconAndText)
            }
            
            titleLable.textAlignment = .right
        case .iconOnTheRight:
            icon.contentMode = .scaleAspectFit
            titleLable.snp.makeConstraints { (make) in
                make.top.left.bottom.equalToSuperview()
                make.right.equalTo(icon.snp.left).offset(-intervalBetweenIconAndText)
            }
            
            icon.snp.makeConstraints { (make) in
                make.top.bottom.right.equalToSuperview()
                make.left.equalTo(titleLable.snp.right).offset(intervalBetweenIconAndText)
            }
            
            titleLable.textAlignment = .left
        case .justText:
            icon.removeFromSuperview()
            titleLable.textAlignment = .center
            titleLable.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        case .justIcon:
            titleLable.removeFromSuperview()
            icon.snp.makeConstraints { (make) in
//                make.edges.equalToSuperview()
                make.center.equalToSuperview()
                make.size.lessThanOrEqualToSuperview()
            }
        case .doubleText:
            autoSizeView.t_addSubViews([subTitleLable])
            icon.removeFromSuperview()
            titleLable.snp.makeConstraints { (make) in
                make.left.top.right.equalToSuperview()
            }
            subTitleLable.snp.makeConstraints { (make) in
                make.top.equalTo(titleLable.snp.bottom).offset(intervalBetweenIconAndText)
                make.left.right.bottom.equalToSuperview()
            }
        default:break
        }
        
        
        // 添加点击事件
        rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            debugPrint("点击了按钮")
            
            // 反选按钮
            self.isSelected = true
            

     
        }).disposed(by: rx.disposeBag)
        
        
        
        
//        self.rx.observe(self.isSelected, <#T##keyPath: String##String#>)
         
//        self.addObserver(self, forKeyPath: "selected", options: [.old,.new], context: nil)
    }
    
    
    
//    override class func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        
//        
//        
//        print("12312")
//        
//        if keyPath == "selected" {
//            
//        }
//        
//        if keyPath == "state" {
//            print(change.value)
//        }
//        
//        print(change.value)
//    }

    
    override var isSelected: Bool {
        didSet {
            // 根据不同状态的key
            var titleKey = ""
            var imageKey = ""
            
            // 如果选中
            if self.isSelected {
                titleKey = "selectedTitle"
                imageKey = "selectedImage"
            }else {
                titleKey = "normalTitle"
                imageKey = "normalImage"
            }
            

            if let title = self.stateParameter[titleKey] as? String  {
                self.titleLable.text = title
            }
            
            if let image = self.stateParameter[imageKey] as? UIImage {
                self.icon.image = image
            }
            
            
            
        }
    }

    
    // 设置icon
    func setImage(_ image: UIImage?, for state: UIControl.State)  {
        var key = ""
        switch state {
        case .normal:
            key = "normalImage"
        case .selected:
            key = "selectedImage"
        default:
            break
        }
  
        stateParameter[key] = image
        
        switch state {
        case .normal:
            icon.image = image
        default:
            break
        }
    }
    
    
    func setTitle(_ title: String?, for state: UIControl.State) {
        var key = ""
        switch state {
        case .normal:
            key = "normalTitle"
        case .selected:
            key = "selectedTitle"
        default:
            break
        }
        
     
        stateParameter[key] = title
        
        switch state {
        case .normal:
            titleLable.text = title
        default:
            break
        }
    }
    
    // MARK: - 设置gif图片
    func setGiftImage(_ iconName: String,gifImageSize: CGSize) {
//        let pathExtention = iconName.pathExtension
//        if pathExtention == "gif" {
//
//            if let path = Bundle.main.path(forResource:iconName,ofType: "") {
//                let imageData = NSData(contentsOfFile: path) as Data?
//                let image = FLAnimatedImage.init(animatedGIFData: imageData)
//
//                icon.animatedImage = image
//
//                // gift size 确定
//                icon.snp.remakeConstraints { (make) in
//                    if icon.superview != nil {
//                        make.left.equalToSuperview()
//                        make.centerY.equalToSuperview()
//                    }
//                    make.size.equalTo(gifImageSize)
//                }
//            }
            
            icon.snp.remakeConstraints { (make) in
                 if icon.superview != nil {
                     make.left.equalToSuperview()
                     make.centerY.equalToSuperview()
                 }
                 make.size.equalTo(gifImageSize)
             }
//        }else {
//            // 赋值图片
//            icon.image = .name(iconName)
//        }
    }
    
    
}


extension UIImage {
    // 获取gif图
   class func fetchGiftImage(_ iconName: String) -> FLAnimatedImage? {
        let pathExtention = iconName.pathExtension
        if pathExtention == "gif" {
            if let path = Bundle.main.path(forResource:iconName,ofType: "") {
                let imageData = NSData(contentsOfFile: path) as Data?
                let image = FLAnimatedImage.init(animatedGIFData: imageData)
                return image
            }
        }
        return nil
    }
}


extension UIButton {
    func title(_ title: String) {
        setTitle(title, for: .normal)
    }
}
