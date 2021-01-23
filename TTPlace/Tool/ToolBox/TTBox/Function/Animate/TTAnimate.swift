//
//  TTAnimate.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/1/23.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation


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

