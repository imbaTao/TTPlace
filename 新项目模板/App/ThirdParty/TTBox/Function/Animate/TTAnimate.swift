//
//  TTAnimate.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/1/23.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation


extension UIView {
    
    /// MARK: - 透明度
    func alphaAnimate(duration: CGFloat = 0.4,fromValue: CGFloat = 0.8,toValue: CGFloat = 1.0,complte: (() -> ())? = nil) {
        if let alphaAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha) {
            alphaAnimation.fromValue = fromValue
            alphaAnimation.toValue = toValue
            pop_add(alphaAnimation, forKey: kPOPViewAlpha)
        }
    }
    
  
    // 缩放
    func scaleAnimate(duration: CGFloat = 0.5,easyInOut: Bool = true,spring: Bool = true,smallToBig: Bool = true,complte: (() -> ())? = nil) {
        if self.height == 0 {
            self.layoutIfNeeded()
        }
        
        if  let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY) {
            if easyInOut {
                // 透明度动画
//                let fromAlpha = 0.8
//                let toAlpha = 1.0
//                let alphaAnimate =  POPBasicAnimation.init(propertyNamed: kPOPViewAlpha)
//                alphaAnimate?.fromValue = fromAlpha
//                alphaAnimate?.toValue = toAlpha
//                alphaAnimate?.duration = CFTimeInterval(duration)
//                alphaAnimate?.timingFunction = CAMediaTimingFunction.init(name: .easeIn)
//                pop_add(alphaAnimate, forKey: kPOPViewAlpha)
            }
            
            
            scaleAnimation.duration = CFTimeInterval(duration)
            scaleAnimation.repeatForever = false
            
            // 从小放大
            if smallToBig {
                scaleAnimation.fromValue = NSValue.init(cgPoint: .init(x: 0.8, y: 0.8))
                scaleAnimation.toValue = NSValue.init(cgPoint: .init(x: 1, y: 1))
            }else {
                // 从大到小
                scaleAnimation.fromValue = NSValue.init(cgPoint: .init(x: 1.1, y: 1.1))
                scaleAnimation.toValue = NSValue.init(cgPoint: .init(x: 1, y: 1))
            }
            
  
            pop_add(scaleAnimation, forKey: kPOPViewScaleXY)
            
            scaleAnimation.completionBlock = { [weak self]  (animation,finished) in guard let self = self else { return }
                // 缩放动画完了后，执行弹性动画
                if finished {
                    complte?()
                    
                    if spring {
//                        if let springAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleXY) {
//                            springAnimation.velocity = NSValue.init(cgSize: .init(width: 1, height: 1))
//                            springAnimation.springBounciness = 18
//                            springAnimation.toValue = NSValue.init(cgSize: .init(width: 1.2, height: 1.2))
////                            springAnimation.dynamicsTension = 700.0
////                            springAnimation.dynamicsFriction = 7.0
////                            springAnimation.dynamicsMass = 3.0
////                            springAnimation.springSpeed = 0
//                            self.layer.pop_add(springAnimation, forKey: kPOPViewScaleXY)
//                            springAnimation.completionBlock = { (animation,finished) in
////                                complte?()
//                            }
//                        }
                
                    }
                }
            }
        }else {
            print("动画执行失败了！！😤😤😤😤😤")
        }
    }
    
    

    // 从左至右动画,只改变X轴
    func changeXAnimate(fromX: CGFloat,toX: CGFloat,duration: CGFloat = 0.7,complteBlock: @escaping (POPAnimation?,Bool) -> Void) {
        if self.width == 0 {
            self.layoutIfNeeded()
        }
        
        if  let posionXAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPositionX) {
            // 锚点默认在0.5,0.5所以要加上一个一半的宽度
            let posionStarX = ceil(self.width / 2.0)
            posionXAnimation.fromValue = fromX + posionStarX
            posionXAnimation.toValue =  toX + posionStarX
            posionXAnimation.duration = CFTimeInterval(duration)
            posionXAnimation.repeatForever = false
            layer.pop_add(posionXAnimation, forKey: kPOPLayerPositionX)
            
            
            // 透明度动画
            let fromAlpha = 0.6
            let toAlpha = 1.0
            let alphaAnimate =  POPBasicAnimation.init(propertyNamed: kPOPViewAlpha)
            if toX > 0 {
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
       
            pop_add(alphaAnimate, forKey: kPOPViewAlpha)
            posionXAnimation.completionBlock = complteBlock
        }else {
            print("动画执行失败了！！😤😤😤😤😤")
        }
    }

    // 从左至右动画,只改变Y轴
    func changeYAnimate(fromY: CGFloat,toY: CGFloat,duration: CGFloat = 0.5,easyInOut: Bool = true,spring: Bool = true,complte: (() -> ())? = nil) {
        if self.height == 0 {
            self.layoutIfNeeded()
        }
        
        if  let positonYAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPositionY) {
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
            
       
            
            // 锚点默认在0.5,0.5所以要加上一个一半的宽度
            let posionStarY = ceil(self.height / 2.0)
            positonYAnimation.fromValue = fromY + posionStarY
            positonYAnimation.toValue = toY + posionStarY
            positonYAnimation.duration = CFTimeInterval(duration)
            positonYAnimation.repeatForever = false
            layer.pop_add(positonYAnimation, forKey: kPOPLayerPositionX)
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

