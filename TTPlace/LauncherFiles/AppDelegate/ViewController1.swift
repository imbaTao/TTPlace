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

class ViewController: TTViewController {
    
}



//MARK: - 封装的UIControl
public class Controll: UIControl {
    
    convenience init(width: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        snp.makeConstraints { (make) in
            make.width.equalTo(width)
        }
    }
    
    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        bindViewModel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        self.layer.masksToBounds = true
        updateUI()
    }
    
    func bindViewModel() {
        
    }
    func updateUI() {
        setNeedsDisplay()
    }
    
    func getCenter() -> CGPoint {
        return convert(center, from: superview)
    }
}


class TTAnimateView: Controll {
    enum TTAnimateViewState {
        case rise // 底部升起
        case down // 底部降下
        case centerShow // 中心显示
        case centerDismiss // 中心消失
    }
    
    enum TTAnimateViewType {
        case bottomRise // 底部升起
        case center // 中间弹框
    }
    
   private var animateState = TTAnimateViewState.rise
    {
        didSet {
            switch animateState {
            case .rise:
                contentView.force = 1
                contentView.duration = 1 // 动画播放时间
                contentView.damping = 1 // 阻尼控制弹性等
                contentView.velocity = 1
//                contentView.spY = SCREEN_H // 动画起始x偏移量
//                contentView.spX = -SCREEN_W + 300
                contentView.animation = Spring.AnimationPreset.SlideUp.rawValue // 动画效果
                contentView.curve = Spring.AnimationCurve.EaseIn.rawValue
                contentView.animateNext {[weak self]  in guard let self = self else { return }
//                    self.contentView.layer.frame = self.contentView.frame
                }
            case .down:
                

//                contentView.spY = 0
                 
                print("spY 是\(contentView.spY)")
                print("Y 是\(contentView.y)")
                contentView.animation = Spring.AnimationPreset.SlideDown.rawValue // 动画效果
                
//                self.stackView.snp.remakeConstraints { (make) in
//                    make.left.right.equalToSuperview()
//                    make.bottom.equalTo(self.contentView.height)
//                }
                
                // 第二步展示完后移除视图
//                contentView.animation = Spring.AnimationPreset.FadeOut.rawValue
                contentView.curve = Spring.AnimationCurve.EaseIn.rawValue
                contentView.animateTo()
            
                
//                UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseIn) {
//                    self.stackView.snp.remakeConstraints { (make) in
//                        make.left.right.equalToSuperview()
//                        make.bottom.equalTo(self.contentView.height)
//                    }
//                    self.layoutIfNeeded()
//                } completion: { (_) in
//                    self.removeFromSuperview()
//                }
                
                // 重新布局stackView
//                self.stackView.snp_remakeConstraints { (make) in
//                    make.left.right.equalToSuperview()
//                    make.top.equalTo(self.snp.bottom)
//                    make.size.equalTo(snapShoot.size)
//                }
//
//                // 截屏
//                if let snapShoot = stackView.snapshotView(afterScreenUpdates: false) {
//                    addSubview(snapShoot)
//
//                    // 位置设置跟snapShoot相同
//                    snapShoot.frame = self.stackView.frame
//
//                    // 重新布局stackView
//                    self.stackView.snp_remakeConstraints { (make) in
//                        make.left.right.equalToSuperview()
//                        make.top.equalTo(self.snp.bottom)
//                        make.size.equalTo(snapShoot.size)
//                    }
//
//                    // 立即布局
//                    layoutIfNeeded()
//
//
//
//                }
               
            // 动画执行完后
//                contentView.animateToNext {[weak self]  in guard let self = self else { return }
//                    self.removeFromSuperview()
//
//                    print("打印了")
//                }
                

                
//                UIView.animate(withDuration: ) {
//
//                } completion: { (reslt) in
//
//                }

               
//                contentView.animateNext {
////                    self.contentView.y = SCREEN_H
//                    self.contentView.snp.updateConstraints { (make) in
//                        make.bottom.equalToSuperview().offset(400)
//                    }
//                }
//                contentView.animate()
                

            default:
                break
            }
        }
    }
    
    // 动画的承载面板
    let contentView = SpringView()
    
    let stackView = StackView()
    override func makeUI() {
        super.makeUI()
        backgroundColor = rgba(0, 0, 0, 0.2)
        contentView.backgroundColor = .white
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        self.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self]  in guard let self = self else { return }
            self.restoreAnimate()
        }).disposed(by: rx.disposeBag)
    }
    
    // 根据容器，添加动画视图
    func showAnimate(containerView: UIView? = UIApplication.shared.keyWindow,type: TTAnimateViewType)  {
        if containerView != nil {
            containerView!.addSubview(self)
            self.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
          
            addSubview(stackView)
            stackView.addArrangedSubview(contentView)
            contentView.snp.makeConstraints { (make) in
//                make.left.top.equalToSuperview()
                make.edges.equalToSuperview()
            }
            
            
            
            switch type {
            case .bottomRise:
                stackView.snp.makeConstraints { (make) in
                    make.left.right.bottom.equalToSuperview()
                    make.height.greaterThanOrEqualTo(300)
                }
                animateState = .rise
            case .center:
                stackView.snp.makeConstraints { (make) in
                    make.center.equalToSuperview()
                }
                animateState = .centerShow
            default:
                break
            }
            
        }else {
            assert(false, "父视图为ni，请检查父视图")
        }
    }
    
    
    // 还原动画
    func restoreAnimate() {
        switch animateState {
        case .rise:
            animateState = .down
        case .centerShow:
            animateState = .centerDismiss
        default:
            break
        }
    }
    
    // 内容视图添加子视图
    func addAnimteSubViews(_ views: [UIView]) {
        contentView.addSubviews(views)
    }
}



class ViewController1: BaseViewController,UINavigationControllerDelegate {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.backgroundColor = .gray

//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            let testView =   AlertAnimateView()
//
//              testView.showAnimate(containerView: self.view, type: .bottomRise)
//        }
    }
    
    
    // 从左至右动画,只改变X轴
    func changeXAnimate(fromX: CGFloat,toX: CGFloat,animateView: UIView,duration: CGFloat = 0.7) {
        if  let posionXAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPositionX) {
            // 锚点默认在0.5,0.5所以要加上一个一半的宽度
            let posionStarX = ceil(animateView.width / 2.0)
            posionXAnimation.fromValue = fromX + posionStarX
            posionXAnimation.toValue =  toX + posionStarX
            posionXAnimation.duration = CFTimeInterval(duration)
            posionXAnimation.repeatForever = false
            animateView.layer.pop_add(posionXAnimation, forKey: kPOPLayerPositionX)
            
            
            // 透明度动画
            let alphaAnimate =  POPBasicAnimation.init(propertyNamed: kPOPViewAlpha)
            if toX > 0 {
                alphaAnimate?.fromValue = 0
                alphaAnimate?.toValue = 1
                alphaAnimate?.duration = CFTimeInterval(duration)
                alphaAnimate?.timingFunction = CAMediaTimingFunction.init(name: .easeIn)
            }else {
                alphaAnimate?.fromValue = 1
                alphaAnimate?.toValue = 0
                alphaAnimate?.duration = CFTimeInterval(duration)
                alphaAnimate?.timingFunction = CAMediaTimingFunction.init(name: .easeOut)
            }
       
            animateView.pop_add(alphaAnimate, forKey: kPOPViewAlpha)
        }else {
            print("动画执行失败了！！😤😤😤😤😤")
        }
    }
    
    
    // 从左至右动画,只改变Y轴
    func changeYAnimate(fromY: CGFloat,toY: CGFloat,animateView: UIView,duration: CGFloat = 0.5,easyInOut: Bool = true,spring: Bool = true) {
        if  let positonYAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPositionY) {
            // 锚点默认在0.5,0.5所以要加上一个一半的宽度
            let posionStarY = ceil(animateView.height / 2.0)
            positonYAnimation.fromValue = fromY + posionStarY
            positonYAnimation.toValue = toY + posionStarY
            positonYAnimation.duration = CFTimeInterval(duration)
            positonYAnimation.repeatForever = false
            animateView.layer.pop_add(positonYAnimation, forKey: kPOPLayerPositionX)
            
            
            
            if easyInOut {
                // 透明度动画
                let fromAlpha = 0.6
                let toAlpha = 1.0
                let alphaAnimate =  POPBasicAnimation.init(propertyNamed: kPOPViewAlpha)
                if toY > 0 {
                    alphaAnimate?.fromValue = fromAlpha
                    alphaAnimate?.toValue = toAlpha
                    alphaAnimate?.duration = CFTimeInterval(duration)
                    alphaAnimate?.timingFunction = CAMediaTimingFunction.init(name: .easeIn)
                }else {
                    alphaAnimate?.fromValue = toAlpha
                    alphaAnimate?.toValue = fromAlpha
                    alphaAnimate?.duration = CFTimeInterval(duration)
                    alphaAnimate?.timingFunction = CAMediaTimingFunction.init(name: .easeOut)
                }
                animateView.pop_add(alphaAnimate, forKey: kPOPViewAlpha)
            }
            
            if spring {
                
                let springAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleY)
                springAnimation?.velocity = 10
                springAnimation?.toValue = 1
                springAnimation?.springBounciness = 18
                animateView.layer.pop_add(springAnimation, forKey: kPOPLayerScaleY)
            }
          
        }else {
            print("动画执行失败了！！😤😤😤😤😤")
        }
    }
    
    
    
    
    
    
    func animateButton() {
        baseTabbar()?.isHidden = true
        self.view.removeSubviews()
        
        let myButton: UIButton = UIButton.title(title: "", titleColor: .black, font: .regular(24))
        addSubview(myButton)
        myButton.backgroundColor = .red
        myButton.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(300)
            make.bottom.equalTo(300)
            make.centerX.equalToSuperview()
        }

        myButton.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
            print("点击响应了")
        }).disposed(by: rx.disposeBag)
        
        
        self.view.layoutIfNeeded()
        
//        // 从左往右位移
//        self.changeXAnimate(fromX: -200, toX: 10, animateView: myButton)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.changeXAnimate(fromX: myButton.x, toX: -myButton.width, animateView: myButton)
//        }
        
        // 上下位移
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.changeYAnimate(fromY: SCREEN_H, toY: SCREEN_H - myButton.height, animateView: myButton)
        }
//
    
        
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.changeYAnimate(fromY: myButton.y, toY: SCREEN_H, animateView: myButton)
//        }
        
        
        // 动画的移动是以中心点为基准的，所以要移动X或者Y，要以中心点去计算
//        myButton.layer.anchorPoint = .init(x: 0, y: 0)
//        let positonX = POPBasicAnimation(propertyNamed: kPOPLayerPositionX)
//        positonX?.fromValue = -200
//        positonX?.toValue = myButton.addSubview(<#T##view: UIView##UIView#>)
//        positonX?.duration = 2
//        positonX?.repeatForever = false
//        myButton.layer.pop_add(positonX, forKey: kPOPLayerPositionX)
        
//        let positonY = POPBasicAnimation(propertyNamed: kPOPLayerPositionY)
//        positonY?.toValue = 300
//        positonY?.duration = 2
//        positonY?.repeatForever = true
//        myButton.layer.pop_add(positonY, forKey: kPOPLayerPositionY)
//
//
//
//
//        let spring = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleXY)
//        spring?.velocity = NSValue.init(cgSize: .init(width: 10, height: 10))
//        spring?.toValue = NSValue.init(cgSize: .init(width: 1, height: 1))
////        spring?.duration = 3
////        spring?.repeatCount = 5
//        spring?.springBounciness = 40
//        myButton.layer.pop_add(spring, forKey: "kPOPLayerScaleXY")
        
//        POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//
//        spring.velocity = [NSValue valueWithCGSize:CGSizeMake(10.f, 10.f)];
//
//        spring.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
//
//        spring.springBounciness = 18.f;
//
//        [self.button.layer pop_addAnimation:spring forKey:nil];
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let testView =   AlertAnimateView()
//
//          testView.showAnimate(containerView: self.view, type: .bottomRise)
    }
    
    
    
    @objc func injected() {
//        let testView =   AlertAnimateView()
//
//          testView.showAnimate(containerView: self.view, type: .bottomRise)
        
        animateButton()
    }
    
    
    
    
}

class AlertAnimateView: TTAnimateView {
//    var myText = UILabel.regular(size: 12, textColor: .black, text: "我是测试", backgroundColor: .white, cornerRadius: 0, alignment: .center, numberOfline: 1)
    var myText = UIButton.title(title: "我是按钮", titleColor: .black, font: .regular(24), iconName: "")
    override func makeUI() {
        super.makeUI()
        addAnimteSubViews([myText])
        
        myText.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.centerX.equalToSuperview()
        }
        myText.backgroundColor = .red
        myText.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in
            print("打印了！！！")
        }).disposed(by: rx.disposeBag)
        backgroundColor = .black
    }
}



