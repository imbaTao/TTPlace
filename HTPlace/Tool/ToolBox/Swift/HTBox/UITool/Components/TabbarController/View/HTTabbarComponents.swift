//
//  HTTabbarSubViews.swift
//  HTPlace
//
//  Created by Mr.hong on 2020/10/29.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation
import UIKit

// itemCell
class HTTabbarItem: HTCollectionViewCell {
    // 图标
    let itemIcon = UIImageView.empty()
    
    // 内容
    let itemContent = UILabel()
    
    // 渲染模型
    var model: HTTabbarViewControllerItemModel?
    
    // badage
    lazy var badge: HTBadge = {
        var badge = HTBadge.init(edge: UIEdgeInsets.init(sameValue: 3))
        addSubview(badge)
        badge.snp.makeConstraints { (make) in
            make.right.equalTo(self.itemIcon.snp.right)
            make.top.equalTo(self.itemIcon.snp.top)
        }
        return badge
    }()
    
    // 突起视图
    lazy var tuberView: HTTbbarItemTuberView = {
        
        var tuberView = HTTbbarItemTuberView.init(drawSourceRect: CGRect.init(x: 0, y: 0, width: self.bounds.width, height: 12), drawFillColor: .white, drawBorderWidth: 0.5)
        self.contentView.addSubview(tuberView)
        tuberView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.contentView.snp.top)
            make.height.equalTo(12)
            make.width.equalTo(self.bounds.width)
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            // 遮挡用的视图
            var keepOutView = UIView.init()
            keepOutView.backgroundColor = .white
            self.contentView.addSubview(keepOutView)
            self.contentView.sendSubviewToBack(keepOutView)
            keepOutView.snp.makeConstraints { (make) in
                make.top.equalTo(baseTabbar()!.segementLine)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(baseTabbar()!.segementLine)
            }
        }
        
        
        
        return tuberView
    }()
    
    // 初始化UI
    override func setupUI() {
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        
        // 不可点击,点击事件由cell完成
        itemIcon.isUserInteractionEnabled = false;
        itemContent.textAlignment = .center
        
        contentView.addSubview(itemIcon)
        contentView.addSubview(itemContent)
        
        // layout
        itemIcon.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            
            // 默认不给size，需要UI给好图的尺寸
//            make.size.equalTo(CGSize.init(width: 25, height: 25))
            make.top.equalTo(tabbarConfiguration.iconTopInteval)
        }
        
        itemContent.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(itemIcon.snp.bottom).offset(tabbarConfiguration.spacingBetweenImageAndTitle)
        }
    }
    
    // 渲染模型
    func rendModel(_ itemModel: HTTabbarViewControllerItemModel) {
        model = itemModel
        var imageName = ""
        if itemModel.selected {
            imageName = itemModel.selectedImageName
            self.itemContent.textColor = tabbarConfiguration.selectedColor
            self.itemContent.font = tabbarConfiguration.selectedFont
        }else {
            imageName = itemModel.normalImageName
            self.itemContent.textColor = tabbarConfiguration.normalClor
            self.itemContent.font = tabbarConfiguration.normalFont
        }
        
        // 如果包含网页
        if  imageName.contains("http") {
            self.itemIcon.kf.setImage(with: URL.init(string: imageName))
        }else {
            let image = UIImage(named: imageName)
            self.itemIcon.image = image
        }
        
        // 如果没有icon
        if imageName.isEmpty {
             // layout
              itemContent.snp.remakeConstraints { (make) in
                  make.center.equalTo(self)
              }
               
           itemIcon.snp_removeConstraints()
        }
        
        
        // 如果没有内容，纯图标tabbarItem，得重新布局
        if itemModel.itemContent.isEmpty {
            // layout
               itemIcon.snp.remakeConstraints { (make) in
                   make.center.equalTo(self)
               }
                
            itemContent.snp_removeConstraints()
        }else {
                self.itemContent.text = itemModel.itemContent
        }
        
        if itemModel.isTuber {
            tuberView.isHidden = false
        }
    }
    
    // 播放动画
    func playAnimationIcon(_ iconNames: [String]) {
        // 如果为没有图片名称，那么就不执行
        guard iconNames.count == 0 else {
            return
        }
        
        var iconImages = [UIImage]()
        for i in 0...12 {
            iconImages.append(UIImage.name(iconNames[i]))
        }
        
        itemIcon.animationImages = iconImages  // 装图片的数组(需要做动画的图片数组)
        itemIcon.animationDuration = 2        // 动画时间
        itemIcon.animationRepeatCount = 1     // 重复次数 0 表示重复
        itemIcon.startAnimating()             // 开始序列帧动画
    }
}


// 通用红点标记
class HTBadge: UIView {
    
    // 背景框，随lable的内容而扩大
    var backGroundCircle = UIView()
    
    // 内容文字提示
    var contentLable = UILabel.regular(size: 10, textColor: .white);
    
    // 之前的edge
    var sourceEdge = UIEdgeInsets.zero
    init(edge: UIEdgeInsets) {
        super.init(frame: .zero)
        
        sourceEdge = edge
        
        backGroundCircle.backgroundColor = rgba(222, 10, 24, 1)
        addSubview(backGroundCircle)
        
        
        contentLable.textAlignment = .center
        addSubview(contentLable)
        
        // layout
        contentLable.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.greaterThanOrEqualTo(12)
        }
        
        backGroundCircle.snp.makeConstraints { (make) in
            make.top.equalTo(contentLable.snp.top).offset(-edge.top)
            make.left.equalTo(contentLable.snp.left).offset(-edge.left)
            make.bottom.equalTo(contentLable.snp.bottom).offset(edge.bottom)
            make.right.equalTo(contentLable.snp.right).offset(edge.right)
        }
    }
    
    // 仅显示红点
    func justRedPoint(size: CGSize) {
        self.isHidden = false
        contentLable.text = ""
    
        // 重新约束
        backGroundCircle.snp.remakeConstraints { (make) in
            make.size.equalTo(size)
            make.center.equalTo(self)
        }
        
        // 倒圆角
        backGroundCircle.settingCornerRadius(size.height / 2)
    }

    // 变更badage数量
    func changeBadgeNumb(numb: Int) {
        if numb == 0 {
            self.isHidden = true
        }else {
            self.isHidden = false
        }
        
        // 重新约束约束
        backGroundCircle.snp.remakeConstraints { (make) in
           make.top.equalTo(contentLable.snp.top).offset(-sourceEdge.top)
           make.left.equalTo(contentLable.snp.left).offset(-sourceEdge.left)
           make.bottom.equalTo(contentLable.snp.bottom).offset(sourceEdge.bottom)
           make.right.equalTo(contentLable.snp.right).offset(sourceEdge.right)
        }
        

        if numb < 100 {
            contentLable.text = "\(numb)"
        }else {
            // 大于100 显示99+
            contentLable.text = "99+"
        }
        
        self.layoutIfNeeded()
        print("\(contentLable.height)")
        
        
        // 导个圆角
        backGroundCircle.settingCornerRadius((contentLable.height + sourceEdge.top + sourceEdge.bottom) / 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// 设置突起部分视图
class HTTbbarItemTuberView: UIView {
    
    // 绘制的尺寸
    var drawSourceRect = CGRect.zero
    
    // 绘制的突起高度
//    var tuberHeight: CGFloat = 10
    
    // 绘制的填充颜色
    var drawFillColor = UIColor.white
    
    // 绘制的border粗细
    var drawBorderWidth: CGFloat = tabbarConfiguration.segementLineHeight
    
    // 绘制border的颜色
    var drawBorderColor: UIColor = tabbarConfiguration.segementLineColor
    
    init(drawSourceRect: CGRect,drawFillColor: UIColor,drawBorderWidth: CGFloat) {
        super.init(frame: drawSourceRect)
        
        print(frame)
        self.drawSourceRect = frame
//        self.tuberHeight = tuberHeight
        self.drawFillColor = drawFillColor
        self.drawBorderWidth = drawBorderWidth
        
        
        self.backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     override func draw(_ rect: CGRect) {
                super.draw(rect)
            print(rect)
//                self.backgroundColor = .white
//                self.layer.backgroundColor = UIColor.clear.cgColor
                self.drawSmoothPath()
            }
  
            func drawSmoothPath() {
                // 高度
                let offset: CGFloat = drawSourceRect.height
                
                let pointCount: Int = 2
                let pointArr:NSMutableArray = NSMutableArray.init()
                
                for i in 0...pointCount {
                    let px: CGFloat =  CGFloat(i) * CGFloat(self.bounds.width / 2)
                    var py: CGFloat = 0
                    switch i {
                    case 0:
                        py = drawSourceRect.size.height
                    case 1:
                        py = tabbarConfiguration.segementLineHeight
                    case 2:
                        py = drawSourceRect.size.height
                    case 3:
                        py = offset + 10
                    default: py = offset
                        
                    }
                    
                    let point: CGPoint = CGPoint.init(x: px, y: py)
                    pointArr.add(point)
                }
                
                let bezierPath = UIBezierPath()
                bezierPath.lineWidth = tabbarConfiguration.segementLineHeight
            
                
                var prevPoint: CGPoint!
                for i in 0 ..< pointArr.count {
                    let currPoint:CGPoint = pointArr.object(at: i) as! CGPoint
                    // 绘制平滑曲线
                    if i==0 {
                        bezierPath.move(to: currPoint)
                    }
                    else {
                        let conPoint1: CGPoint = CGPoint.init(x: CGFloat(prevPoint.x + currPoint.x) / 2.0, y: prevPoint.y)
                        let conPoint2: CGPoint = CGPoint.init(x: CGFloat(prevPoint.x + currPoint.x) / 2.0, y: currPoint.y)
                        bezierPath.addCurve(to: currPoint, controlPoint1: conPoint1, controlPoint2: conPoint2)
                    }
                    prevPoint = currPoint
                }
                
                  self.drawBorderColor.setStroke()
                   bezierPath.stroke()
                

                    
                     // 绘制直线
                   let linepath = UIBezierPath()
                   linepath.move(to: pointArr.lastObject as! CGPoint)
                   linepath.addLine(to: pointArr.firstObject as! CGPoint)
                   linepath.lineWidth = tabbarConfiguration.segementLineHeight
                   UIColor.clear.setStroke()
                   linepath.stroke()
                
                    self.drawFillColor.setFill()
                    bezierPath.fill()
            }
}
