//
//  MyProfileUploadWechatQRCodeVC.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/8.
//

import UIKit


class MyProfileUploadWechatQRCodeVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let list = TTStaticList()
        addSubview(list)
        list.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        
        let headerItem = HeaderItem()
        headerItem.snp.makeConstraints { (make) in
            make.size.equalTo(ttSize(SCREEN_W, ver(317)))
        }
        
        list.appendItems(items: [headerItem])
        
        // 富文本
        let contents = ["第一步：微信打开「我的」页面","第二步：点开「我的二维码」","第三步：截屏「我的二维码」页面，完成"]
        let images = [UIImage.testImage(),UIImage.testImage(),UIImage.testImage()]
        
        for index in 0..<3 {
            let attText = NSMutableAttributedString.init(string: contents[index])
            attText.font = .medium(14)
            attText.color = .mainTextColor
            switch index {
            case 0:
                attText.setColor(rgba(143, 64, 246, 1), range: .init(location: 9, length: 2))
            case 1:
                attText.setColor(rgba(143, 64, 246, 1), range: .init(location: 7, length: 4))
            case 2:
                attText.setColor(rgba(143, 64, 246, 1), range: .init(location: 7, length: 5))
            default:break
            }
            let stepItem = StepItem.init(attText: attText, image: images[index])
            stepItem.snp.makeConstraints { (make) in
                make.size.equalTo(ttSize(SCREEN_W, 389 + 24))
            }
            list.appendItems(items: [stepItem])
        }
        
        
        // config
        headerItem.itemclick = {
            
        }
    }
    
    
    // 私有类，头部部分
   private class HeaderItem: TTStaticListSectionItem {
        var backGroundView = UIImageView.init(image: .testImage())
        var addButton = UIButton.iconName("TTTest")
        var tips = UILabel.medium(size: 16, textColor: .mainTextColor, text: "上传微信二维码", alignment: .center)
    
        // 操作方法,灰色面板,也放在头部
        var tips2 = UILabel.medium(size: 16, textColor: rgba(51, 51, 51, 1), text: "操作方法", alignment: .center)
    
        override init(frame: CGRect) {
            super.init(frame: .zero)
            addSubview(backGroundView)
            backGroundView.addSubview(addButton)
            backGroundView.addSubview(tips)
            addSubview(tips2)
            
            // layout
            backGroundView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(ver(36))
                make.size.equalTo(ttSize(169))
            }
            
            addButton.snp.makeConstraints { (make) in
                make.top.equalTo(ver(28))
                make.centerX.equalToSuperview()
                make.size.equalTo(ttSize(72))
            }
            
            tips.snp.makeConstraints { (make) in
                make.top.equalTo(addButton.snp.bottom).offset(ver(21))
                make.centerX.equalToSuperview()
            }
            
            tips2.snp.makeConstraints { (make) in
                make.left.right.equalTo(0)
                make.height.equalTo(ver(76))
                make.bottom.equalToSuperview()
            }
            
            // config
            backgroundColor = .white
            backGroundView.backgroundColor = .gray
            addButton.cornerRadius = hor(72 / 2)
            
//            tips2.addBorderWithPositon(direction: .bottom, color: rgba(187, 187, 187, 1), height: 1)

            tips2.addCenterYLine(color: rgba(187, 187, 187, 1), height: 1, inteval: hor(15))
            tips2.backgroundColor = rgba(247, 247, 248, 1)
         }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    
    
    // 步骤item
    private class StepItem: TTStaticListSectionItem {
        override func setupItem() {
            super.setupItem()
            addSubviews([mainLabel,leftImageView])
                
            mainLabel.snp.makeConstraints { (make) in
                make.left.equalTo(hor(12))
                make.top.equalTo(0)
            }
            
            leftImageView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(mainLabel.snp.bottom).offset(ver(6))
                make.size.equalTo(ttSize(169, 365.94))
            }
        }
        
        init(attText: NSMutableAttributedString,image: UIImage) {
            super.init(frame: .zero)
            mainLabel.attributedText = attText
            leftImageView.image = image
            self.backgroundColor = rgba(247, 247, 248, 1)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    

    
}
