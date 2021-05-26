//
//  TTChatInputView.swift
//  TTBox
//
//  Created by Mr.hong on 2021/5/25.
//

import Foundation
// 用alert去做

// 输入状态
enum TTChatInputBarState {
    case none
    case textInput // 文本输入
    case emojiInput // 表情输入
}

class TTChatInputView: View,YYTextKeyboardObserver, UITextFieldDelegate {
    let backgroudView = View()
    
    // 输入行
    lazy var textInputBar: View = {
        var textInputBar = View()
        addSubview(textInputBar)
        textInputBar.backgroundColor = .white
        textInputBar.isHidden = true
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
        textInputView.tintColor = .black
        textInputView.delegate = self
        return textInputView
    }()
    
    // 防点击蒙层
    lazy var unEnabelClickMaskView: UIButton = {
        var unEnabelClickMaskView = UIButton()
        unEnabelClickMaskView.backgroundColor = .clear
        unEnabelClickMaskView.isUserInteractionEnabled = false
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
        emojiButton.setImage(R.image.ttChatInput_Emoji(), for: .normal)
        emojiButton.setImage(R.image.ttChatInput_keyboard(), for: .selected)
        return emojiButton
    }()
    
    // 发送按钮
    lazy var sendButton: UIButton = {
        var sendButton = UIButton.button(title: "发送", titleColor: .white, font: .regular(13), backGroundColor: .black, cornerRadius: 15)
        return sendButton
    }()
        
    // emoji表情扳
    lazy var emojiBoard: TTChatEmojiBoard = {
        var emojiBoard = TTChatEmojiBoard()
        emojiBoard.isHidden = true
        insertSubview(emojiBoard, belowSubview: unEnabelClickMaskView)
        emojiBoard.snp.remakeConstraints { (make) in
            make.width.equalTo(SCREEN_W)
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(200)
        }
        return emojiBoard
    }()
    
    
    // 当前消息栏的输入状态
    var state: TTChatInputBarState = .none {
        didSet {
            switch state {
            case .none:
                // 如果inputBar如果在显示，那么隐藏
                if !textInputBar.isHidden {
                    YYTextKeyboardManager.default()?.remove(self)
                    UIApplication.shared.keyWindow?.endEditing(true)
                    showOrHidenKeyboard(false)
                }
                
                if !emojiBoard.isHidden {
                    // 隐藏emoij面板
                    showOrHidenEmojiboard(false)
                }
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
            make.left.equalTo(0)
            make.bottom.equalTo(500)
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
        emojiBoard.backgroundColor = .white
        backgroundColor = .clear
        self.isHidden = true
    }
    
    override func bindViewModel() {
        super.bindViewModel()
//        backgroudView.backgroundColor = .orange
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
        
        // 聊天栏发送按钮
        sendButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self]  in guard let self = self else { return }
            
            // 检测一下是否可以发送消息
            self.canSendMessage(self.textInputView.text)
        }).disposed(by: rx.disposeBag)
        
        
        // 选中emoji代理
        emojiBoard.selectedEmoji.subscribe(onNext: {[weak self] (emoji) in guard let self = self else { return }
            var text = self.textInputView.text ?? ""
            let startIndex = text.startIndex
            let nextIndex = text.index(startIndex,offsetBy: self.cursorIndex)
            text.insert(Character.init(emoji), at: nextIndex)
            self.textInputView.text = text
            self.cursorIndex += 1
        }).disposed(by: rx.disposeBag)
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
                // 隐藏，如果当前状态是text输入，那么隐藏
//                if state == .textInput {
//                    showOrHidenKeyboard(false)
//                }
            }
        }
    }


    
    // 显示键盘
    func showOrHidenKeyboard(_ show: Bool) {
        self.isHidden = false
        self.unEnabelClickMaskView.isUserInteractionEnabled = true
        
        if show {
            self.textInputBar.isHidden = false
        }
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
        }
    }
    
    
    
    // 展示emoji面板
    func showOrHidenEmojiboard(_ show: Bool) {
        self.emojiButton.isSelected = show
        if show {
            // 收起键盘,然后执行动画
            UIApplication.shared.keyWindow?.endEditing(true)
        }else {
            // 本来就隐藏了，就不要显示动画了
            if emojiBoard.isHidden == true {
                return
            }
        }
        
   
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
    var sendTextAction = PublishSubject<String>()
    
    // 发送
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 无文本直接返回
        if canSendMessage(textField.text) {
            return true
        }else {
            return false
        }
    }
    
    // 是否可以发送消息
    @discardableResult
    func canSendMessage(_ text: String?) -> Bool {
        if text?.count == 0 || text == nil {
            showError("无法发送空消息!")
            return false
        }else {
            state = .none
            sendTextAction.onNext(text!)
            
            // 发送完清空
            textInputView.text = ""
            return true
        }
    }
}


// 表情面板
class TTChatEmojiBoard: View {
    
    // 点击了表情传出去
    var selectedEmoji = ReplaySubject<String>.create(bufferSize: 1)
    
    private var showHeight: CGFloat = 0.0
    lazy var emojiCollectionView: TTCollectionView = {
        let inteval: CGFloat = 15.0
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = inteval
        layout.minimumInteritemSpacing = inteval
        layout.scrollDirection = .vertical
        
        let width = ceil((SCREEN_W - (inset * 2 + inteval * 8)) / 9)
        layout.itemSize = CGSize.init(width: width, height: width)
        
        let emojiCollectionView = TTCollectionView.init(classTypes: [TTChatEmojiBoardCell.self], flowLayout: layout)
        return emojiCollectionView
    }()
    
    
    override func makeUI() {
        super.makeUI()
        backgroundColor = .white
        
        addSubview(emojiCollectionView)
        emojiCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(inset)
            
        }
        
        // 数据文件
        let plistPath = Bundle.main.path(forResource: "Emoji", ofType: "plist")
        
        //当数据结构为数组时
        if let emojiArray = NSArray(contentsOfFile: plistPath ?? "") as? [String] {
            let items = Observable.just(emojiArray)
            
            //设置单元格数据（其实就是对 cellForItemAt 的封装）
            items.bind(to: emojiCollectionView.rx.items) { (collectionView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueReusableCell(withClass: TTChatEmojiBoardCell.self, for: indexPath)
                cell.emojiIconLable.text = element
                return cell
            }.disposed(by: rx.disposeBag)
            

            // cell选中
            emojiCollectionView.rx.modelSelected(String.self).subscribe(onNext: {[weak self] (item) in guard let self = self else { return }
                self.selectedEmoji.onNext(item)
            }).disposed(by: rx.disposeBag)
        }
    }
}


// 表情cell
class TTChatEmojiBoardCell: TTCollectionViewCell {
    
    // 表情图片,emoji是lable展示的，内容是string
    var emojiIconLable = UILabel.regular(size: 24, alignment: .center)
    override func makeUI() {
        super.makeUI()
        addSubview(emojiIconLable)
        emojiIconLable.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
}

