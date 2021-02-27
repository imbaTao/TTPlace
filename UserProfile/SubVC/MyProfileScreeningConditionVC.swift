//
//  MyProfileScreeningConditionVC.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/7.
//

import UIKit


//MARK: - 条件筛选控制器
class MyProfileScreeningConditionVC: ViewController {
    
    // 静态列表
    var list = TTStaticList()
    
    // tips
    var tips = TTButton.init(text: "填写完后优先推荐符合条件用户", textColor: rgba(153, 153, 153, 1), font: .regular(13), iconName: "", type: .iconOnTheLeft, intervalBetweenIconAndText: 0) {
        
    }
    
    // 保存按钮
    var saveButton = UIButton.button(title: "保存", titleColor: .white, font: .regular(16),backGroundColor: .mainStyleColor, cornerRadius: hor(24))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let ageItem = TTMyProfieDetailListHeaderItem()
        ageItem.mainLabel.text = "他的年龄"
        ageItem.leftImageView.image = .init(color: .red, size: ttSize(52))
        ageItem.subLabel.text = "21-29岁"
        ageItem.backGroundView.isSelected = true
        
        
        let addressItem = TTMyProfieDetailListHeaderItem()
        addressItem.mainLabel.text = "他的当前所在地"
        addressItem.leftImageView.image = .init(color: .red, size: ttSize(52))
        addressItem.subLabel.text = "上海"
        
        
        let hometownItem = TTMyProfieDetailListHeaderItem()
        hometownItem.mainLabel.text = "他的当前所在地"
        hometownItem.leftImageView.image = .init(color: .red, size: ttSize(52))
        hometownItem.subLabel.text = "上海"
        
        
        
        
        
        
        addSubview(list)
        
        // 反选设置
        let items = [ageItem,addressItem,hometownItem]
        list.appendItems(items: items)
        let selectedItem = Observable.from(items.map{ item in item.backGroundView.rx.controlEvent(.touchUpInside).map{item}}).merge()
        for item in items {
            selectedItem.map{$0 == item}.bind(to: item.backGroundView.rx.isSelected).disposed(by: rx.disposeBag)
        }
        
        addSubview(tips)
        addSubview(saveButton)
        
        
        // layout
        list.snp.makeConstraints { (make) in
            make.top.equalTo(ver(10))
            make.left.right.equalToSuperview()
            make.height.equalTo(ver(300))
        }

        
        tips.snp.makeConstraints { (make) in
            make.right.equalTo(-hor(13))
            make.top.equalTo(list.snp.bottom).offset(0)
        }
        
        saveButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(tips.snp.bottom).offset(ver(36))
            make.size.equalTo(ttSize(169, 48))
        }
        
        // config
        configRightItem(text: "保存", type: .justText) {
            
        }
        
        list.isScrollEnabled = false

        
        title = "筛选条件"
        
        
        // rx
        saveButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
            // 保存事件
            
            
        }).disposed(by: rx.disposeBag)
        
    }
    
    

    
        //MARK: - 自定义item
       private class TTMyProfieDetailListHeaderItem: TTStaticListSectionItem {
            
        // 这里用个按钮做点击选中效果,标题有单独自定义控件
        lazy var backGroundView: UIButton = {
            var backGroundView = UIButton.button()
            backGroundView.setBackgroundImage(.init(color: rgba(244, 244, 244, 1), size: ttSize(351, 88)), for: .normal)
            backGroundView.setBackgroundImage(.init(color: #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1), size: ttSize(351, 88)), for: .selected)
            return backGroundView
        }()
        
        

        override func setupItem() {
            super.setupItem()
            
            // 先设置size
            self.snp.makeConstraints { (make) in
                make.size.equalTo(CGSize.init(width: SCREEN_W, height: ver(102)))
            }

            addSubviews([backGroundView,mainLabel,subLabel,leftImageView,rightImageView])
            
            // layout
            backGroundView.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview().inset(hor(12))
                make.height.equalTo(ver(88))
                make.centerY.equalToSuperview()
            }
            
            leftImageView.snp.makeConstraints { (make) in
                make.left.equalTo(hor(30))
                make.size.equalTo(hor(52))
                make.centerY.equalToSuperview()
            }
            
            mainLabel.snp.makeConstraints { (make) in
                make.left.equalTo(leftImageView.snp.right).offset(hor(12))
                make.top.equalTo(ver(13))
                make.centerY.equalToSuperview()
            }
            
            subLabel.snp.makeConstraints { (make) in
                make.right.equalTo(rightImageView.snp.left).offset(-hor(3))
                make.centerY.equalToSuperview()
                make.width.equalTo(hor(98))
            }
            
            rightImageView.snp.makeConstraints { (make) in
                make.right.equalTo(-hor(24))
                make.centerY.equalToSuperview()
                make.size.equalTo(hor(14))
            }
            

            // config
            leftImageView.cornerRadius = hor(17)
            backGroundView.cornerRadius = hor(31)
            rightImageView.image = .testImage()
            
            mainLabel.font = .medium(16)
            mainLabel.textColor = .mainTextColor2
            
            subLabel.font = .medium(16)
            subLabel.textColor = .mainTextColor
            subLabel.textAlignment = .right
        }
    }

}

