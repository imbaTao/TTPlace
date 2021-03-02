//
//  MyProfileEditNickNameVC.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/7.
//

import Foundation

class MyProfileEditNickNameVC: ViewController {
    
    // 昵称textView
    var nickNameTextView = TTTextFiled.init { (configure) in
        configure.textFont = .regular(14)
        configure.textColor = .mainTextColor
        configure.caretColor = .mainStyleColor
        configure.maxTextCount = 10
        configure.textAlignment = .center
        configure.placeholderText = "请输入昵称"
        configure.contentEdges = .init(top: 0, left: 12, bottom: 12, right: 0)
    }
    
    var tips = UILabel.regular(size: 12, textColor: rgba(153, 153, 153, 1), text: "有趣的昵称会给人留下深刻的印象哦")
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        addSubviews([nickNameTextView,tips])
        nickNameTextView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(ver(12))
            make.height.equalTo(ver(49))
        }
        
        
        tips.snp.makeConstraints { (make) in
            make.left.equalTo(hor(12))
            make.top.equalTo(nickNameTextView.snp.bottom).offset(ver(6))
        }
        
        
        // config
        configNavigationBar(barColor: .white, titleColr: .mainTextColor, font: .medium(18))
        configRightItem(text: "保存",font: .regular(15), type: .justText) {
            // 保存事件
            
        }
        self.title = "编辑昵称"
        
        view.backgroundColor = rgba(247, 247, 248, 1)
    }
}
