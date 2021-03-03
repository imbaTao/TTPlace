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
        title = "上传微信二维码"
        
        let list = TTStaticList()
        list.mainStackView.spacing = 21
        addSubview(list)
        list.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(inset)
        }
        
        let headerItem = HeaderItem()
        headerItem.backgroundColor = .white
        headerItem.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: SCREEN_W, height: CGFloat(241 + 76)))
        }
        
        list.appendItems(items: [headerItem])
        
        // 富文本
        let contents = ["第一步：微信打开「我的」页面","第二步：点开「我的二维码」","第三步：截屏「我的二维码」页面，完成"]
        let images = [R.image.profile_realname_wechatStep1(),R.image.profile_realname_wechatStep2(),R.image.profile_realname_wechatStep3()]
        
        for index in 0..<3 {
            let attText = NSMutableAttributedString.init(string: contents[index])
            attText.font = .medium(14)
            attText.color = .mainTextColor
            switch index {
            case 0:
                attText.setColor(rgba(143, 64, 246, 1), range: .init(location: 9, length: 2))
            case 1:
                attText.setColor(rgba(143, 64, 246, 1), range: .init(location: 7, length: 5))
            case 2:
                attText.setColor(rgba(143, 64, 246, 1), range: .init(location: 7, length: 5))
            default:break
            }
            let stepItem = StepItem.init(attText: attText, image: images[index]!)
            stepItem.snp.makeConstraints { (make) in
                make.size.equalTo(ttSize(SCREEN_W, 389 + 24))
            }
            list.appendItems(items: [stepItem])
        }
        
        
        // config
        headerItem.itemclick = {
            print("点击了上传微信二维码")
        }
        
        backGroundImageView.backgroundColor = rgba(247, 247, 248, 1)
    }
    
    
    // 私有类，头部部分
   private class HeaderItem: TTStaticListSectionItem {
        var backGroundView = UIImageView.init(image: R.image.profile_realname_wechatIcon())
        var addButton = UIButton.iconImage(R.image.profile_realname_addIcon())
        var tips = UILabel.medium(size: 16, textColor: .mainTextColor, text: "上传微信二维码", alignment: .center)
    
        // 操作方法,灰色面板,也放在头部
        var tips2 = UILabel.medium(size: 16, textColor: rgba(51, 51, 51, 1), text: "操作方法", alignment: .center)
    
        override init(frame: CGRect) {
            super.init(frame: .zero)
            let container = UIView.color(rgba(245, 245, 245, 1))
            container.isUserInteractionEnabled = false
            addSubview(container)
            container.addSubviews([backGroundView,addButton])
            addSubviews([tips,tips2])
    
            // layout
            container.snp.makeConstraints { (make) in
                make.top.equalTo(36)
                make.centerX.equalToSuperview()
                make.size.equalTo(169)
            }
            
            backGroundView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(25)
            }
            
            addButton.snp.makeConstraints { (make) in
                make.top.equalTo(backGroundView)
                make.centerX.equalToSuperview()
                make.size.equalTo(72)
            }
            
            tips.snp.makeConstraints { (make) in
                make.top.equalTo(addButton.snp.bottom).offset(21)
                make.centerX.equalToSuperview()
            }
            
            tips2.snp.makeConstraints { (make) in
                make.left.right.equalTo(0)
                make.height.equalTo(70)
                make.bottom.equalToSuperview()
            }
            
            // config
            backgroundColor = rgba(247, 247, 248, 1)
            backGroundView.backgroundColor = rgba(247, 247, 248, 1)
            addButton.cornerRadius = hor(72 / 2)
            tips2.isUserInteractionEnabled = true
            
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
