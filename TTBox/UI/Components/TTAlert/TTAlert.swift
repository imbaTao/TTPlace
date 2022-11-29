//
//  TTAlert.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/11/5.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

// 思想是灵活，多种样式，方便自定义UI
enum TTAlertAnimateStyle {
    case free  // 中心弹出没有缩放动画
    case center  // 中心弹出
    case bottom  // 底部升起弹出
    case rightToLeft  // 右侧出左侧
    case leftToRight  // 左侧出右侧
}

class TTAlert: TTView {
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
        unEnabelClickMaskView.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            // 空事件，只做拦截
            // debugPrint("点击了阻挡视图")
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

    // 消失事件
    let dissMissComplete = PublishSubject<Void>()

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
        var closeButton = UIButton.iconImage(
            UIImage.init(color: .red, size: .init(width: 30, height: 30)))
        contentView.t_addSubViews([closeButton])
        closeButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
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
        var mainButton = UIButton()
        contentView.t_addSubViews([mainButton])
        return mainButton
    }()

    // 取消按钮
    lazy var cancleButton: UIButton = {
        var cancleButton = UIButton.regular(size: 14, textColor: .white, text: "取消")
        cancleButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            self.dismiss()
            self.eventIndex(0)
        }).disposed(by: rx.disposeBag)
        return cancleButton
    }()

    // 确认按钮
    lazy var sureButton: UIButton = {
        var sureButton = UIButton.regular(size: 14, textColor: .white, text: "确定")
        sureButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] (_) in
            guard let self = self else { return }
            if self.config.ignorcloseButtonSignal == false {
                self.dismiss()
            }
            self.eventIndex(1)
        }).disposed(by: rx.disposeBag)
        return sureButton
    }()

    //这个场景里需要使用具有初速度的弹簧动画，使用 Spring Timing 进行配置
    let timing = UISpringTimingParameters(dampingRatio: 1, initialVelocity: CGVector(dx: 0, dy: 1))
    lazy var animator: UIViewPropertyAnimator = {
        var animator: UIViewPropertyAnimator = UIViewPropertyAnimator(
            duration: 0.7, timingParameters: timing)
        return animator
    }()

    // alert栈，可以集中销毁
    static var alertStack = NSHashTable<TTAlert>.init(options: .weakMemory)

    // 找到某个类型的alert
    class func fetchAlert<T: TTAlert>(type: T.Type) -> T? {
        for item in alertStack.allObjects {
            if item.isMember(of: T.self) {
                return (item as! T)
            }
        }

        return nil
    }

    class func removeAlert<T: TTAlert>(type: T.Type) {
        // 找到了先移除上一个
        if let alert = fetchAlert(type: type) {
            alert.dismiss(animate: false)
        }
    }

    // 移除所有alert
    class func destroyAllAlert() {
        for alert in alertStack.allObjects {
            alert.removeFromSuperview()
        }
    }

    // 初始化的时候设置Config
    init(_ configBlock: ((TTAlertConfig) -> Void)? = nil) {
        configBlock?(self.config)
        super.init(frame: .zero)

        // 如果有横屏尺寸,且是从底部出来的风格，才处理监听旋转
        if let _ = self.config.landscapeAnimateStyle {
            TTDevice.shared.orientationDidChangeRelay.skip(1).subscribe(onNext: {
                [weak self] (orientation) in guard let self = self else { return }
                self.remakeLayout(orientation: orientation)
            }).disposed(by: rx.disposeBag)
        }
    }

    // MARK: - 根据方向重新布局
    func remakeLayout(orientation: UIInterfaceOrientation) {
        layoutByStyle()
    }

    override func makeUI() {
        super.makeUI()
        //优先走配置
        setupConfig()
        setupConfig(config: self.config)

        addSubviews([backgroudView, contentView])
        backgroudView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        layoutByStyle()
        
        // config
        self.backgroudView.alpha = 0

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
    
    func layoutByStyle() {
        guard contentView.superview != nil else { return }
        
        // 先移除
        contentView.snp.removeConstraints()
        
        // 根据显示风格设置约束
        switch config.showAnimateStyle {
        case .free:
            // 自由风格约束由外部控制
            break
        case .center:
            contentView.snp.remakeConstraints { (make) in
                make.center.equalToSuperview()
            }
        case .bottom:
            contentView.snp.remakeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(isShow ? 0 : orientationSize.height + config.offSet)
            }
        case .rightToLeft:
            contentView.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.right.equalTo(isShow ? 0 : orientationSize.width + config.offSet)
            }
        case .leftToRight:
            contentView.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(isShow ? 0 : -(orientationSize.width + config.offSet))
            }
        }
        
        contentView.snp.makeConstraints { make in
            if let absoluteWidth = config.absouluteWidth {
                make.width.equalTo(absoluteWidth)
            }else {
                make.width.equalTo(orientationSize.width)
            }
            
            if let absoluteHeight = config.absouluteHeight {
                make.height.equalTo(absoluteHeight)
            }else {
                make.height.greaterThanOrEqualTo(orientationSize.height)
            }
        }
    }
    

    override func bindViewModel() {
        super.bindViewModel()

        // 做相关配置操作
        if config.touchHidden {
            // config
            backgroudView.rx.controlEvent(.touchUpInside).subscribe { [weak self] _ in
                guard let self = self else { return }

                if !self.config.ignorcloseButtonSignal {
                    // close默认就是隐藏事件,想监听就在-1控制流里写
                    self.event.onNext(-1)

                    // 结束全局编辑，收起键盘
                    rootWindow().endEditing(true)
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

    func setupConfig(config: TTAlertConfig) {

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
    var isShow = false
  
    // 指定风格和父视图
    func show(parrentView: UIView = rootWindow(), animate: Bool = true
    ) {
        if self.superview == nil {
            // 保护
            parrentView.addSubview(self)
         
            
            // 添加到alert栈中
            TTAlert.alertStack.add(self)
        }
 
        
        self.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        parrentView.bringSubviewToFront(self)
        self.isHidden = false
        
        // 必须立即布局，否则动画会有问题
        self.layoutIfNeeded()
        
        self.animateAction(isShow: true)
        
        // 收起全局键盘
        TTKeyboardManager.shared.dismissKeyboard()
    }
    

    // 是否展示动画
    func animateAction(isShow: Bool, _ needRemove: Bool = true) {
        // 停止之前动画
        animator.stopAnimation(false)
        animator.finishAnimation(at: .current)

        // 创建一个新的timing
        let timing = UICubicTimingParameters.init(animationCurve: .easeInOut)
        animator = UIViewPropertyAnimator(
            duration: isShow ? config.showAnimateInterval : config.dismissAnimateInterval,
            timingParameters: timing)

        // 如果是中心弹框,默认直接显示背板
        if config.showAnimateStyle == .center || config.showAnimateStyle == .free {
            backgroudView.alpha = 1
            if isShow {
                self.alpha = 0
            }
        }

        animator.addAnimations {
            // 更改蒙版颜色
            switch self.config.showAnimateStyle {
            case .center:
                self.alpha = isShow ? 1 : 0
            case .free:
                self.alpha = isShow ? 1 : 0
            case .bottom:
                self.contentView.snp.updateConstraints { (make) in
                    make.bottom.equalTo(isShow ? -self.config.offSet : SCREEN_H)
                }
            case .rightToLeft:
                self.contentView.snp.updateConstraints { (make) in
                    make.right.equalTo(isShow ? -self.config.offSet : SCREEN_W)
                }
            case .leftToRight:
                self.contentView.snp.updateConstraints { (make) in
                    make.left.equalTo(isShow ? self.config.offSet : -self.orientationSize.width)
                }
            }

            // 位移弹框,背景框配置
            switch self.config.showAnimateStyle {
            case .bottom, .leftToRight, .rightToLeft:
                self.backgroudView.alpha = isShow ? 1 : 0
                self.layoutIfNeeded()
            default:
                break
            }
        }

        animator.startAnimation()

        // 动画开始后不可点击
        unEnabelClickMaskView.isUserInteractionEnabled = true
        animator.addCompletion { [weak self] position1 in guard let self = self else { return }
            switch position1 {
            case .start:
                break
            case .end:
                self.unEnabelClickMaskView.isUserInteractionEnabled = false
                if isShow == false, needRemove {
                    self.destory()
                } else if needRemove {
                    self.isHidden = true
                }
            case .current:
                break
            @unknown default:
                break
            }

            self.isShow = isShow
            self.isHidden = !isShow
        }
    }

    // 隐藏
    func dismiss() {
        dismiss(animate: true, needRemove: true)
    }

    // 根据要不要显示动画去隐藏
    func dismiss(animate: Bool, needRemove: Bool = true) {
        self.animateAction(isShow:false, needRemove)
    }

    func destory() {
        self.isHidden = true

        // 消失事件
        dissMissComplete.onNext(())

        // 标记移除
        self.removeFromSuperview()
    }

    // 旋转中的尺寸,默认竖屏
    var orientationSize: CGSize {
        if let absoluteWidth = config.absouluteWidth,let absouluteHeight = config.absouluteHeight {
            return .init(width: absoluteWidth, height: absouluteHeight)
        }

        switch TTDevice.shared.orientationDidChangeRelay.value {
        case .portraitUpsideDown, .portrait:
            return config.portraitSize
        case .landscapeLeft, .landscapeRight:
            if config.landSize != nil {
                return config.landSize!
            } else {
                return config.portraitSize
            }
        default:
            return UIWindow.isPortraitOrientation
                ? config.portraitSize : (config.landSize ?? config.portraitSize)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        // 我被销毁了
        debugPrint("我是alert,我被销毁了")
    }
}

extension UIWindow {
    static var isPortraitOrientation: Bool {
        return UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height
    }

    static var isLandOrientation: Bool {
        return UIScreen.main.bounds.size.width > UIScreen.main.bounds.size.height
    }
}

extension TTAlert {
    // 添加底部按钮
    func addCancelAndSureButton(borderColor: UIColor) {
        addAlertSubViews([cancleButton, sureButton])

        cancleButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(44)
        }

        sureButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(cancleButton)
        }

        alertButtonsAddBorder(buttons: [cancleButton, sureButton], borderColor: borderColor)
    }

    // MARK: - 添加alert里两个按钮border
    private func alertButtonsAddBorder(buttons: [UIView], borderColor: UIColor) {
        for button in buttons {
            if button == buttons.first! {
                button.addBorderWithPositon(
                    direction: .top, color: borderColor, height: .onePointHeight)
                button.addBorderWithPositon(
                    direction: .right, color: borderColor, height: .onePointHeight)
            } else {
                button.addBorderWithPositon(
                    direction: .top, color: borderColor, height: .onePointHeight)
            }
        }
    }

    // 是否顶部有弹框
    static var hasAlertShow: Bool {
        return rootWindow().subviews.contains { (subView) -> Bool in
            return subView.isKind(of: TTAlert.self)
        }
    }
}
