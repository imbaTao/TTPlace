//
//  TTAlert.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/11/5.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation
import RxSwift



// 点击隐藏视图
class TTCustomAlert: UIControl {
  
    @discardableResult
    class func show(customView: UIView,touchHidden: Bool = false,backGroundColor: UIColor = rgba(0, 0, 0, 0.5)) -> TTCustomAlert {
        let alert = TTCustomAlert()
        alert.backgroundColor = backGroundColor
        alert.addSubview(customView)
        customView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        rootWindow().addSubview(alert)
        alert.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        if touchHidden {
            // config
            alert.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak alert] ( _ ) in
                // 点击隐藏
                alert?.isHidden = true
                alert?.removeAllSubviews()
                alert?.removeFromSuperview()
            }).disposed(by: alert.rx.disposeBag)
        }
        
        return alert
    }
    
    // 移除window上Alert
    class func dismiss() {
        for view in rootWindow().subviews {
            if view.isKind(of: TTCustomAlert.self) {
                view.removeFromSuperview()
            }
        }
    }
}


// 如果需要点击其他区域进行隐藏或者改样式，就继承TTTouchHiddenView
class TTAlert: UIView {
    // 背板视图
    var backgroudView = UIView()
    
    // 内容主视图,默认装一个UITextView
    var contentView = UIView()
    
    // 标题
    var titleLable = UILabel.regular(size: 15, textColor: .black)
    
    // 内容
    var mainContentTextView = YYTextView.init()
    
    // 按钮承载面板
    var buttonBoardView = UIView()
    
    
    // 默认最小尺寸
    var defalultMinSize = ttSize(260, 130)
    
    // 默认最大尺寸
    var defalultMaxSize = ttSize(260, 359)
        
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        self.mainContentTextView.setContentOffset(.zero, animated: false)
    }
    
    
    //  创建时传入标题，内容，标题
    @discardableResult
    class func show(parentView: UIView? = nil, maxSize: CGSize = .zero,title: String = "提示",titleFont: UIFont = .medium(16),titleTopInterval: CGFloat = ver(8),messageEdges: UIEdgeInsets = .zero,message: String = "",attributeMessage: NSMutableAttributedString? = nil,spaceBetweenTitleMessage: CGFloat = ver(18),buttonBoardHeight: CGFloat = ver(44),buttonTitles: [String] = ["确认","取消"],customButtons: [UIButton] = [UIButton](),cornerRadius: CGFloat = 20,maskBackGroundColor: UIColor = .gray, leadSpacing: CGFloat = 0, tailSpacing: CGFloat = 0, fixedSpacing: CGFloat = 0,click:@escaping (_ index: Int)->()) -> TTAlert {
        
        let alert = TTAlert()
        alert.settingCornerRadius(20)
        
        alert.backgroudView.isUserInteractionEnabled = true
        alert.backgroudView.backgroundColor = .white
        
        // 添加边框
        alert.contentView.addBorderWithPositon(direction: .bottom, color: segementColor, height: 1)
        alert.contentView.backgroundColor = .red
        
        
        // 设置抗拉伸等级
        alert.titleLable.setContentHuggingPriority(.required, for: .vertical)
        alert.titleLable.text = title
        alert.titleLable.textAlignment = .center
        alert.titleLable.font = titleFont
        
        
      
        // 如果消息不为空
        if attributeMessage != nil {
            if attributeMessage!.length > 0 {
                alert.mainContentTextView.attributedText = attributeMessage
            }
        }else {
            alert.mainContentTextView.text = message
        }
                
        alert.mainContentTextView.textColor = .black
        alert.mainContentTextView.textAlignment = .center
        alert.mainContentTextView.isEditable = false
        alert.mainContentTextView.contentInset = messageEdges
        alert.mainContentTextView.textVerticalAlignment = .top
        alert.mainContentTextView.textContainerInset = .zero
        alert.mainContentTextView.showsVerticalScrollIndicator = false
        
        
    
        
        
         // 添加视图
        alert.addSubview(alert.backgroudView)
        alert.backgroudView.addSubview(alert.titleLable)
        alert.backgroudView.addSubview(alert.mainContentTextView)
        //        alert.backgroudView.addArrangedSubview(alert.contentView)
        alert.backgroudView.addSubview(alert.buttonBoardView)
        
        

        // layout
        alert.backgroudView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
    
            // 如果是自适应,那就自动撑开
            if maxSize.equalTo(.zero) {
                
                // 计算用的最大宽度
                let messageContentWidth = alert.defalultMinSize.width - messageEdges.left - messageEdges.right
                

                // 计算高度
                let layout = YYTextLayout(containerSize: CGSize(width: messageContentWidth, height: CGFloat.greatestFiniteMagnitude), text: NSAttributedString.init(string: message.count > 0 ? message : attributeMessage!.string))
                
                
                // 标题高度
                let  titleLableHeight = alert.titleLable.sizeThatFits(CGSize.init(width: messageContentWidth, height: CGFloat.greatestFiniteMagnitude)).height
                
                // 默认控件的间距和自带的高度
                let defalutConponentsHeight = titleTopInterval + titleLableHeight + spaceBetweenTitleMessage + buttonBoardHeight
                
                if let textHeight = layout?.textBoundingSize.height {
                    
                    // 如果高度小于默认的最小高度，就默认
                    if textHeight + defalutConponentsHeight <= alert.defalultMinSize.height {
                        make.size.equalTo(alert.defalultMinSize)
                    }else if textHeight + defalutConponentsHeight > alert.defalultMaxSize.height {
                        
                        // 是否大于默认最大的高度
                        make.size.equalTo(alert.defalultMaxSize)
                    }else {
                        
                        
                        //  计算高度
//                        var height: CGFloat = 0.0
//
//
//                        print("\(textHeight)")
//
//
//                        height += titleLableHeight + ;
//                        height += defalutConponentsHeight
                        
//                        print("高度 \(height)")
                        let autoSize = CGSize(width: alert.defalultMinSize.width, height: textHeight + defalutConponentsHeight)
                        make.size.equalTo(autoSize)
                    }
                }
            }else {
                make.size.equalTo(maxSize)
            }
        }
        
        
        alert.buttonBoardView.snp.makeConstraints { (make) in
            make.height.equalTo(buttonBoardHeight)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        
        alert.titleLable.snp.makeConstraints { (make) in
            make.top.equalTo(titleTopInterval)
            make.width.equalToSuperview()
        }
        
        alert.mainContentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(alert.titleLable.snp.bottom).offset(spaceBetweenTitleMessage)
            make.width.equalToSuperview()
            make.bottom.equalTo(alert.buttonBoardView.snp.top)
        }
        
        // 如果没有自定义按钮
        var buttonArray = [UIButton]()
        
        
        
        if customButtons.count == 0 {
            
            // 创建按钮
            for index in 0..<buttonTitles.count {
                // 标题
                let buttonTitle =  buttonTitles[index]
                
                
                // 按钮button
                let actionButton = UIButton.title(title: buttonTitle , titleColor: alertButtonColor, font: .regular(13))
                actionButton.setBackgroundImage(UIImage.init(color: #colorLiteral(red: 0.7411764706, green: 0.7450980392, blue: 0.7411764706, alpha: 1),size: ttSize(414)), for: .highlighted)
                alert.buttonBoardView.addSubview(actionButton)
                
                
                
                // 多个按钮，设置右侧border
                if buttonTitles.count > 1 && index != buttonTitles.count - 1 {
                    actionButton.addBorderWithPositon(direction: .right, color: segementColor, height: 0.5)
                }
                
                // 顶部border
                actionButton.addBorderWithPositon(direction: .top, color: segementColor, height: 0.5)
                
                // 按钮点击事件
                actionButton.rx.controlEvent(.touchUpInside).subscribe(onNext:{(_) in
                    click(index)
                    self.hiddenAction(alert: alert)
                }).disposed(by: alert.rx.disposeBag)
                
                
                
                alert.buttonBoardView.addSubview(actionButton)
                
                buttonArray.append(actionButton)
                // 布局
                buttonArray.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 0, leadSpacing: 0, tailSpacing: 0)
                buttonArray.snp.makeConstraints { (make) in
                    make.height.equalToSuperview()
                }
            }
        }else {
            
            // 按钮高度
            var buttonHeight: CGFloat = 0;
            
            // 创建按钮
            for index in 0..<customButtons.count {
                let customButton = customButtons[index]
                customButton.rx.controlEvent(.touchUpInside).subscribe(onNext:{(_) in
                    click(index)
                    self.hiddenAction(alert: alert)
                }).disposed(by: alert.rx.disposeBag)
                
                alert.buttonBoardView.addSubview(customButton)
                buttonHeight = customButton.height
            }
            
            // 布局
            customButtons.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: fixedSpacing, leadSpacing: leadSpacing, tailSpacing: tailSpacing)
            customButtons.snp.makeConstraints { (make) in
                make.height.equalTo(buttonHeight)
                make.bottom.equalTo(-ver(23))
            }
        }
        
        
        
        alert.backgroudView.settingCornerRadius(cornerRadius)
        
        if parentView == nil {
            rootWindow().addSubview(alert)
        }else {
            parentView!.addSubview(alert)
        }
     
        alert.backgroundColor = maskBackGroundColor
        alert.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        // 写这几句，不然
        alert.mainContentTextView.scrollToTop()
        alert.layoutIfNeeded()
        alert.superview?.layoutIfNeeded()

//        alert.superview.layoutIfNeeded()
        return alert
    }
    
    // 隐藏操作
    class func hiddenAction(alert: TTAlert) {
        alert.isHidden = true
        alert.removeAllSubviews()
        alert.removeFromSuperview()
    }
    
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        
        
        let lableSize  = self.titleLable
        print("尺寸为\(lableSize)")
        
        return super.sizeThatFits(size)
    }
}




// 全局显示原生的弹框
func showOriginalAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style = .alert,buttonTitles: [String] = ["确定","取消"],click: @escaping (_  index: Int)->()) {
    
    DispatchQueue.main.async {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: preferredStyle)
        
        
        // 创建action
        for index in 0..<buttonTitles.count {
            // 标题
            let title =  buttonTitles[index]
            
            
            var style = UIAlertAction.Style.default
            
            if title.contains("取消") {
                style = UIAlertAction.Style.cancel
            }
            
            let action = UIAlertAction.init(title: title, style: style) { (action) in
                click(index)
            }
            
            
            alertVC.addAction(action)
        }
        
        
        
        // 显示
        rootWindow().rootViewController?.present(alertVC, animated: true, completion: {
            
        })
    }
    
    

}


class TTAlertConfig: NSObject {
    // 点击隐藏
    var touchHidden = false
    
    // 默认最小尺寸
    var defalultMinSize = ttSize(200, 200)
    
    // 默认最大尺寸
    var defalultMaxSize = ttSize(260, 359)
    
    // 固定size
    var size: CGSize?
    
    // 动画显示时间
    var showAnimateInterval: CGFloat = 0.4
    
    // 动画隐藏时间
    var dismissAnimateInterval: CGFloat = 0.3
    
    // 默认是中间显示的style
    var showAnimateStyle = TTAlertAnimateStyle.center
    
    // 倒内容圆角
    var cornerRadius: CGFloat = 8.0
    
    // 背板背景色
    var maskBackgroundColor = rgba(0, 0, 0, 0.4)
    
    // 是否需要模糊
    var needBlur = false
    
    // 是否忽略关闭按钮的信号
    var ignorcloseButtonSignal = false
    
    // 是否一开始就show
    var justShow = true
    
    // 额外内容高度
    var extraContentHeight: CGFloat = 0.0
    
    // 默认contentView背景色
    var defaultContentViewColor = UIColor.white
    
}

// 思想是灵活，多种样式，方便自定义UI
enum TTAlertAnimateStyle {
    case center // 中心弹出
    case bottom // 底部升起弹出
    case rightToLeft // 右侧出左侧
}




class TTBomttomAlert: TTAlert2 {
    override func setupConfig() {
        super.setupConfig()
        config.touchHidden = true
        config.showAnimateStyle = .bottom
    }
}

class TTCenterAlert: TTAlert2 {
    override func setupConfig() {
        super.setupConfig()
        config.touchHidden = true
        config.showAnimateStyle = .center
    }
}

class TTRightToLeftAlert: TTAlert2 {
    override func setupConfig() {
        super.setupConfig()
        config.touchHidden = true
        config.showAnimateStyle = .rightToLeft
    }
}

class TTAlert2: View {
    // 背板视图
    var backgroudView = UIView()
    
    
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
//            print("点击了阻挡视图")
        }).disposed(by: rx.disposeBag)
        return unEnabelClickMaskView
    }()
    
    // 高斯模糊蒙层
    lazy var blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.subviews[1].isHidden = true
        insertSubview(blurView, at: 0)
        blurView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return blurView
    }()
    
 
  
    
    
    
    // 默认配置
    let config = TTAlertConfig()

    // 内容主视图,默认装一个UITextView
    var contentView = TTAutoSizeView.init(padding: .zero)
    
    // 点击事件
    let event = PublishSubject<Int>()

    // 标题
    lazy var title: UILabel = {
        var title = UILabel.regular(size: 15, textColor: .black)
        contentView.t_addSubViews([title])
        return title
    }()
    
    // 子标题
    lazy var subTitle: UILabel = {
        var subTitle = UILabel.regular(size: 12, textColor: .black)
        contentView.t_addSubViews([subTitle])
        return subTitle
    }()
    
    // 关闭按钮
    lazy var closeButton: UIButton = {
        var  closeButton = UIButton.iconImage(UIImage.init(color: .red, size: .init(width: 30, height: 30)))
        contentView.t_addSubViews([closeButton])
        closeButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            if !self.config.ignorcloseButtonSignal {
                // close默认就是隐藏事件,想监听就在-1控制流里写
                self.event.onNext(-1)
                self.dismiss()
            }
        }).disposed(by: rx.disposeBag)
        return closeButton
    }()
    
    // 主按钮
    lazy var mainButton: UIButton = {
        var  mainButton = UIButton()
        contentView.t_addSubViews([mainButton])
        return mainButton
    }()
    
    // alert栈，可以集中销毁
    static var alertStack = [TTAlert2]()
    
    // 移除所有alert
    class func destroyAllAlert() {
        for alert in alertStack {
            alert.removeFromSuperview()
        }
    }
    
    // 初始化的时候设置Config
    init(_ config: ((TTAlertConfig) -> ())? = nil) {
        config?(self.config)
        super.init(frame: .zero)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeUI() {
        super.makeUI()
        //优先走配置
        setupConfig()
        
        addSubviews([backgroudView,contentView])
        backgroudView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        switch config.showAnimateStyle {
            case .center:
                contentView.snp.makeConstraints { (make) in
                    if config.size != nil {
                        make.size.equalTo(config.size!)
                    }else {
                        make.size.greaterThanOrEqualTo(config.defalultMinSize)
                    }
             
                    make.center.equalToSuperview()
                }
            case .bottom:
                contentView.snp.makeConstraints { (make) in
                    make.centerX.equalToSuperview()
                    make.size.greaterThanOrEqualTo(config.defalultMinSize)
                    make.bottom.equalTo(config.defalultMinSize.height)
                }
            case .rightToLeft:
                contentView.snp.makeConstraints { (make) in
                    make.centerX.equalToSuperview()
                    make.size.greaterThanOrEqualTo(config.defalultMinSize)
                    make.left.equalTo(SCREEN_W)
                }
            default:
                break
        }
        
        
        
        
        // 是否需要高斯模糊
        if config.needBlur {
            blurView.isHidden = false
        }
        
        // 默认配置
        contentView.backgroundColor = config.defaultContentViewColor
        
        //  默认倒圆角
        contentView.cornerRadius = config.cornerRadius
        
        // 背板颜色
        backgroudView.backgroundColor = config.maskBackgroundColor
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        // 做相关配置操作
        if config.touchHidden {
            // config
            backgroudView.rx.tap().subscribe { [weak self] _ in guard let self = self else { return }
                if !self.config.ignorcloseButtonSignal {
                    // close默认就是隐藏事件,想监听就在-1控制流里写
                    self.event.onNext(-1)
                }
                
                // 点击隐藏移除自己
                self.dismiss()
            }.disposed(by: rx.disposeBag)
        }
        
        // 默认直接显示
        if config.justShow {
            show()
        }
    }
    
    // 子类复写,自定义配置
    func setupConfig() {
        
    }
    
    // 添加alert内容
    func addAlertSubViews(_ contentViews: [UIView]) {
        contentView.t_addSubViews(contentViews)
    }
    
    func addAlertSubView(_ view: UIView) {
        contentView.t_addSubViews([view])
    }
    
    
    // 点击事件下标
    func eventIndex(_ index: Int) {
        event.onNext(index)
    }

    
    // MARK: - 显示
    func show() {
        show(animateStyle: config.showAnimateStyle)
    }
    
    // 指定风格和父视图
    func show(animateStyle: TTAlertAnimateStyle,parrentView: UIView = rootWindow()) {
        self.config.showAnimateStyle = animateStyle
        
        // 保护
        parrentView.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // 立即布局
        parrentView.layoutIfNeeded()
        parrentView.bringSubviewToFront(self)
        
        
        // 设置可点击,拦截事件
        unEnabelClickMaskView.isUserInteractionEnabled = true
        switch animateStyle {
        case .center:
            // 改变alpha值
            self.alphaAnimate(duration: config.showAnimateInterval,fromValue: 0.0,toValue: 1.0)
                
            
            // 蒙版是不展示动画的，动画部分是中间center部分
            contentView.scaleAnimate(duration: config.showAnimateInterval,smallToBig: false) {[weak self]  in guard let self = self else { return }
                self.unEnabelClickMaskView.isUserInteractionEnabled = false
            }
            
            
        case .bottom:
            self.backgroudView.alphaAnimate(duration: config.showAnimateInterval,fromValue: 0.0,toValue: 1.0)
            contentView.changeYAnimate(fromY: SCREEN_H,toY: SCREEN_H - config.defalultMinSize.height, duration:  config.showAnimateInterval) {
                [weak self]  in guard let self = self else { return }
                self.unEnabelClickMaskView.isUserInteractionEnabled = false
            }
        case .rightToLeft:
            self.backgroudView.alphaAnimate(duration: config.showAnimateInterval,fromValue: 0.0,toValue: 1.0)
            contentView.changeXAnimate(fromX: SCREEN_W, toX: SCREEN_W - config.defalultMinSize.width, duration:  config.showAnimateInterval) {[weak self] (_,_) in guard let self = self else { return }
                self.unEnabelClickMaskView.isUserInteractionEnabled = false
            }
        default:
            break
        }
        
        TTAlert2.alertStack.append(self)
    }
    
    
    // 隐藏
    func dismiss(){
       dismiss(animate: true,needRemove: true)
    }
    
    // 根据要不要显示动画去隐藏
    func dismiss(animate: Bool,needRemove: Bool = true) {
        dismiss(animate: animate,needRemove: needRemove) {
            
        }
    }
    
    // 根据动画，和完成回调
    func dismiss(animate: Bool = true,needRemove: Bool,complte:@escaping () -> ()) {
        if animate {
            // 设置可点击,拦截事件
            unEnabelClickMaskView.isUserInteractionEnabled = true
            switch config.showAnimateStyle {
            case .center:
                self.alphaAnimate(duration: config.dismissAnimateInterval,fromValue: 1.0,toValue: 0.0) {[weak self]  in guard let self = self else { return }
                    complte()
                    if needRemove {
                        self.destory()
                    }
                }
            case .bottom:
                backgroudView.alphaAnimate(duration: config.dismissAnimateInterval,fromValue: 1.0,toValue: 0.0)
                contentView.changeYAnimate(fromY:SCREEN_H - config.defalultMinSize.height , toY: SCREEN_H + config.extraContentHeight,duration: CGFloat(config.dismissAnimateInterval)) {[weak self]  in guard let self = self else { return }
                    complte()
                    if needRemove {
                        self.destory()
                    }
                }
            case .rightToLeft:
                backgroudView.alphaAnimate(duration: config.dismissAnimateInterval,fromValue: 1.0,toValue: 0.0)
                contentView.changeXAnimate(fromX: SCREEN_W - config.defalultMinSize.width, toX: SCREEN_W, duration:  config.showAnimateInterval) {[weak self] (_,_) in guard let self = self else { return }
                    complte()
                    if needRemove {
                        self.destory()
                    }
                }
            default:
                break
            }
        }else {
            if needRemove {
                self.destory()
            }
        }
    }
    
    
    func destory() {
        TTAlert2.alertStack.removeFirst { (alert) -> Bool in
            let result = self == alert
            if result {
                alert.removeFromSuperview()
            }
            return result
        }
    }
    
    
    deinit {
        // 我被销毁了
        debugPrint("我是alert,我被销毁了")
    }
}

