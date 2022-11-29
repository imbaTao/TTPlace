////
////  TTAnimate.swift
////  TTPlace
////
////  Created by Mr.hong on 2021/1/23.
////  Copyright © 2021 Mr.hong. All rights reserved.
////
//
//import Foundation
//

//extension UIView {
//
//    // MARK: - 透明度
//    func alphaAnimate(duration: CGFloat = 0.4,fromValue: CGFloat = 0.8,toValue: CGFloat = 1.0,complte: (() -> ())? = nil) {
//        if let alphaAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha) {
//            alphaAnimation.fromValue = fromValue
//            alphaAnimation.toValue = toValue
//            alphaAnimation.completionBlock = { [weak self]  (animation,finished) in guard let self = self else { return }
//                complte?()
//            }
//            pop_add(alphaAnimation, forKey: kPOPViewAlpha)
//        }
//    }
//
//
//    // 缩放
//    func scaleAnimate(duration: CGFloat = 0.5,easyInOut: Bool = true,spring: Bool = true,smallToBig: Bool = true,complte: (() -> ())? = nil) {
//        if self.height == 0 {
//            self.layoutIfNeeded()
//        }
//
//        if  let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPViewScaleXY) {
//            if easyInOut {
//                // 透明度动画
////                let fromAlpha = 0.8
////                let toAlpha = 1.0
////                let alphaAnimate =  POPBasicAnimation.init(propertyNamed: kPOPViewAlpha)
////                alphaAnimate?.fromValue = fromAlpha
////                alphaAnimate?.toValue = toAlpha
////                alphaAnimate?.duration = CFTimeInterval(duration)
////                alphaAnimate?.timingFunction = CAMediaTimingFunction.init(name: .easeIn)
////                pop_add(alphaAnimate, forKey: kPOPViewAlpha)
//            }
//
//
//            scaleAnimation.duration = CFTimeInterval(duration)
//            scaleAnimation.repeatForever = false
//
//            // 从小放大
//            if smallToBig {
//                scaleAnimation.fromValue = NSValue.init(cgPoint: .init(x: 0.8, y: 0.8))
//                scaleAnimation.toValue = NSValue.init(cgPoint: .init(x: 1, y: 1))
//            }else {
//                // 从大到小
//                scaleAnimation.fromValue = NSValue.init(cgPoint: .init(x: 1.1, y: 1.1))
//                scaleAnimation.toValue = NSValue.init(cgPoint: .init(x: 1, y: 1))
//            }
//
//
//            pop_add(scaleAnimation, forKey: kPOPViewScaleXY)
//
//            scaleAnimation.completionBlock = { [weak self]  (animation,finished) in guard let self = self else { return }
//                // 缩放动画完了后，执行弹性动画
//                if finished {
//                    complte?()
//
//                    if spring {
////                        if let springAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleXY) {
////                            springAnimation.velocity = NSValue.init(cgSize: .init(width: 1, height: 1))
////                            springAnimation.springBounciness = 18
////                            springAnimation.toValue = NSValue.init(cgSize: .init(width: 1.2, height: 1.2))
//////                            springAnimation.dynamicsTension = 700.0
//////                            springAnimation.dynamicsFriction = 7.0
//////                            springAnimation.dynamicsMass = 3.0
//////                            springAnimation.springSpeed = 0
////                            self.layer.pop_add(springAnimation, forKey: kPOPViewScaleXY)
////                            springAnimation.completionBlock = { (animation,finished) in
//////                                complte?()
////                            }
////                        }
//
//                    }
//                }
//            }
//        }else {
//            debugPrint("动画执行失败了！！😤😤😤😤😤")
//        }
//    }
//
//
//
//    // 从左至右动画,只改变X轴
//    func changeXAnimate(fromX: CGFloat,toX: CGFloat,duration: CGFloat = 0.7,complteBlock: @escaping (POPAnimation?,Bool) -> Void) {
//        if self.width == 0 {
//            self.layoutIfNeeded()
//        }
//
//        if  let posionXAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPositionX) {
//            // 锚点默认在0.5,0.5所以要加上一个一半的宽度
//            let posionStarX = ceil(self.width / 2.0)
//            posionXAnimation.fromValue = fromX + posionStarX
//            posionXAnimation.toValue =  toX + posionStarX
//            posionXAnimation.duration = CFTimeInterval(duration)
//            posionXAnimation.repeatForever = false
//            posionXAnimation.removedOnCompletion = true
//            layer.pop_add(posionXAnimation, forKey: "ChangeX")
//
//
//            // 透明度动画
//            let fromAlpha = 0.6
//            let toAlpha = 1.0
//            let alphaAnimate =  POPBasicAnimation.init(propertyNamed: kPOPViewAlpha)
//            alphaAnimate?.removedOnCompletion = true
//            if toX > 0 {
//                alphaAnimate?.fromValue = fromAlpha
//                alphaAnimate?.toValue = toAlpha
//                alphaAnimate?.duration = CFTimeInterval(duration)
//                alphaAnimate?.timingFunction = CAMediaTimingFunction.init(name: .easeIn)
//            }else {
//                alphaAnimate?.fromValue = toAlpha
//                alphaAnimate?.toValue = fromAlpha
//                alphaAnimate?.duration = CFTimeInterval(duration)
//                alphaAnimate?.timingFunction = CAMediaTimingFunction.init(name: .easeOut)
//            }
//
//            pop_add(alphaAnimate, forKey: "ChangeAlpha")
//            posionXAnimation.completionBlock = complteBlock
//        }else {
//            debugPrint("动画执行失败了！！😤😤😤😤😤")
//        }
//    }
//
//    // 从左至右动画,只改变Y轴
//    func changeYAnimate(fromY: CGFloat,toY: CGFloat,duration: CGFloat = 0.5,easyInOut: Bool = true,spring: Bool = true,complte: (() -> ())? = nil) {
//        if self.height == 0 {
//            self.layoutIfNeeded()
//        }
//
//        if  let positonYAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPositionY) {
//            if easyInOut {
////                // 透明度动画
////                var fromAlpha = 0.0
////                var toAlpha = 0.0
////                let alphaAnimate =  POPBasicAnimation.init(propertyNamed: kPOPViewAlpha)
////                if toY > 0 {
////                    fromAlpha = 0.8
////                    toAlpha = 1.0
////                    alphaAnimate?.fromValue = fromAlpha
////                    alphaAnimate?.toValue = toAlpha
////                    alphaAnimate?.duration = CFTimeInterval(duration)
////                    alphaAnimate?.timingFunction = CAMediaTimingFunction.init(name: .easeIn)
////                }else {
////                    fromAlpha = 1.0
////                    toAlpha = 0.8
////                    alphaAnimate?.fromValue = toAlpha
////                    alphaAnimate?.toValue = fromAlpha
////                    alphaAnimate?.duration = CFTimeInterval(duration)
////                    alphaAnimate?.timingFunction = CAMediaTimingFunction.init(name: .easeOut)
////                }
////                pop_add(alphaAnimate, forKey: kPOPViewAlpha)
//            }
//
//
//
//            // 锚点默认在0.5,0.5所以要加上一个一半的宽度
//            let posionStarY = ceil(self.height / 2.0)
//            positonYAnimation.fromValue = fromY + posionStarY
//            positonYAnimation.toValue = toY + posionStarY
//            positonYAnimation.duration = CFTimeInterval(duration)
//            positonYAnimation.repeatForever = false
//
////            458752
////            positonYAnimation.timingFunction =     CAMediaTimingFunction.init(name: .easeOut)
//            pop_add(positonYAnimation, forKey: kPOPLayerPositionY)
//            positonYAnimation.completionBlock = { [weak self]  (animation,finished) in guard let self = self else { return }
//                if finished {
////                    if spring {
////                        let springAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleY)
////                        springAnimation?.velocity = 10
////                        springAnimation?.toValue = 1
////                        springAnimation?.springBounciness = 18
////                        self.layer.pop_add(springAnimation, forKey: kPOPLayerScaleY)
////                    }
//
//                    complte?()
//                }
//            }
//        }else {
//            debugPrint("动画执行失败了！！😤😤😤😤😤")
//        }
//    }
//
//
//    // MARK: - 摇摆动画
//    func shakeAnimate(view: UIView,duration: CGFloat = 0.5,complte: (() -> ())? = nil) {
//
//        let duration: CFTimeInterval = 0.2
//
//        if  let positonYAnimation = POPBasicAnimation(propertyNamed: kPOPLayerRotation) {
//            positonYAnimation.toValue = Double.pi / 4
//            positonYAnimation.duration = duration
//            positonYAnimation.repeatForever = false
//            positonYAnimation.removedOnCompletion = false
//
////            458752
//            positonYAnimation.timingFunction =   CAMediaTimingFunction.init(name: .linear)
//            view.layer.pop_add(positonYAnimation, forKey: kPOPLayerRotation)
//
//
//            let springAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleY)
//             springAnimation?.velocity = 10
//             springAnimation?.toValue = 1
//             springAnimation?.springBounciness = 18
//             view.layer.pop_add(springAnimation, forKey: kPOPLayerScaleY)
//
//            // 向右完成
//            positonYAnimation.completionBlock = {(animation,finished) in
//                if finished {
//
//                    //  还原
//                    if  let positonYAnimation = POPBasicAnimation(propertyNamed: kPOPLayerRotation) {
//                        positonYAnimation.toValue = 0
//                        positonYAnimation.duration = duration
//                        positonYAnimation.repeatForever = false
//                        positonYAnimation.removedOnCompletion = false
//                        positonYAnimation.timingFunction =   CAMediaTimingFunction.init(name: .linear)
//                        view.layer.pop_add(positonYAnimation, forKey: kPOPLayerRotation)
//                        positonYAnimation.completionBlock = { (animation,finished) in
//                            if finished {
//                                complte?()
//                            }
//                        }
//                    }
//                }
//            }
//        }else {
//            debugPrint("动画执行失败了！！😤😤😤😤😤")
//        }
//    }
//
//}
//
//
//
//
////extension UIView {
////    // 同一个动画，duration 要求一致，这样才可以回撤
////
////
////    // 变更alpha通道动画
////    func changeAlphaAnimate(fromValue: CGFloat,toValue: CGFloat,duration: TimeInterval = 1,complete: (() -> ())? = nil) {
////        // 将来值设置为可选，因为之前可能有旧动画
////        var fromValue = fromValue
////        var duration = duration
//////        var timeOffSet: CFTimeInterval = 0
////        let key = "TTAnimation.alpha"
////
////        // 执行闭包
////        let beginBlock = { [weak self]  in guard let self = self else { return }
////            let animationOpacity = TTAnimation.init(keyPath: "opacity")
////            animationOpacity.fromValue = fromValue
////            animationOpacity.toValue = toValue
////            animationOpacity.duration = duration
////            animationOpacity.isRemovedOnCompletion = false
////            animationOpacity.fillMode = .backwards
////            animationOpacity.timingFunction = .easeInOut
////
////            animationOpacity.completion = {[weak self]  in guard let self = self else { return }
////                self.alpha = toValue
////                complete?()
////            }
////
////            self.layer.add(animationOpacity, forKey: key)
////        }
////
////
////        // 如果找得到之前的动画，就记录alpha，且移除后再执行新动画
////        if let _ = layer.animation(forKey: key),let presentationLayer = layer.presentation() {
////            // 原本0.4秒内走完的速度
////            let speed = abs((fromValue - toValue) / CGFloat(duration))
////            let nowOpacity = presentationLayer.opacity
////            duration = TimeInterval(abs(toValue - CGFloat(nowOpacity)) / speed)
////            layer.removeAnimation(forKey: key)
////
////            // 赋值之前的位置
////            fromValue = CGFloat(nowOpacity)
////            beginBlock()
////        }else {
////            beginBlock()
////        }
////    }
////
////    // 变更Y轴偏移
////    func changePositionY(fromValue: CGFloat,toValue: CGFloat,duration: TimeInterval = 1,complete: (() -> ())? = nil) {
////        let fromPoint = CGPoint.init(x: self.centerX, y: self.centerY)
////        let toPoint = CGPoint.init(x: self.centerX, y: toValue + self.height * 0.5)
////        changePositonAnimate(fromValue: fromPoint, toValue: toPoint, duration: duration, complete: complete)
////    }
////
////    // 变更X轴偏移
////    func changePositionX(fromValue: CGFloat,toValue: CGFloat,duration: TimeInterval = 1,complete: (() -> ())? = nil) {
////        let fromPoint = CGPoint.init(x: self.centerX, y: self.centerY)
////        let toPoint = CGPoint.init(x: toValue + self.width * 0.5, y:  self.centerY)
////        changePositonAnimate(fromValue: fromPoint, toValue: toPoint, duration: duration, complete: complete)
////    }
////
////
////    // 变更位移动画
////    func changePositonAnimate(fromValue: CGPoint,toValue: CGPoint,duration: TimeInterval = 1,complete: (() -> ())? = nil) {
////        // 将来值设置为可选，因为之前可能有旧动画
////        var fromValue = fromValue
////        var duration = duration
////        let key = "TTAnimation.position"
////
////        // 执行闭包
////        let beginBlock = { [weak self]  in guard let self = self else { return }
////            let animationPositon = TTAnimation.init(keyPath: "position")
////            animationPositon.fromValue = fromValue
////            animationPositon.toValue = toValue
////            animationPositon.duration = duration
////            animationPositon.isRemovedOnCompletion = false
////            animationPositon.fillMode = .backwards
////            animationPositon.timingFunction = .easeInOut
////            animationPositon.completion = { [weak self]  in guard let self = self else { return }
////                self.center = toValue
////                complete?()
////            }
////
////            self.layer.add(animationPositon, forKey: key)
////        }
////
////
////
////        if fromValue.x == toValue.x {
////            // 如果找得到之前的动画，就记录位置，且移除后再执行新动画
////            if let _ = layer.animation(forKey: key),let presentationLayer = layer.presentation() {
////                // 原本0.4秒内走完的速度
////                let speed = abs((fromValue.y - toValue.y) / CGFloat(duration))
////                let nowCenter = presentationLayer.position
////                duration = TimeInterval(abs(toValue.y - nowCenter.y) / speed)
////                layer.removeAnimation(forKey: key)
////                // 赋值之前的位置
////                fromValue = nowCenter
////                beginBlock()
////            }else {
////                beginBlock()
////            }
////        }else {
////            // 如果找得到之前的动画，就记录位置，且移除后再执行新动画
////            if let _ = layer.animation(forKey: key),let presentationLayer = layer.presentation() {
////                // 原本0.4秒内走完的速度
////                let speed = abs((fromValue.x - toValue.x) / CGFloat(duration))
////                let nowCenter = presentationLayer.position
////                duration = TimeInterval(abs(toValue.x - nowCenter.x) / speed)
////                layer.removeAnimation(forKey: key)
////                // 赋值之前的位置
////                fromValue = nowCenter
////                beginBlock()
////            }else {
////                beginBlock()
////            }
////        }
////
////
////
////    }
////
////
////
////
////
////
////
////
//////    // 变更弹性Y轴
//////    func changeSpringY() {
//////        let spring = TTSpringAnimation(keyPath: "position.y")
//////        spring.damping = 10; //阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
//////        spring.stiffness = 500; //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
//////        spring.mass = 0.5; //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
//////        spring.initialVelocity = 0; // 初速度
//////        spring.fromValue = layer.position.y;
//////        spring.toValue = layer.position.y - 10;
//////        //           spring.duration = spring.settlingDuration;
//////        spring.duration = 1
//////        spring.isRemovedOnCompletion =  false
//////        spring.fillMode = .backwards
//////        self.layer.add(spring, forKey: "springKey")
//////        spring.completion = {
//////
//////        }
//////    }
////
////    //    func changeGroup(fromValue: CGPoint,toValue: CGPoint,duration: TimeInterval = 1) {
////    //          // 将来值设置为可选，因为之前可能有旧动画
////    //          var fromValue = fromValue
////    //          var duration = duration
////    //          let key = "TTAnimation.position"
////    //
////    //          // 执行闭包
////    //          let beginBlock = { [weak self]  in guard let self = self else { return }
////    ////              let animationPositon = TTAnimation.init(keyPath: "position")
////    ////              animationPositon.fromValue = fromValue
////    ////              animationPositon.toValue = toValue
////    ////              animationPositon.duration = duration
////    ////              animationPositon.isRemovedOnCompletion = false
////    ////              animationPositon.fillMode = .backwards
////    ////              animationPositon.timingFunction = .easeInOut
////    ////              animationPositon.completion = {
////    ////                  self.center = toValue
////    ////              }
////    //
////    //
////    //            let spring = TTSpringAnimation(keyPath: "position.y")
////    //               spring.damping = 18; //阻尼系数，阻止弹簧伸缩的系数，阻尼系数越大，停止越快
////    //               spring.stiffness = 600; //刚度系数(劲度系数/弹性系数)，刚度系数越大，形变产生的力就越大，运动越快
////    //                spring.mass = 0.3; //质量，影响图层运动时的弹簧惯性，质量越大，弹簧拉伸和压缩的幅度越大
////    //               spring.initialVelocity = 0; // 初速度
////    //               spring.fromValue = fromValue.y;
////    //               spring.toValue =  toValue.y;
////    //    //           spring.duration = spring.settlingDuration;
////    //                spring.duration = duration
////    //                spring.isRemovedOnCompletion =  false
////    //                spring.fillMode = .backwards
////    ////                self.layer.add(spring, forKey: "springKey")
////    //                spring.completion = {
////    //    //                self.centerY = self.layer.position.y - 50
////    //                }
////    //
////    //            self.layer.add(spring, forKey: "GroupA")
////    //
////    //
////    ////              let animation_Group = CAAnimationGroup()
////    ////
////    ////              animation_Group.animations = [animationPositon,spring]
////    ////              self.layer.add(animationPositon, forKey: "GroupA")
////    //          }
////
////
////
////    //
////    //
////    //          // 如果找得到之前的动画，就记录位置，且移除后再执行新动画
////    //          if let _ = layer.animation(forKey: key),let presentationLayer = layer.presentation() {
////    //              // 原本0.4秒内走完的速度
////    //              let speed = abs((fromValue.y - toValue.y) / CGFloat(duration))
////    //              let nowCenter = presentationLayer.position
////    //              duration = TimeInterval(abs(toValue.y - nowCenter.y) / speed)
////    //              layer.removeAnimation(forKey: key)
////    //
////    //              // 赋值之前的位置
////    //              fromValue = presentationLayer.center
////    //
////    //              beginBlock()
////    //          }else {
////    //              beginBlock()
////    //          }
////    //    }
////
////
////}
////
////
////
////class TTAnimation: CABasicAnimation,CAAnimationDelegate {
////    typealias TTAnimationCompletion = () -> Void
////    var completion: TTAnimationCompletion!
////    override init() {
////        super.init()
////
////        delegate = self
////    }
////
////
////    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
////        // 彻底停止标记
////        if flag  {
////            completion()
////        }else {
////
////        }
////    }
////
////    required init?(coder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
////}
////
////
////class TTSpringAnimation: CASpringAnimation,CAAnimationDelegate {
////    typealias TTAnimationCompletion = () -> Void
////    var completion: TTAnimationCompletion!
////    override init() {
////        super.init()
////
////        delegate = self
////    }
////
////
////    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
////        // 彻底停止标记
////        if flag  {
////            completion()
////        }else {
////
////        }
////    }
////
////    required init?(coder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
////}
////
////
////
////extension UIView {
////    var centerX: CGFloat {
////        return self.center.x
////    }
////
////    var centerY: CGFloat {
////        return self.center.y
////    }
////}
