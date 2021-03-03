//
//  MyprofileRealNameVC.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/8.
//

import UIKit

//MARK: - 实名认证控制器
class MyProfilePhoneRealNameVC: ViewController {
    // 顶部背景图
    var headerBackgroundImageView = UIImageView.init(image: .testImage())
    
    // 名字输入
    var firstTextField: TTTextFiled!
    var firstTextFieldConfig: TTTextFiledConfigure {
        let firstConfigure = TTTextFiledConfigure()
        firstConfigure.textFont = .regular(14)
        firstConfigure.textColor = .mainTextColor
        firstConfigure.caretColor = .mainStyleColor
        firstConfigure.textAlignment = .left
        firstConfigure.maxTextCount = 11
        firstConfigure.placeholderText = "请输入手机号"
        firstConfigure.placeholderColor = rgba(102, 102, 102, 1)
        firstConfigure.contentEdges = .init(top: 0, left: hor(12), bottom: 0, right: hor(12))
        return firstConfigure
    }
    
    var secondTextFieldConfig: TTTextFiledConfigure {
        let secondConfigure = TTTextFiledConfigure()
        secondConfigure.textFont = .regular(14)
        secondConfigure.textColor = .mainTextColor
        secondConfigure.caretColor = .mainStyleColor
        secondConfigure.textAlignment = .left
        secondConfigure.maxTextCount = 4
        secondConfigure.placeholderText = "请输入验证码"
        secondConfigure.placeholderColor = rgba(102, 102, 102, 1)
        secondConfigure.contentEdges = .init(top: 0, left: hor(12), bottom: 0, right: hor(12))
        return secondConfigure
    }
    
    
    
    // 名字输入
    var secondTextField: TTTextFiled!
    
    // 提交按钮
    var sendButton = UIButton.button(title: "提交审核", titleColor: .white, font: .medium(16), cornerRadius: hor(3))
    
    // 发送验证码
    var sendMailCodeButton = UIButton.title(title: "发送验证码", titleColor: rgba(153, 153, 153, 153), font: .regular(14))



    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configBarTranslucence(value: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar(barColor: .clear, titleColr: .white, font: .medium(18))
        
        
    }
    
    

    override func makeUI() {
        super.makeUI()
        // 变更左侧为白色返回
        configLeftItem(iconName: "") {
            
        }
        
        title = "实名认证"
        firstTextField = TTTextFiled.init(configure: firstTextFieldConfig)
        secondTextField = TTTextFiled.init(configure: secondTextFieldConfig)
        
        
        // 绑定手机号行
        let bindPhontItem = View.color(rgba(247, 247, 248, 1))
        let tipsLabel = UILabel.regular(size: 13, textColor: rgba(153, 153, 153, 1), text: "绑定手机号", alignment: .left)
        bindPhontItem.addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(inset)
            make.centerY.equalToSuperview()
        }
        
        addSubviews([headerBackgroundImageView,bindPhontItem,firstTextField,secondTextField,sendMailCodeButton,sendButton])
        
        
        headerBackgroundImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(ttSize(375,260))
        }
        
        bindPhontItem.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(headerBackgroundImageView.snp.bottom)
            make.height.equalTo(54)
        }
        
        firstTextField.snp.makeConstraints { (make) in
            make.top.equalTo(bindPhontItem.snp.bottom)
            make.left.right.equalToSuperview().inset(inset)
            make.height.equalTo(51)
        }

        secondTextField.snp.makeConstraints { (make) in
            make.top.equalTo(firstTextField.snp.bottom)
            make.left.right.equalTo(firstTextField)
            make.height.equalTo(51)
        }
        
        sendMailCodeButton.snp.makeConstraints { (make) in
            make.right.equalTo(secondTextField)
            make.top.bottom.equalTo(secondTextField)
            make.width.equalTo(96)
        }
        

        sendButton.snp.makeConstraints { (make) in
            make.left.equalTo(inset)
            make.top.equalTo(secondTextField.snp.bottom).offset(ver(24))
            make.size.equalTo(ttSize(351, 48))
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
        super.bindViewModel()
        sendMailCodeButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            self.sendMessage()
        }).disposed(by: rx.disposeBag)
        
        sendButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            self.sendAction()
        }).disposed(by: rx.disposeBag)
        
        
        
        // 两个输入框达到条件的时候才可以下一步
        let firstValid  = firstTextField.rx.text.orEmpty.map{$0.count == 11}  //map函数 对text进行处理
            .share(replay: 1)
               
        let secondValid = secondTextField.rx.text.orEmpty
           .map{$0.count == 4}  //map函数 对text进行处理
            .share(replay: 1)
 
        let everythingValid = Observable.combineLatest(firstValid, secondValid) { $0 && $1 }
            .share(replay: 1)
        everythingValid.bind(to: sendButton.rx.isEnabled).disposed(by: rx.disposeBag)
        
        headerBackgroundImageView.image = R.image.profile_realName_PhoneHeader()
    }
    
    // 提交时间
    func sendAction() {
        print("提交事件")
    }
    
    
    //MARK: - 发送邮件
    func sendMessage() {

        // 开始计时
        self.sendMailCodeButton.isEnabled = false;

        // 开始倒计时
       let timer =  Observable<Int>.timer(0,period: 1, scheduler: MainScheduler.instance).subscribe {[weak self] (time) in
        self!.sendMailCodeButton.setTitle("\(59 - time)s", for: .disabled)
        } onCompleted: {

        } onDisposed: {
            self.sendMailCodeButton.setTitle("重新发送", for: .normal)
            self.sendMailCodeButton.isEnabled = true;
        }

       // 倒计时时间到就销毁
        DispatchQueue.main.asyncAfter(deadline: .now() + 59) {
            timer.dispose()
        }

        // 网络请求获取短信
//        TTNet.requst(type:.post,api: "/api/v1/none_jwt/sms_code", parameters:[
//            "mobile": phoneNumberStr,
//        ],secret: true).subscribe { (model) in
//
//        } onError: { (error) in
//        }.disposed(by: rx.disposeBag)
    }
        
}
