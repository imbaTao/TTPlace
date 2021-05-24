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

//        showAlert(title: "系统坦克", message: "我是标题")
//        showOriginalAlert(title: "系统坦克", message: "我是标题") { (index) in
//
//        }
 
    }
    
    

    
    // 问题是，我如何重新拿到之前布局的UI控件，做刷新
    @objc func configureView()  {
        view.removeAllSubviews()
        view.backgroundColor = .gray
        
        
        let button = UIButton.init()
        button.backgroundColor = .red
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.size.equalTo(44)
            make.center.equalToSuperview()
        }
        
        button.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            print("111")
            
            self.shakeAnimate(view: button, fromY: 0, toY: 0)
        }).disposed(by: rx.disposeBag)
   }
    
    /// MARK: - 摇摆动画
    func shakeAnimate(view: UIView,fromY: CGFloat,toY: CGFloat,duration: CGFloat = 0.5,easyInOut: Bool = true,spring: Bool = true,complte: (() -> ())? = nil) {
        if view.height == 0 {
            view.layoutIfNeeded()
        }
        
        if  let positonYAnimation = POPBasicAnimation(propertyNamed: kPOPLayerRotation) {
            if easyInOut {
//                // 透明度动画
//                var fromAlpha = 0.0
//                var toAlpha = 0.0
//                let alphaAnimate =  POPBasicAnimation.init(propertyNamed: kPOPViewAlpha)
//                if toY > 0 {
//                    fromAlpha = 0.8
//                    toAlpha = 1.0
//                    alphaAnimate?.fromValue = fromAlpha
//                    alphaAnimate?.toValue = toAlpha
//                    alphaAnimate?.duration = CFTimeInterval(duration)
//                    alphaAnimate?.timingFunction = CAMediaTimingFunction.init(name: .easeIn)
//                }else {
//                    fromAlpha = 1.0
//                    toAlpha = 0.8
//                    alphaAnimate?.fromValue = toAlpha
//                    alphaAnimate?.toValue = fromAlpha
//                    alphaAnimate?.duration = CFTimeInterval(duration)
//                    alphaAnimate?.timingFunction = CAMediaTimingFunction.init(name: .easeOut)
//                }
//                pop_add(alphaAnimate, forKey: kPOPViewAlpha)
            }
            
//            POPBasicAnimation * basic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
//              basic.toValue = [NSNumber numberWithFloat: M_PI * 2.0];
//              basic.duration = 2;
//              basic.repeatForever = YES;
//              basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//              basic.removedOnCompletion = NO;
//              [self pop_addAnimation:basic forKey:@"refreshRotationKey"];
            
            // 锚点默认在0.5,0.5所以要加上一个一半的宽度
//            let posionStarY = ceil(view.height / 2.0)
//            positonYAnimation.fromValue = 0
            positonYAnimation.toValue = Double.pi / 2
            positonYAnimation.duration = CFTimeInterval(2)
            positonYAnimation.repeatForever = true
            positonYAnimation.removedOnCompletion = false
            
//            458752
            positonYAnimation.timingFunction =   CAMediaTimingFunction.init(name: .linear)
            view.layer.pop_add(positonYAnimation, forKey: kPOPLayerRotation)
            positonYAnimation.completionBlock = { [weak self]  (animation,finished) in guard let self = self else { return }
                if finished {
//                    if spring {
//                        let springAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleY)
//                        springAnimation?.velocity = 10
//                        springAnimation?.toValue = 1
//                        springAnimation?.springBounciness = 18
//                        self.layer.pop_add(springAnimation, forKey: kPOPLayerScaleY)
//                    }
                    
                    complte?()
                }
            }
        }else {
            print("动画执行失败了！！😤😤😤😤😤")
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
