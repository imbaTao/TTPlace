//
//  ViewController1.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/10/26.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

//import UIKit
import Foundation
import RxSwift
import Alamofire
import SwiftyJSON
import Kingfisher
import RxCocoa
import HandyJSON
import SwiftyJSON

class ViewController: TTViewController {
    
}

class TTButton1: UIButton {
    
}

protocol TTAlertProtocal {
    associatedtype T
}


// 用alert去做
class TTChatInputView: View,YYTextKeyboardObserver, UITextFieldDelegate {
    
    // 输入状态
    enum TTChatInputBarState {
        case none
        case textInput // 文本输入
        case emojiInput // 表情输入
    }
    
    // backgroudView
    let backgroudView = View()
    
    // 输入行
    lazy var textInputBar: View = {
        var textInputBar = View()
        addSubview(textInputBar)
        textInputBar.backgroundColor = .white
        textInputBar.addSubviews([textInputView,emojiButton,sendButton])
        
        
        /// layout
        textInputView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(inset)
            make.right.equalTo(emojiButton.snp.left).offset(-inset)
            make.height.greaterThanOrEqualTo(50)
        }
        
        emojiButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(textInputView)
            make.right.equalTo(sendButton.snp.left).offset(-18)
            make.size.equalTo(30)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(inset)
            make.centerY.equalTo(emojiButton)
            make.size.equalTo(CGSize(width: 63,height: 30))
        }

        return textInputBar
    }()
    
    
    // 文本输入
    lazy var textInputView: UITextField = {
        var textInputView = UITextField.init()
        textInputView.rx.text.orEmpty.scan("") { (previous, new) -> String in
            if new.lengthWhenCountingNonASCIICharacterAsTwo() < 100 {
                return new
            }else {
                return previous
            }
        }.bind(to: textInputView.rx.text)
        .disposed(by: rx.disposeBag)
        textInputView.textColor = rgba(51, 51, 51, 1)
        textInputView.font = .regular(15)
        textInputView.tintColor = .mainStyleColor
        textInputView.delegate = self
        return textInputView
    }()
    
    // 防点击蒙层
    lazy var unEnabelClickMaskView: UIButton = {
        var unEnabelClickMaskView = UIButton()
        unEnabelClickMaskView.backgroundColor = .clear
        addSubview(unEnabelClickMaskView)
        unEnabelClickMaskView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        unEnabelClickMaskView.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            // 空事件，只做拦截
            print("点击了阻挡视图")
        }).disposed(by: rx.disposeBag)
        return unEnabelClickMaskView
    }()
    
    // 默认bar的高度,计算动画高度时要加上
    let barHeight: CGFloat = 50
    
    // 变更空视图的高度
    var keyboardAnimateInteval: CGFloat = 0.25
    
    // 收到键盘高度的时候，变更其他面板的约束
    var keyboardHeight: CGFloat = 200.0 {
        willSet {
          
        }
    }

    // 光标位置
    var cursorIndex: Int  = 0
    
    // emoji表情按钮
    lazy var emojiButton: UIButton = {
        var emojiButton = UIButton.button()
        emojiButton.setImage(UIImage.init(color: .black, size: .init(width: 40, height: 40)), for: .normal)
        emojiButton.setImage(UIImage.init(color: .red, size: .init(width: 40, height: 40)), for: .selected)
        return emojiButton
    }()
    
    // emoji表情按钮
    lazy var sendButton: UIButton = {
        var sendButton = UIButton.button(title: "发送", titleColor: .white, font: .regular(13), backGroundColor: .mainStyleColor, cornerRadius: 15)
        return sendButton
    }()
        
    // emoji表情扳
    var emojiBoard = View()
    
    // 当前消息栏的输入状态
    var state: TTChatInputBarState = .none {
        didSet {
            // 记录旧值，根据旧值处理新值
//            let oldValue = state
            switch state {
            case .none:
                YYTextKeyboardManager.default()?.remove(self)
                UIApplication.shared.keyWindow?.endEditing(true)
                showOrHidenKeyboard(false)
                
                // 隐藏emoij面板
                showOrHidenEmojiboard(false)
            case .textInput:
                // 添加键盘监听
                YYTextKeyboardManager.default()?.add(self)
                
                // 弹起键盘
                textInputView.becomeFirstResponder()
                
            case .emojiInput:
                // 计算光标位置
                if let cursorIndex = self.textInputView.cursorDistance {
                    self.cursorIndex = cursorIndex
                }
        
                // 显示emoji键盘
                showOrHidenEmojiboard(true)
            }
        }
    }
    
    
    
     init(parrentView: UIView) {
        super.init(frame: .zero)
        parrentView.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func makeUI() {
        super.makeUI()
        addSubviews([backgroudView,textInputBar,emojiBoard,unEnabelClickMaskView])
        
        // layout
        backgroudView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        unEnabelClickMaskView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        textInputBar.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(0)
            make.width.equalTo(SCREEN_W)
            make.height.equalTo(keyboardHeight)
        }
        
        // emoji面板，默认隐藏
        emojiBoard.isHidden = true
        emojiBoard.snp.makeConstraints { (make) in
            make.width.equalTo(SCREEN_W)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(200)
        }
        
        // 发送样式
        textInputView.returnKeyType = .send
        emojiBoard.backgroundColor = .cyan
        backgroundColor = .clear
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        backgroudView.backgroundColor = .orange
        // config
        backgroudView.rx.tap().subscribe { [weak self] _ in guard let self = self else { return }
            // 点击隐藏移除自己
            self.state = .none
        }.disposed(by: rx.disposeBag)
        
        // 点击表情按钮,弹起面板
        emojiButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self]  in guard let self = self else { return }
            // 如果选中了，就取消选中，状态变为文本输入
            if self.emojiButton.isSelected  {
                self.state = .textInput
            }else {
                self.state = .emojiInput
            }
            
            print("按钮选中状态\(self.emojiButton.isSelected)")
            
        }).disposed(by: rx.disposeBag)
        
        
        // 选中emoji代理
//        emojiBoard.selectedEmoji.subscribe(onNext: {[weak self] (emoji) in guard let self = self else { return }
//            var text = self.textInputView.text ?? ""
//            let startIndex = text.startIndex
//            let nextIndex = text.index(startIndex,offsetBy: self.cursorIndex)
//            text.insert(Character.init(emoji), at: nextIndex)
//            self.textInputView.text = text
//            self.cursorIndex += 1
//        }).disposed(by: rx.disposeBag)
    }
    
    /// MARK: - 键盘代理事件
    func keyboardChanged(with transition: YYTextKeyboardTransition) {

        ///用此方法获取键盘的rect
        if let keyboardRect = YYTextKeyboardManager.default()?.convert(transition.toFrame, to: rootWindow()) {
            // 键盘显示动画时间
            keyboardAnimateInteval =  CGFloat(transition.animationDuration)
            
            // 键盘高度
            keyboardHeight = keyboardRect.height
            
            // 显示
            if transition.fromFrame.origin.y > transition.toFrame.origin.y {
                // 显示键盘
                showOrHidenKeyboard(true)
            }else {
                // 隐藏不用监听
            }
        }
    }


    
    // 显示键盘
    func showOrHidenKeyboard(_ show: Bool) {
        self.isHidden = false
        self.unEnabelClickMaskView.isUserInteractionEnabled = true
        UIView.animate(withDuration: TimeInterval(keyboardAnimateInteval), delay: 0, options: UIView.AnimationOptions.init(rawValue: 458752)) { [weak self] in guard let self = self else { return }
            if show {
                // show的话，先把视图移动到底部
                self.textInputBar.snp.remakeConstraints { (make) in
                    make.bottom.equalTo(0)
                    make.left.equalToSuperview()
                    make.width.equalTo(SCREEN_W)
                    make.height.equalTo(self.keyboardHeight + 50)
                }
            }else {
                // 隐藏的话
                self.textInputBar.snp.remakeConstraints { (make) in
                    make.bottom.equalTo(self.keyboardHeight + self.barHeight)
                    make.left.equalToSuperview()
                    make.width.equalTo(SCREEN_W)
                    make.height.equalTo(self.keyboardHeight + 50)
                }
            }
            self.layoutIfNeeded()
        }completion: { (isFinishd) in
            self.unEnabelClickMaskView.isUserInteractionEnabled = false
          
            if show {
                // 隐藏emoji
                self.showOrHidenEmojiboard(false)
            }else {
                self.isHidden = true
            }
            
            // emoji表情按钮显示
            self.emojiButton.isSelected = self.state == .emojiInput
        }
    }
    
    
    
    // 展示emoji面板
    func showOrHidenEmojiboard(_ show: Bool) {
        if show {
            // 收起键盘,然后执行动画
            UIApplication.shared.keyWindow?.endEditing(true)
        }else {
            // 本来就隐藏了，就不要显示动画了
            if emojiBoard.isHidden == true {
                return
            }
        }
        
        self.emojiButton.isSelected = show
        self.unEnabelClickMaskView.isUserInteractionEnabled = true
        self.emojiButton.isUserInteractionEnabled = false
        UIView.animate(withDuration: TimeInterval(keyboardAnimateInteval), delay: 0, options: UIView.AnimationOptions.init(rawValue: 458752)) { [weak self] in guard let self = self else { return }
            if show {
                self.emojiBoard.isHidden = false
                // show的话，先把视图移动到底部
                self.emojiBoard.snp.remakeConstraints { (make) in
                    make.bottom.equalTo(0)
                    make.left.equalToSuperview()
                    make.width.equalTo(SCREEN_W)
                    make.height.equalTo(self.keyboardHeight)
                }
            }else {
                // 隐藏的话
                self.emojiBoard.snp.remakeConstraints { (make) in
                    make.bottom.equalTo(self.keyboardHeight + self.barHeight)
                    make.left.equalToSuperview()
                    make.width.equalTo(SCREEN_W)
                    make.height.equalTo(self.keyboardHeight)
                }
            }
            self.layoutIfNeeded()
        }completion: { (isFinishd) in
            self.unEnabelClickMaskView.isUserInteractionEnabled = false
            self.emojiBoard.isHidden = !show
            self.emojiButton.isUserInteractionEnabled = true
        }
        
      
    }

    
    
    // retrunkey事件
    var returnKeyAction = PublishSubject<String>()
    
    // 发送
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 无文本直接返回
        if textField.text?.count == 0 {
            showError("无法发送空消息!")
            return false
        }
    
        state = .none
        returnKeyAction.onNext(textField.text!)
        textField.text = ""
        return true
    }
}



class ViewController1: ViewController,UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureView),
                                               name: Notification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil)

     
        
       
//        configureView()

//        showAlert(title: "系统坦克", message: "我是标题")
//        showOriginalAlert(title: "系统坦克", message: "我是标题") { (index) in
//
//        }
        
        let button = UIButton.init()
        button.backgroundColor = .red
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.size.equalTo(44)
            make.center.equalToSuperview()
        }
        
        button.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            print("\(self.chatBar.state)")
            
            if self.chatBar.state == .none {
                self.chatBar.state = .textInput
            }else {
                self.chatBar.state = .none
            }
        }).disposed(by: rx.disposeBag)
    }
    
    
    
    
    lazy var chatBar: TTChatInputView = {
        let chatInputView = TTChatInputView.init(parrentView: self.view)
        addSubview(chatInputView)
        chatInputView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        chatInputView.layoutIfNeeded()
//        chatInputView.state = .textInput
        return chatInputView
    }()
    
    
    // 问题是，我如何重新拿到之前布局的UI控件，做刷新
    @objc func configureView()  {
        view.removeAllSubviews()
        view.backgroundColor = .gray
        

   }


}


/**
 我想做什么？
 1.定义一个alert基类，子类去继承他，可以直接访问到其他属性就行
 2.content尺寸可以自适应，也可以自行限制
 3.最好应该有个alert栈管理，可以控制取消所有alert
 */



class RoomAlert: TTAlert2 {
  
    
    override func makeUI() {
        super.makeUI()
        title.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
        }
        
        subTitle.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(4)
        }
        
        mainButton.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(subTitle.snp.bottom).offset(20)
        }
    
        
        
        mainButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            self.event.onNext(1)
            print("111")
        }).disposed(by: rx.disposeBag)
        
        // config
        title.text = "我是标题啊"
        subTitle.text = "我是子标题啊"
    }
    
    override func setupConfig() {
        config.defalultMinSize = ttSize(200)
        config.touchHidden = true
        config.showAnimateStyle = .bottom
//        config.showAnimateStyle = .center

    }
}



extension UIView {
    var inset: CGFloat {
        return 12
    }
    
}

extension UIColor {
    // 性别颜色， 男1，女2
    class func genderColor(_ gender: Int = 1) -> UIColor {
        if gender == 1 {
            return rgba(124, 200, 255, 1)
        }else {
            return rgba(255, 127, 182, 1)
        }
    }
    
    // 主要文本颜色
    static var mainStyleColor: UIColor {
        return #colorLiteral(red: 0.5607843137, green: 0.2509803922, blue: 0.9647058824, alpha: 1)
    }
    
    // 主要文本颜色
    static var mainTextColor: UIColor {
        return rgba(51, 51, 51, 1)
    }
    
    // 主要文本颜色2
    static var mainTextColor2: UIColor {
        return rgba(102, 102, 102, 1)
    }
    
    
}
