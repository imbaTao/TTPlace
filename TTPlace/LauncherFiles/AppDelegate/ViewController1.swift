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
        configureView()
    }
    
    

    
    // 问题是，我如何重新拿到之前布局的UI控件，做刷新
    @objc func configureView()  {
//        view.removeAllSubviews()
//        view.backgroundColor = .gray
        
        
        let button = UIButton.init()
        button.backgroundColor = .red
        button.setImage(UIImage.name("test"), for: .normal)
        button.cornerRadius = 8
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.size.equalTo(100)
            make.center.equalToSuperview()
        }
        
        button.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
//            print("111")
            
//       self.shakeAnimate(view: button, fromY: 0, toY: 0)
            
            self.marqueeView.addNormalContent(contents: ["123","skjdlkajdslkfj","0982308410283409"])
        }).disposed(by: rx.disposeBag)
   }
    
    let marqueeView = TTMarqueeView()
    override func makeUI() {
        super.makeUI()
        marqueeView.backgroundColor = rgba(143, 64, 246, 0.8)
        
        addSubviews([marqueeView])
        marqueeView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(200)
            make.height.equalTo(30)
        }
        
    }
}





// 跑马灯
class TTMarqueeView: TTControll {
    let contentLabel = UILabel.regular(size: 14, textColor: .white, text: "", alignment: .left)
    
    // 速度
    let speed: CGFloat = 0.8
    
    // 步进
    let stepInstance: CGFloat = 2
    
    // 数据源
    var data = [TTMarqueeModel]()
    
    // 点击选中事件
    var selectedAction: ((TTMarqueeModel) -> ())?
    
    // 定时器回收袋
    var runDisposeBag = DisposeBag()
    var isRunning = false
    
    override func makeUI() {
        super.makeUI()
        addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(SCREEN_W)
        }
        
        layoutIfNeeded()
        
        // 背景色
        backgroundColor = .red
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        // 点击事件
        rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            if let currentModel = self.data.first {
                if currentModel.canSelection {
                    self.selectedAction?(currentModel)
                }
            }
        }).disposed(by: rx.disposeBag)
    }
    
    // 开始运行
    func run() {
        if !isRunning {
            // 每秒移动
            TTTimer.shared.displayTimer.subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
                // 如果右侧小于边界
                if self.contentLabel.right > 0 {
                    self.contentLabel.x -= self.speed * self.stepInstance
                }else {
                    self.checkNext()
                }
            }).disposed(by: runDisposeBag)
            
            
            isRunning = true
        }
    }
    
    // 停止运行
    func stop() {
        runDisposeBag = DisposeBag()
        // 隐藏自己,重置位置
        self.isHidden = true
        resetLabelPositon()
        isRunning = false
    }
    
    // 检测是否有下一个精灵
    func checkNext() {
        // 移除最后一个
        if let _ = data.first {
            data.removeFirst()
        }
        
        // 仍然有值,
        if let model = data.first {
            changeContent(model)
            if !isRunning {
                run()
            }
        }else {
            stop()
        }
    }
    
    
    
    
    
    // 添加内容模型
    func addContent(model: TTMarqueeModel) {
        data.append(model)
    }
    
    
    // 变更内容
    func changeContent(_ model: TTMarqueeModel) {
        switch model.type {
        case .normalText:
            contentLabel.text = model.textContent
        case .attributeText:
            contentLabel.attributedText = model.attributeContent
        }
        
        // 显示自己
        self.isHidden = false
        
        // 变更内容的时候run
        run()
    }
    
    // 重置label位置
    private func resetLabelPositon() {
        self.contentLabel.x = SCREEN_W
    }
}


extension TTMarqueeView {
    // 添加常规文本内容
    func addNormalContent(contents: [String]) {
        for item in contents {
            addContent(model: TTMarqueeModel.normalTextModel(text: item))
        }
        
        // 设置第一个为内容
        if let model = data.first {
            changeContent(model)
        }
    }
}










enum TTMarqueeModelType {
    case normalText
    case attributeText
}

class TTMarqueeModel: NSObject {
    
    // 纯文本
    var textContent: String = ""
    
    // 富文本
    var attributeContent: NSMutableAttributedString?

    let type: TTMarqueeModelType = .normalText

    // 可以点击
    var canSelection = false
    
    
    
    // 普通文本model
    class func normalTextModel(text: String) -> TTMarqueeModel {
        let model = TTMarqueeModel()
        model.textContent = text
        return model
    }
}














//private func get3DTransformation(angle: Double) -> CATransform3D {
//
//var transform = CATransform3DIdentity
//transform.m34 = -1.0 / 500.0
//transform = CATransform3DRotate(transform, CGFloat(angle * Double.pi / 180.0), 0, 1, 0.0)
//
//return transform
//}
//
//private func flipAnimation(view: UIView, completion: @escaping (() -> Void) = {}) {
//
//let angle = 180.0
//view.layer.transform = get3DTransformation(angle: angle)
//
////            .TransitionNone
//UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .transitionCrossDissolve, animations: { () -> Void in
//    view.layer.transform = CATransform3DIdentity
//    }) { (finished) -> Void in
//        completion()
//}
//}
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
