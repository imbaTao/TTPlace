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
        
        
        
//        let banner = TTNormalCarousel()
//        addSubview(banner)
//        banner.snp.makeConstraints { (make) in
//            make.top.equalTo(100)
//            make.left.right.equalToSuperview()
//            make.height.equalTo(100)
//        }
//
//        banner.items = ["https://gimg2.baidu.com/image_search/src=http%3A%2F%2F1812.img.pp.sohu.com.cn%2Fimages%2Fblog%2F2009%2F11%2F18%2F18%2F8%2F125b6560a6ag214.jpg&refer=http%3A%2F%2F1812.img.pp.sohu.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1625986747&t=ec33bebaaffe3d2955f52eef9cac22ea",
//        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F1812.img.pp.sohu.com.cn%2Fimages%2Fblog%2F2009%2F11%2F18%2F18%2F8%2F125b6560a6ag214.jpg&refer=http%3A%2F%2F1812.img.pp.sohu.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1625986747&t=ec33bebaaffe3d2955f52eef9cac22ea","https://gimg2.baidu.com/image_search/src=http%3A%2F%2F1812.img.pp.sohu.com.cn%2Fimages%2Fblog%2F2009%2F11%2F18%2F18%2F8%2F125b6560a6ag214.jpg&refer=http%3A%2F%2F1812.img.pp.sohu.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1625986747&t=ec33bebaaffe3d2955f52eef9cac22ea"]
        
        let tempView1 = TTChooseAvatarView()
        tempView1.backgroundColor = .red
        self.view.addSubview(tempView1)
        tempView1.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 100, height: 100))
        }
        
        tempView1.chooseAvatarComplete.subscribe(onNext: {[weak tempView1] (image) in guard let tempView1 = tempView1 else { return }
            tempView1.uploadComplte = true
        }).disposed(by: rx.disposeBag)
        
//        tempView1.testBlock = { image in
//            return Single<(Bool)>.create {(single) -> Disposable in
//
//                TTNet.requst(type:.post,api: "a").subscribe {[weak self] (model) in
//                    single(.success(false))
//                } onError: { (error) in
//                    single(.error(false))
//                }.disposed(by: rx.disposeBag)
//
//                return Disposables.create {}
//            }
//        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            tempView1.removeFromSuperview()
        }
        
    }
    
    

    
    // 问题是，我如何重新拿到之前布局的UI控件，做刷新
    @objc func configureView()  {
        view.removeAllSubviews()
        view.backgroundColor = .gray
        
        
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
            print("111")
            
//            self.shakeAnimate(view: button, fromY: 0, toY: 0)
            
            self.showResultAnimate(button)
        }).disposed(by: rx.disposeBag)
   }
    
    /// MARK: - 摇摆动画
    func shakeAnimate(view: UIView,fromY: CGFloat,toY: CGFloat,duration: CGFloat = 0.5,easyInOut: Bool = true,spring: Bool = true,complte: (() -> ())? = nil) {
        
        let duration: CFTimeInterval = 0.2
        
        if  let positonYAnimation = POPBasicAnimation(propertyNamed: kPOPLayerRotation) {
            positonYAnimation.toValue = Double.pi / 2
            positonYAnimation.duration = duration
            positonYAnimation.repeatForever = false
            positonYAnimation.removedOnCompletion = false
            
//            458752
            positonYAnimation.timingFunction =   CAMediaTimingFunction.init(name: .linear)
            view.layer.pop_add(positonYAnimation, forKey: kPOPLayerRotation)
            
            
            let springAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleY)
             springAnimation?.velocity = 10
             springAnimation?.toValue = 1
             springAnimation?.springBounciness = 18
             view.layer.pop_add(springAnimation, forKey: kPOPLayerScaleY)

            // 向右完成
            positonYAnimation.completionBlock = { [weak self]  (animation,finished) in guard let self = self else { return }
                if finished {

                    //  还原
                    if  let positonYAnimation = POPBasicAnimation(propertyNamed: kPOPLayerRotation) {
                        positonYAnimation.toValue = 0
                        positonYAnimation.duration = duration
                        positonYAnimation.repeatForever = false
                        positonYAnimation.removedOnCompletion = false
                        positonYAnimation.timingFunction =   CAMediaTimingFunction.init(name: .linear)
                        view.layer.pop_add(positonYAnimation, forKey: kPOPLayerRotation)
                        positonYAnimation.completionBlock = { [weak self]  (animation,finished) in guard let self = self else { return }
                            complte?()
                        }
                    }
                }
            }
        }else {
            print("动画执行失败了！！😤😤😤😤😤")
        }
    }
    
    
    
    // 展示结果
    func showResultAnimate(_ view: UIView) {
        
        let duration: CFTimeInterval = 0.5
        
        // 从中心，到左上角
        if  let positonYAnimation = POPBasicAnimation(propertyNamed: kPOPLayerCornerRadius) {
            positonYAnimation.toValue = 20
            positonYAnimation.duration = duration
            positonYAnimation.repeatForever = false
            positonYAnimation.removedOnCompletion = false
            
            positonYAnimation.timingFunction =   CAMediaTimingFunction.init(name: .linear)
            view.layer.pop_add(positonYAnimation, forKey: kPOPLayerCornerRadius)
        }
        
        
        // 从中心，到左上角
        if  let positonYAnimation = POPBasicAnimation(propertyNamed: kPOPViewFrame) {
            positonYAnimation.toValue = NSValue.init(cgRect: CGRect.init(x: 30, y: 30, width: 40, height: 40))
            positonYAnimation.duration = duration
            positonYAnimation.repeatForever = false
            positonYAnimation.removedOnCompletion = false
            
            positonYAnimation.timingFunction = CAMediaTimingFunction.init(name: .linear)
            view.layer.pop_add(positonYAnimation, forKey: kPOPViewFrame)
            
            positonYAnimation.completionBlock = { [weak self]  (animation,finished) in guard let self = self else { return }
                
                
                let rotationDuration: CFTimeInterval = 1
                if  let positonYAnimation = POPBasicAnimation(propertyNamed: kPOPLayerRotationX) {
                    positonYAnimation.fromValue = 0
                    positonYAnimation.toValue = Double.pi * 3
                    positonYAnimation.duration = rotationDuration
//                    positonYAnimation.repeatCount = 1
                    positonYAnimation.repeatForever = false
                    positonYAnimation.removedOnCompletion = false

                    positonYAnimation.timingFunction = CAMediaTimingFunction.init(name: .linear)
                    view.layer.pop_add(positonYAnimation, forKey: "rotation")
                }
                
                
                
//                self.flipAnimation(view: view)
                
                
                if  let positonYAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha) {
                    positonYAnimation.toValue = 0
                    positonYAnimation.duration = rotationDuration
//                    positonYAnimation.repeatCount = 4
                    positonYAnimation.repeatForever = false
                    positonYAnimation.removedOnCompletion = true

                    positonYAnimation.timingFunction = CAMediaTimingFunction.init(name: .linear)
                    view.pop_add(positonYAnimation, forKey: kPOPViewAlpha)
                }

                
            }
        }
    }
        
        
    private func get3DTransformation(angle: Double) -> CATransform3D {

        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 500.0
        transform = CATransform3DRotate(transform, CGFloat(angle * Double.pi / 180.0), 0, 1, 0.0)

        return transform
    }

    private func flipAnimation(view: UIView, completion: @escaping (() -> Void) = {}) {

        let angle = 180.0
        view.layer.transform = get3DTransformation(angle: angle)

//            .TransitionNone
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .transitionCrossDissolve, animations: { () -> Void in
            view.layer.transform = CATransform3DIdentity
            }) { (finished) -> Void in
                completion()
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
