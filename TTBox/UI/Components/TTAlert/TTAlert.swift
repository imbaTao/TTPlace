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
    
    // 默认支持缩放动画
    var enableScaleAnimate = true
    
}

// 思想是灵活，多种样式，方便自定义UI
enum TTAlertAnimateStyle {
    case free // 中心弹出没有缩放动画
    case center // 中心弹出
    case bottom // 底部升起弹出
    case rightToLeft // 右侧出左侧
}




class TTBomttomAlert: TTAlert {
    override func setupConfig() {
        super.setupConfig()
        config.touchHidden = true
        config.showAnimateStyle = .bottom
    }
}

class TTFreeAlert: TTAlert {
    override func setupConfig() {
        super.setupConfig()
        config.touchHidden = true
        config.showAnimateStyle = .free
    }
}

class TTCenterAlert: TTAlert {
    override func setupConfig() {
        super.setupConfig()
        config.touchHidden = true
        config.showAnimateStyle = .center
    }
}

class TTRightToLeftAlert: TTAlert {
    override func setupConfig() {
        super.setupConfig()
        config.touchHidden = true
        config.showAnimateStyle = .rightToLeft
    }
}

class TTAlert: View {
    // 背板视图,这里用Button，为了避免跟手势冲突https://blog.gocy.tech/2016/11/19/iOS-touch-handling/
    var backgroudView = UIButton()
    
    
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
    var contentView = TTAutoSizeView()
    
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
    static var alertStack = [TTAlert]()
    
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
            case .free:
                // 自由风格约束由外部控制
                break
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
            backgroudView.rx.controlEvent(.touchUpInside).subscribe { [weak self] _ in guard let self = self else { return }
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
        self.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // 立即布局
        parrentView.layoutIfNeeded()
        parrentView.bringSubviewToFront(self)
        self.isHidden = false
        
        // 设置可点击,拦截事件
        unEnabelClickMaskView.isUserInteractionEnabled = true
        switch animateStyle {
        case .free:
            // 改变alpha值
            self.alphaAnimate(duration: config.showAnimateInterval,fromValue: 0.0,toValue: 1.0) {
                self.unEnabelClickMaskView.isUserInteractionEnabled = false
            }
        case .center:
            // 改变alpha值
            self.alphaAnimate(duration: config.showAnimateInterval,fromValue: 0.0,toValue: 1.0) {
                self.unEnabelClickMaskView.isUserInteractionEnabled = false
            }
            
            if config.enableScaleAnimate {
                // 蒙版是不展示动画的，动画部分是中间center部分
                contentView.scaleAnimate(duration: config.showAnimateInterval,smallToBig: false) {[weak self]  in guard let self = self else { return }
                    self.unEnabelClickMaskView.isUserInteractionEnabled = false
                }
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
        
        TTAlert.alertStack.append(self)
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
            case .free:
                self.alphaAnimate(duration: config.dismissAnimateInterval,fromValue: 1.0,toValue: 0.0) {[weak self]  in guard let self = self else { return }
                    complte()
                    self.isHidden = true
                    if needRemove {
                        self.destory()
                    }
                }
            case .center:
                self.alphaAnimate(duration: config.dismissAnimateInterval,fromValue: 1.0,toValue: 0.0) {[weak self]  in guard let self = self else { return }
                    complte()
                    self.isHidden = true
                    if needRemove {
                        self.destory()
                    }
                }
            case .bottom:
                backgroudView.alphaAnimate(duration: config.dismissAnimateInterval,fromValue: 1.0,toValue: 0.0)
                contentView.changeYAnimate(fromY:SCREEN_H - config.defalultMinSize.height , toY: SCREEN_H + config.extraContentHeight,duration: CGFloat(config.dismissAnimateInterval)) {[weak self]  in guard let self = self else { return }
                    complte()
                    self.isHidden = true
                    if needRemove {
                        self.destory()
                    }
                }
            case .rightToLeft:
                backgroudView.alphaAnimate(duration: config.dismissAnimateInterval,fromValue: 1.0,toValue: 0.0)
                contentView.changeXAnimate(fromX: SCREEN_W - config.defalultMinSize.width, toX: SCREEN_W, duration:  config.showAnimateInterval) {[weak self] (_,_) in guard let self = self else { return }
                    complte()
                    self.isHidden = true
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
        TTAlert.alertStack.removeFirst { (alert) -> Bool in
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

