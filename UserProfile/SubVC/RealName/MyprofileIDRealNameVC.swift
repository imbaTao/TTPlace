//
//  MyprofileRealNameVC.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/8.
//

import UIKit

//MARK: - 实名认证控制器
class MyprofileIDRealNameVC: MyProfilePhoneRealNameVC {
    
    // tip1
    var tips1 = TTButton.init(text: "请保持姓名和身份证号码与身份证信息保持一致", textColor: rgba(153, 153, 153, 1), font: .regular(13), iconImage: R.image.profile_screeing_tips(), type: .iconOnTheLeft, intervalBetweenIconAndText: 0) {
    }
    
    var tips2 = UILabel.regular(size: 11, textColor: rgba(153, 153, 153, 1), text: "实名认证，仅用于确保用户身份真实且唯一。保障所有用户的合法权益，降低用户资产被盗或隐私泄密的风险。便于平台规范管理，维持网络安全秩序。", alignment: .justified,numberOfline: 0)
    
    
    override var firstTextFieldConfig: TTTextFiledConfigure {
        let firstConfigure = TTTextFiledConfigure()
        firstConfigure.textFont = .regular(14)
        firstConfigure.textColor = .mainTextColor
        firstConfigure.caretColor = .mainStyleColor
        firstConfigure.textAlignment = .left
        firstConfigure.maxTextCount = 10
        firstConfigure.placeholderText = "请输入真实姓名"
        firstConfigure.placeholderColor = rgba(102, 102, 102, 1)
        firstConfigure.contentEdges = .init(top: 0, left: hor(12), bottom: 0, right: hor(12))
        
        // 暂时输入规则不做限制
//        firstConfigure.filter1 = .init(.name)
        return firstConfigure
    }
    
    override var secondTextFieldConfig: TTTextFiledConfigure {
        let secondConfigure = TTTextFiledConfigure()
        secondConfigure.textFont = .regular(14)
        secondConfigure.textColor = .mainTextColor
        secondConfigure.caretColor = .mainStyleColor
        secondConfigure.textAlignment = .left
        secondConfigure.maxTextCount = 18
        secondConfigure.placeholderText = "请输入身份证号码"
        secondConfigure.placeholderColor = rgba(102, 102, 102, 1)
        secondConfigure.contentEdges = .init(top: 0, left: hor(12), bottom: 0, right: hor(12))
//        secondConfigure.filter1 = .init(.ID)
        return secondConfigure
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        
        // 变更左侧为白色返回
        configLeftItem(iconName: "") {
            
        }
        
        title = "实名认证"
        firstTextField = TTTextFiled.init(configure: firstTextFieldConfig)
        secondTextField = TTTextFiled.init(configure: secondTextFieldConfig)
        
        addSubviews([headerBackgroundImageView,firstTextField,secondTextField,sendButton,tips1,tips2])
        
        
        headerBackgroundImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(ttSize(375,260))
        }
    
        firstTextField.snp.makeConstraints { (make) in
            make.top.equalTo(headerBackgroundImageView.snp.bottom)
            make.left.right.equalToSuperview().inset(inset)
            make.height.equalTo(51)
        }

        secondTextField.snp.makeConstraints { (make) in
            make.top.equalTo(firstTextField.snp.bottom)
            make.left.right.equalTo(firstTextField)
            make.height.equalTo(51)
        }
    

        sendButton.snp.makeConstraints { (make) in
            make.left.equalTo(inset)
            make.top.equalTo(secondTextField.snp.bottom).offset(ver(24))
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
        sendMailCodeButton.addBorderWithPositon(direction: .left, leftAndRightSpace: 11, color: rgba(238, 238, 238, 1), height: 1)
        
        
        // 添加分割线
        firstTextField.textInputView.addBorderWithPositon(direction: .bottom,leftAndRightSpace: hor(12), color: rgba(247, 247, 248, 1), height: 1)
        secondTextField.textInputView.addBorderWithPositon(direction: .bottom,leftAndRightSpace: hor(12), color: rgba(247, 247, 248, 1), height: 1)
    }
    
    
    
    override func bindViewModel() {
        sendMailCodeButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            self.sendMessage()
        }).disposed(by: rx.disposeBag)
        
        sendButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            self.sendAction()
        }).disposed(by: rx.disposeBag)
        
        
        
        // 两个输入框达到条件的时候才可以下一步
        let firstValid  = firstTextField.rx.text.orEmpty.map{$0.count > 0}  //map函数 对text进行处理
            .share(replay: 1)
               
        let secondValid = secondTextField.rx.text.orEmpty
           .map{$0.count == 18}  //map函数 对text进行处理
            .share(replay: 1)
 
        let everythingValid = Observable.combineLatest(firstValid, secondValid) { $0 && $1 }
            .share(replay: 1)
        everythingValid.bind(to: sendButton.rx.isEnabled).disposed(by: rx.disposeBag)
        
        
        headerBackgroundImageView.image = R.image.profile_realName_IDHeader()
    }
}
