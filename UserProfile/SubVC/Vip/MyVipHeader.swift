//
//  MyVipHeader.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/3/1.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

class MyVipHeader: View {
    var currentIndex = 0
    let container = UIImageView()
    let mainButton = UIButton.title(title: "会员还剩3天过期，立即续费", titleColor: rgba(247, 224, 181, 1), font: .medium(16))
    var recommandFlag = UILabel.regular(size: 14, textColor: .white, text: "推荐", alignment: .center)
    let seleteItemBar = TTControllSelectBar.init { (config) in
        config.unSelectedBackGroundColor = rgba(255, 255, 255, 1)
        config.selectedBorderColor = rgba(52, 48, 42, 1)
        config.selectedBackGroundColor = rgba(255, 239, 216, 1)
    }
    
    override func makeUI() {
        super.makeUI()
        addSubviews([container,mainButton,seleteItemBar,recommandFlag])
        
        let items = [MyVipPayItem(),MyVipPayItem()]
        seleteItemBar.addControls(items)
        for index in 0..<2 {
            let item = items[index]
            item.snp.makeConstraints { (make) in
                make.top.equalTo(ver(30))
                make.left.equalTo(hor(24) + CGFloat(index) * CGFloat(hor(146 + 12 )))
                make.size.equalTo(hor(146))
            }
            
            // 推荐flage
            if index == 1 {
                item.borderColor = rgba(52, 48, 42, 1)
                item.borderWidth = 1
                item.backgroundColor = rgba(255, 239, 216, 1)
                recommandFlag.snp.makeConstraints { (make) in
                    make.left.equalTo(item)
                    make.top.equalTo(item.snp.top).offset(-9)
                    make.size.equalTo(CGSize.init(width: 52, height: 25))
                }
            }
        }
        
        container.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(0)
            make.top.equalTo(0)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        seleteItemBar.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(container)
            make.height.equalTo(hor(146) + ver(30))
        }
        
        mainButton.snp.makeConstraints { (make) in
            make.size.equalTo(ttSize(304, 48))
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-30 - 12)
        }
        
        
        // config
        // 按钮渐变色放下面会死循环
       mainButton.setBackgroundImage(UIImage.gradientImage(colors: [rgba(87, 79, 66, 1),rgba(45, 41, 37, 1)], size: ttSize(304, 48),radius: 24), for: .normal)
        mainButton.circle(maskToBounds: false)
        mainButton.shadowColor = rgba(103, 63, 19, 1)
        mainButton.shadowOffset = CGSize.init(width: 1, height: 6)
        mainButton.shadowRadius = 3
        mainButton.shadowOpacity = 0.8
        
        container.isUserInteractionEnabled = true
        // 推荐flag
        recommandFlag.backgroundColor = rgba(52, 48, 42, 1)
    }

    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
//        // 容器渐变色
        container.image = UIImage.gradientImage(colors: [rgba(242, 209, 141, 1),rgba(229, 169, 102, 1)], size: ttSize(351, 279), radius: 14)
        
        recommandFlag.roundCorners([.topLeft,.topRight,.bottomRight], radius: 6)
      
    }
    
    
    class MyVipPayItem: UIButton {
        var timeLabel = UILabel.medium(size: 18, textColor: rgba(185, 156, 91, 1), text: "10天", alignment: .center, numberOfline: 1)
        var moneyLabel = UILabel.medium(size: 18, textColor: rgba(135, 88, 28, 1), text: "￥10.00", alignment: .center, numberOfline: 1)
        var tipsLabel = UILabel.regular(size: 13, textColor: rgba(185, 156, 91, 1), text: "仅1元/天", alignment: .center, numberOfline: 1)
        
   
        
        override init(frame: CGRect) {
            super.init(frame: .zero)
            addSubviews([timeLabel,moneyLabel,tipsLabel])
            
            
            
            timeLabel.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.bottom.equalTo(moneyLabel.snp.top).offset(-6)
            }
            
            moneyLabel.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            
            tipsLabel.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(moneyLabel.snp.bottom).offset(6)
            }
            
            
//            rx.isSelectedBorderColor
            
            backgroundColor = .white
            
        }
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        
        override func layoutSublayers(of layer: CALayer) {
            super.layoutSublayers(of: layer)

            settingCornerRadius(14, false)
            
        }
    }
    
    
    
}


//MARK: - 扩展rx方法,按钮未选中颜色
extension Reactive where Base: UIButton {
    
    /*
        button isEnable与否的两种情况下对应的 backgroudColor
     */
    public var vipIsSelectedColor: Binder<Bool> {
        return Binder(self.base) { control, value in
            control.backgroundColor = value ? rgba(255, 239, 216, 1) : .white
        }
    }
    
    
    // 选中的border
    public var vipIsSelectedBorderColor: Binder<Bool> {
        return Binder(self.base) { control, value in
            control.borderColor =  value ? rgba(52, 48, 42, 1) : .clear
            control.borderWidth = 1
        }
    }
}

