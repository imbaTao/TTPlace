//
//  MyprofileRealNameVC.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/8.
//

import UIKit

//MARK: - 实名认证控制器
class MyprofileRealNameVC: ViewController {
    // 顶部背景图
    var headerBackgroundImageView = UIImageView.init(image: .testImage())
    
    
    // 名字输入
    var nameInput = TTTextFiled.init{ (configure) in
        configure.textFont = .regular(14)
        configure.textColor = .mainTextColor
        configure.caretColor = .mainStyleColor
        configure.maxTextCount = 10
        configure.textAlignment = .center
        configure.placeholderText = "请输入姓名"
        configure.placeholderColor = rgba(102, 102, 102, 1)
        configure.contentEdges = .init(top: 0, left: hor(12), bottom: 0, right: hor(12))
    }
    
    
    // 名字输入
    var idNumberInput = TTTextFiled.init{ (configure) in
        configure.textFont = .regular(14)
        configure.textColor = .mainTextColor
        configure.caretColor = .mainStyleColor
        configure.maxTextCount = 18
        configure.textAlignment = .center
        configure.placeholderText = "请输入身份证号码"
        configure.placeholderColor = rgba(102, 102, 102, 1)
        configure.contentEdges = .init(top: 0, left: hor(12), bottom: 0, right: hor(12))
    }
    
    // 提交按钮
    var sendButton = UIButton.button(title: "提交审核", titleColor: .white, font: .medium(16), cornerRadius: hor(3))
    
    // tips1
    var tips1 = TTButton.init(text: "请保持姓名和身份证号码与身份证信息保持一致", textColor: rgba(153, 153, 153, 1), font: .regular(13), iconName: "", type: .iconOnTheLeft, intervalBetweenIconAndText: 0) {
        
    }
    
    var tips2 = UILabel.regular(size: 11, textColor: rgba(153, 153, 153, 1), text: "实名认证，仅用于确保用户身份真实且唯一。保障所有用户的合法权益，降低用户资产被盗或隐私泄密的风险。便于平台规范管理，维持网络安全秩序。", alignment: .justified,numberOfline: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutViews()

    }
    

    
    
    func layoutViews() {
        addSubviews([headerBackgroundImageView,nameInput,idNumberInput,sendButton,tips1,tips2])
        
        headerBackgroundImageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(ver(260))
        }
        
        nameInput.snp.makeConstraints { (make) in
            make.top.equalTo(headerBackgroundImageView.snp.bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(ver(51))
        }

        idNumberInput.snp.makeConstraints { (make) in
            make.top.equalTo(nameInput.snp.bottom)
            make.left.right.equalTo(0)
            make.height.equalTo(ver(51))
        }
        
        
        sendButton.snp.makeConstraints { (make) in
            make.left.equalTo(hor(12))
            make.top.equalTo(idNumberInput.snp.bottom).offset(ver(24))
            make.size.equalTo(ttSize(351, 48))
        }
        
        tips1.snp.makeConstraints { (make) in
            make.left.equalTo(hor(12))
            make.top.equalTo(sendButton.snp.bottom).offset(ver(15))
        }
        
        tips2.snp.makeConstraints { (make) in
            make.left.right.equalTo(sendButton)
            make.bottom.equalTo(ver(-30))
        }
        
        
        // config
        // 变更下图片
        configLeftItem(iconName: "") {
            super.backAction()
        }
        
        sendButton.isEnabled = false
        sendButton.setBackgroundImage(.init(color: rgba(229, 229, 229, 1), size: ttSize(351, 48)), for: .disabled)
        sendButton.setBackgroundImage(.init(color: rgba(143, 64, 246, 1), size: ttSize(351, 48)), for: .normal)
        
        
        // 添加分割线
        nameInput.textInputView.addBorderWithPositon(direction: .bottom,leftAndRightSpace: hor(12), color: rgba(247, 247, 248, 1), height: 1)
        idNumberInput.textInputView.addBorderWithPositon(direction: .bottom,leftAndRightSpace: hor(12), color: rgba(247, 247, 248, 1), height: 1)
        
        // rx
        
        
        // 两个输入框达到条件的时候才可以下一步
        let nameVaild = nameInput.rx.text.orEmpty.map{$0.count > 0}  //map函数 对text进行处理
            .share(replay: 1)
               
        let idNumberValid = idNumberInput.rx.text.orEmpty
           .map{$0.count == 18}  //map函数 对text进行处理
            .share(replay: 1)
 
        let everythingValid = Observable.combineLatest(nameVaild, idNumberValid) { $0 && $1 }
            .share(replay: 1)
        everythingValid.bind(to: sendButton.rx.isEnabled).disposed(by: rx.disposeBag)
    }
}
