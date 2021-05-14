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


class ViewController1: ViewController,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureView),
                                               name: Notification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil)

     
        
       
//        configureView()

        showAlert(title: "系统坦克", message: "我是标题")
        showOriginalAlert(title: "系统坦克", message: "我是标题") { (index) in
            
        }
    }
    
    
    
    // 问题是，我如何重新拿到之前布局的UI控件，做刷新
    @objc func configureView()  {
        view.removeAllSubviews()
        rootWindow().removeSubviews()
        
        
   
    
//        let alert = RoomAlert()
//        alert.backgroundColor = .orange
        
        
    
        
    
   }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let alert = RoomAlert()
        alert.backgroundColor = .orange
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
//        config.showAnimateStyle = .bottom
        config.showAnimateStyle = .center

    }
}


class TTAlertConfig: NSObject {
    // 点击隐藏
    var touchHidden = false
    
    // 默认最小尺寸
    var defalultMinSize = ttSize(260, 130)
    
    // 默认最大尺寸
    var defalultMaxSize = ttSize(260, 359)
    
    // 动画显示时间
    var showAnimateInterval: CGFloat = 0.4
    
    // 动画隐藏时间
    var dismissAnimateInterval: CGFloat = 0.3
    
    // 默认是中间显示的style
    var showAnimateStyle = TTAlertAnimateStyle.center
}

// 思想是灵活，多种样式，方便自定义UI
enum TTAlertAnimateStyle {
    case center // 中心弹出
    case bottom // 底部升起弹出
}


class TTAlert2: View {
    // 背板视图
    var backgroudView = UIView()
    
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
            
            // close默认就是隐藏事件,想监听就在-1控制流里写
            self.event.onNext(-1)
            self.dismiss()
        }).disposed(by: rx.disposeBag)
        return closeButton
    }()
    
    // 主按钮
    lazy var mainButton: UIButton = {
        var  mainButton = UIButton.iconImage(UIImage.init(color: .red, size: .init(width: 30, height: 30)))
        contentView.t_addSubViews([mainButton])
        return mainButton
    }()
    
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
                    make.size.greaterThanOrEqualTo(config.defalultMinSize)
                    make.center.equalToSuperview()
                }
                
            case .bottom:
                contentView.snp.makeConstraints { (make) in
                    make.centerX.equalToSuperview()
                    make.size.greaterThanOrEqualTo(config.defalultMinSize)
                    make.bottom.equalTo(config.defalultMinSize.height)
                }
            default:
                break
        }
        

      
        // 默认配置
        contentView.backgroundColor = .white
        contentView.cornerRadius = 8
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        // 做相关配置操作
        if config.touchHidden {
            // config
            backgroudView.rx.tap().subscribe { [weak self] _ in guard let self = self else { return }
                // 点击隐藏移除自己
                self.dismiss()
            }.disposed(by: rx.disposeBag)
        }
        
        show()
    }
    
    // 子类复写,自定义配置
    func setupConfig() {
        
    }
    

    
    /// MARK: - 显示
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
        
        
        switch animateStyle {
        case .center:
            // 改变alpha值
            self.alphaAnimate(duration: config.showAnimateInterval,fromValue: 0.0,toValue: 1.0)
                
            // 蒙版是不展示动画的，动画部分是中间center部分
            contentView.scaleAnimate(duration: config.showAnimateInterval,smallToBig: false)
            break
        case .bottom:
            contentView.changeYAnimate(fromY: SCREEN_H, toY: SCREEN_H - config.defalultMinSize.height)
        default:
            break
        }
    }
    
    
    // 隐藏
    func dismiss(){
        switch config.showAnimateStyle {
        case .center:
            self.alphaAnimate(duration: config.dismissAnimateInterval,fromValue: 1.0,toValue: 0.0) {
                self.removeFromSuperview()
            }
        case .bottom:
            contentView.changeYAnimate(fromY:SCREEN_H - config.defalultMinSize.height , toY: SCREEN_H,duration: CGFloat(config.dismissAnimateInterval)) {
                self.removeFromSuperview()
            }
        default:
            break
        }
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
