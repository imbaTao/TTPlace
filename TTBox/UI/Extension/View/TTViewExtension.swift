//
//  TTViewExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/24.
//  Copyright © 2020 刘超. All rights reserved.
//

import Foundation
extension UIView {
    // 倒圆角
    func settingCornerRadius(_ radius: CGFloat,_ maskToBounds: Bool = true) {
       self.layer.cornerRadius = radius
       self.layer.masksToBounds = maskToBounds
    }
    

    
    
    class func color(_ color: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = color
        return view
    }
    
    // 获取一个容器
    class func fetchContainerViewWithRadius(radius: CGFloat,color: UIColor,size: CGSize) -> UIView {
        let view = UIView()
        if radius > 0 {
            return fetchImageViewContainerViewWithRadius(radius: radius, color: color, size: size)
        }else{
            view.backgroundColor = color
        }
        view.size = size
        
        // 这样写,并不会引起离屏渲染,同时设置maskTobounds才会T
        view.layer.cornerRadius = radius
        return view
    }
    
    
    // 获取一个ImageView容器,不会离屏渲染
     class func fetchImageViewContainerViewWithRadius(radius: CGFloat,color: UIColor,size: CGSize) -> UIImageView {
        let view = UIImageView.empty()
        view.isUserInteractionEnabled = true

        if radius > 0 {
//            if let image = UIImage.init(color: color,size: size)?.byRoundCornerRadius(radius) {
//                view.image = image
//            }
        }else {
            view.backgroundColor = color
        }
        view.size = size
        view.layer.cornerRadius = radius
        return view
    }
    
    
    //MARK: - 导一半圆角
    func circle() {
        self.rx.methodInvoked(#selector(layoutSublayers(of:))).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            self.cornerRadius = self.size.height / 2.0
        }).disposed(by: rx.disposeBag)
    }
    
    func circle(maskToBounds: Bool) {
        self.rx.methodInvoked(#selector(layoutSublayers(of:))).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            self.settingCornerRadius(self.size.height / 2.0, maskToBounds)
        }).disposed(by: rx.disposeBag)
    }
    
    //MARK: - 导一半圆角，且设置boder
    func circleAndBorder(borderColor: UIColor,borderWidth: CGFloat = 1.0) {
        self.rx.methodInvoked(#selector(layoutSublayers(of:))).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            self.settingCornerRadius(self.size.height / 2.0, false)
            
            self.borderColor = borderColor
            self.borderWidth = borderWidth
        }).disposed(by: rx.disposeBag)
    }
    
    
    // 为视图添加层叠阴影
    func addShadow(superView: UIView,belowView: UIView,ofColor color: UIColor = UIColor(red: 0.07, green: 0.47, blue: 0.57, alpha: 1.0),cornerRadius: CGFloat = 0, shadowRadius: CGFloat = 3, offset: CGSize = .zero, opacity: Float = 0.5) {
        let subLayer = CALayer()
        subLayer.frame = belowView.frame
        subLayer.cornerRadius = cornerRadius
        subLayer.shadowColor = color.cgColor
        subLayer.shadowOffset = offset
        subLayer.shadowRadius = shadowRadius
        subLayer.shadowOpacity = opacity
        subLayer.masksToBounds = false
        subLayer.backgroundColor = UIColor.black.cgColor
        superView.layer.insertSublayer(subLayer, below: belowView.layer)
    }
}


extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

// 默认分割线颜色
var segementColor = #colorLiteral(red: 0.6901960784, green: 0.6901960784, blue: 0.6901960784, alpha: 1)

// 默认系统弹框按钮颜色
var alertButtonColor =  #colorLiteral(red: 0.01176470588, green: 0.4784313725, blue: 1, alpha: 1)


enum TTViewBorderDirection {
    case top
    case left
    case bottom
    case right
}

extension UIView {
    
    // 这个是简单的内边框,外边框还没实现
    func addBorderWithPositon(direction: TTViewBorderDirection,leftAndRightSpace: CGFloat = 0,color: UIColor,height: CGFloat) {
        let mborderView = UIView.init()
        mborderView.backgroundColor = color
        
        self.addSubview(mborderView)
        
        
        switch direction {
        case .top:
            mborderView.snp.makeConstraints { (make) in
                make.top.equalTo(0)
                make.left.right.equalToSuperview().inset(leftAndRightSpace)
                make.height.equalTo(height)
            }
        case .left:
            mborderView.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.top.bottom.equalToSuperview().inset(leftAndRightSpace)
                make.width.equalTo(height)
            }
        case .bottom:
            mborderView.snp.makeConstraints { (make) in
                make.bottom.equalTo(0)
                make.height.equalTo(height)
                make.left.right.equalToSuperview().inset(leftAndRightSpace)
            }
        case .right:
            mborderView.snp.makeConstraints { (make) in
                make.right.equalTo(0)
                make.top.bottom.equalToSuperview().inset(leftAndRightSpace)
                make.width.equalTo(height)
            }
        }
    }
    
    
   
}

extension UILabel {
    // 添加,垂直居中的横线,inteval居中偏移量
    func addCenterYLine(color: UIColor,width: CGFloat = hor(92),height: CGFloat = 1,inteval: CGFloat = hor(5)) {
        
//        self.clipsToBounds = false
//        self.layer.masksToBounds = false
        
        

        var leftAndRightEdge: CGFloat = 0
        if self.text?.count ?? 0 > 0 {
            
            let attText = NSMutableAttributedString.init(string: self.text ?? "")
//            attText.font = self.font
            
//            if let textWidth = YYTextLayout.init(container: YYTextContainer.init(size: ttSize(SCREEN_W, 300)), text: NSAttributedString.init(string: self.text ?? ""))?.textBoundingSize.width  {
//                
//                print(textWidth)
//                 leftAndRightEdge = (SCREEN_W - textWidth - width * 2 - inteval * 2 ) / 2
//            }
        }
          
        for index in 0..<2 {
            let lineView = UIView.init()
            lineView.backgroundColor = color
            self.addSubview(lineView)
            
            if index == 0 {
                lineView.snp.makeConstraints { (make) in
                    make.centerY.equalTo(self)
                    make.width.equalTo(width)
                    make.left.equalTo(leftAndRightEdge)
                    make.height.equalTo(height)
                }
            }else {
                lineView.snp.makeConstraints { (make) in
                    make.centerY.equalTo(self)
                    make.width.equalTo(width)
                    make.right.equalTo(-leftAndRightEdge)
                    make.height.equalTo(height)
                }
            }
        }
    }
}

