//
//  MyProfileCells.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/4.
//

import UIKit

class MyProfileBaseCell: TTTableViewCell {
    override func updateUI() {
        super.updateUI()
        backgroundColor  = .white
    }
}

//MARK: - 钱包cell
class MyProfileWalletCell: MyProfileBaseCell {
    
    // 诚意，我理解为积分货币
    var integralLable = UILabel.bold(size: 24, textColor: .mainTextColor, text: "0", alignment: .center)
    
    // 红包,等同于现金
    var moneyLable = UILabel.bold(size: 24, textColor: .mainTextColor, text: "0元", alignment: .center)

    
    // 两个容器包裹一下,点击容器就响应
    let integralContainer = UIControl.init()
    let moneyContainer = UIControl.init()
    
    override func updateUI() {
        super.updateUI()
        
        let integralTips = UILabel.regular(size: 13, textColor: rgba(102, 102, 102, 1), text: "我的诚意", alignment: .center)
        
        let moneyTips = UILabel.regular(size: 13, textColor: rgba(102, 102, 102, 1), text: "我的红包", alignment: .center)
        
        let line = UIView.color(rgba(247, 247, 248, 1))
        
        self.cornerRadius  = 10
        
        addSubviews([integralContainer,line,moneyContainer])
        integralContainer.addSubviews([integralLable,integralTips])
        moneyContainer.addSubviews([moneyLable,moneyTips])

        // layout
        line.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(ver(38))
            make.top.equalTo(ver(20))
        }
        
        
        integralContainer.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(line.snp.left)
            make.bottom.equalTo(0)
        }
        
        
        integralLable.snp.makeConstraints { (make) in
            make.top.equalTo(ver(14))
            make.left.right.equalTo(0)
        }
        
        integralTips.snp.makeConstraints { (make) in
            make.centerX.equalTo(integralLable)
            make.top.equalTo(integralLable.snp.bottom).offset(ver(6))
        }
        
        moneyContainer.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(line.snp.right)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        moneyLable.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(integralLable)
        }
        
        moneyTips.snp.makeConstraints { (make) in
            make.centerX.equalTo(moneyLable)
            make.top.equalTo(moneyLable.snp.bottom).offset(ver(6))
        }
    }
}



//MARK: - 普通行cell
class MyProfileCell: MyProfileBaseCell {

    // 认证item点击，闭包传出去
    var itemClickBlock: (Int) -> () = {_ in }
    lazy var verifyView: UIView = {
        var verifyView = UIView()
        var items = [TTButton]()
        
        verifyView.backgroundColor = .green
        contentView.addSubview(verifyView)
        verifyView.snp.makeConstraints { (make) in
            make.height.equalTo(ver(45))
            make.centerY.equalTo(mainLabel)
            make.right.equalTo(subLabel)
            make.left.equalTo(mainLabel.snp.right).offset(hor(33)).priority(.low)
        }
        
        // 四个认证
        let icons = ["TTTest","TTTest","TTTest","TTTest"]
        let contents = ["手机认证","微信认证","实名认证","二维码认证"]
        for index in 0..<4 {
            let iconName = icons[index]
            let text = contents[index]
            let button = TTButton.init(text: text, iconName: iconName, type: .iconOnTheTop) {[weak self] in
                self!.itemClickBlock(index)
            }
            button.icon.snp.makeConstraints { (make) in
                make.size.equalTo(hor(30))
            }
            
            button.titleLable.font = .regular(10)
            button.titleLable.textColor = rgba(153, 153, 153, 1)
            items.append(button)
        }
        verifyView.addSubviews(items)
        items.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 0, leadSpacing: 0, tailSpacing: 0)
        return verifyView
    }()
    

    
    override func updateUI() {
        super.updateUI()
        
        stackView.addBackground(color: .white)

        // 变更下内间距
        self.edges = .init(top: 0, left: hor(11), bottom: 0, right: hor(15))
        
        contentView.addSubviews([leftImageView,mainLabel,subLabel,rightImageView])
        
        // layout
        leftImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(0)
            make.size.equalTo(ttSize(24))
        }
        
        mainLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftImageView.snp.right).offset(hor(12))
            make.centerY.equalToSuperview()
        }
        
        rightImageView.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.centerY.equalToSuperview()
            make.size.equalTo(ttSize(24))
        }
        
        subLabel.snp.makeConstraints { (make) in
            make.right.equalTo(rightImageView.snp.left).offset(hor(-6))
            make.centerY.equalToSuperview()
        }
        
        
        // config
        leftImageView.image = .init(color: .red, size: ttSize(24))
        rightImageView.image = .init(color: .red, size: ttSize(24))
        mainLabel.font = .medium(15)
        mainLabel.textColor = rgba(51, 51, 51, 1)
        
        subLabel.textColor = rgba(102, 102, 102, 1)
        subLabel.font = .regular(13)
        
    }
    
}
