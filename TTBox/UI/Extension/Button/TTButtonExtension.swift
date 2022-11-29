//
//  TTCollectionViewExtension.swift
//  TTSwiftLearn
//
//  Created by Mr.hong on 2019/8/23.
//  Copyright © 2019 Mr.hong. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension UIButton {

    private class func customButton() -> Self {
        let button = Self.init(type: .custom)

        // 取消高亮,和不可选中时，系统的效果
        //        button.adjustsImageWhenHighlighted = false
        //        button.adjustsImageWhenDisabled = false

        return button
    }

    @available(*, deprecated, message: "平常不适用,尽量用R.Swift资源管理")
    class func iconName(_ iconName: String) -> UIButton {
        let button = UIButton.customButton()
        button.setImage(.name(iconName), for: .normal)
        button.setImage(.name(iconName), for: .selected)
        return button
    }

    class func iconImage(_ iconImage: UIImage?) -> UIButton {
        let button = UIButton.customButton()
        button.setImage(iconImage, for: .normal)
        button.setImage(iconImage, for: .selected)
        return button
    }

    @available(*, deprecated, message: "跟lable同步，新增regular初始化方法")
    class func title(title: String, titleColor: UIColor, font: UIFont) -> Self {
        let button = Self.customButton()

        // 设置一下默认状态，无高亮,需要高亮用其他初始化方法
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .selected)
        //            button.setTitle(title, for: .highlighted)
        button.titleLabel?.font = font

        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor, for: .selected)
        //        button.setTitleColor(titleColor, for: .highlighted)

        return button
    }

    @available(*, deprecated, message: "底部新增了方法")
    class func title(
        title: String, titleColor: UIColor, font: UIFont, borderColor: UIColor? = nil,
        backgroundColor: UIColor = .white, circle: Bool = false
    ) -> Self {
        let button = self.title(title: title, titleColor: titleColor, font: font)

        if let borderColor = borderColor {
            button.layer.borderWidth = 1
            button.layer.borderColor = borderColor.cgColor
        }

        button.backgroundColor = backgroundColor
        if circle {
            button.circle()
        }
        return button
    }

    @available(*, deprecated, message: "底部新增了方法")
    class func title(title: String, titleColor: UIColor, font: UIFont, iconName: String) -> UIButton
    {
        let button = UIButton.customButton()
     
        // 设置一下默认状态，无高亮,需要高亮用其他初始化方法
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .selected)
        //        button.setTitle(title, for: .highlighted)
        button.titleLabel?.font = font

        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor, for: .selected)
        //        button.setTitleColor(titleColor, for: .highlighted)

        button.setImage(.name(iconName), for: .normal)
        button.setImage(.name(iconName), for: .selected)
        //        button.setImage(.name(iconName), for: .highlighted)
        return button
    }

    @available(*, deprecated, message: "底部新增了方法")
    class func title(title: String, titleColor: UIColor, font: UIFont, iconImage: UIImage?)
        -> UIButton
    {
        let button = self.title(title: title, titleColor: titleColor, font: font, iconName: "")
        button.setImage(iconImage, for: .normal)
        button.setImage(iconImage, for: .selected)

        //        let button = UIButton.customButton()
        //        // 设置一下默认状态，无高亮,需要高亮用其他初始化方法
        //        button.setTitle(title, for: .normal)
        //        button.setTitle(title, for: .selected)
        ////        button.setTitle(title, for: .highlighted)
        //        button.titleLabel?.font = font;
        //
        //        button.setTitleColor(titleColor, for: .normal)
        //        button.setTitleColor(titleColor, for: .selected)
        ////        button.setTitleColor(titleColor, for: .highlighted)
        //
        //        button.setImage(.name(iconName), for: .normal)
        //        button.setImage(.name(iconName), for: .selected)
        //        button.setImage(.name(iconName), for: .highlighted)
        return button
    }
    @available(*, deprecated, message: "底部新增了方法")
    class func title(title: String, titleColor: UIColor, font: UIFont, backGroundName: String)
        -> UIButton
    {
        let button = UIButton.customButton()

        // 设置一下默认状态，无高亮,需要高亮用其他初始化方法
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .selected)
        //        button.setTitle(title, for: .highlighted)

        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor, for: .selected)
        //        button.setTitleColor(titleColor, for: .highlighted)

        button.titleLabel?.font = font

        button.setBackgroundImage(.name(backGroundName), for: .normal)
        //             button.setBackgroundImage(.name(backGroundName), for: .selected)
        //             button.setBackgroundImage(.name(backGroundName), for: .highlighted)

        return button
    }

    @available(*, deprecated, message: "底部新增了方法")
    class func button(
        title: String = "", titleColor: UIColor = .black, font: UIFont = .regular(16),
        iconName: String = "", backGroundName: String = "", backGroundColor: UIColor? = nil,
        cornerRadius: CGFloat = 0
    ) -> UIButton {
        let button = UIButton.customButton()

        // 设置一下默认状态，无高亮,需要高亮用其他初始化方法
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .selected)
        //        button.setTitle(title, for: .highlighted)
        button.titleLabel?.font = font

        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor, for: .selected)
        //        button.setTitleColor(titleColor, for: .highlighted)

        button.setImage(.name(iconName), for: .normal)
        button.setImage(.name(iconName), for: .selected)
        //        button.setImage(.name(iconName), for: .highlighted)

        if cornerRadius > 0 {
            button.cornerRadius = cornerRadius
        }

        if backGroundColor != nil {
            button.backgroundColor = backGroundColor
        }

        // 取消高亮,和不可选中时，系统的效果

        //        button.rx.controlEvent(.allTouchEvents).subscribe(onNext: {[weak button] (_) in
        //            button?.
        //        }).disposed(by: button.rx.disposeBag)
        //
        return button
    }

    //MARK: - 生成渐变色按钮
    class func gradientButton(
        title: String, titleColor: UIColor, font: UIFont, positon: TTGradientImagePositon,
        colors: [UIColor], size: CGSize, radius: CGFloat, highLightEnable: Bool
    ) -> UIButton {
        let button = UIButton.title(
            title: title, titleColor: titleColor, font: font, backGroundName: "")
        button.setBackgroundImage(
            UIImage.gradientImage(position: positon, colors: colors, size: size, radius: radius),
            for: .normal)

        // 禁止高亮的话,就再赋值一张图片
        if highLightEnable == false {
            button.setBackgroundImage(
                UIImage.gradientImage(
                    position: positon, colors: colors, size: size, radius: radius),
                for: .highlighted)
        }
        return button
    }
}

extension UIButton {

    // 让列表里所有按钮反选
    public class func invertSelection(items: [UIControl]) {
        let selectedItem = Observable.from(
            items.map { item in item.rx.controlEvent(.touchUpInside).map { item } }
        ).merge()
        for item in items {
            selectedItem.map { $0 == item }.bind(to: item.rx.isSelected).disposed(
                by: item.rx.disposeBag)
        }
    }
}

//extension UIButton {
////    func layoutButton(style: TTButtonType, imageTitleSpace: CGFloat) {
////        // 变更图片在顶部的布局
////        rx.methodInvoked(#selector(self.layoutSubviews)).throttle(.milliseconds(300),latest: false, scheduler: MainScheduler.instance).observeOn(MainScheduler.asyncInstance).subscribe(onNext: { [weak self] _ in
////            guard let self = self else { return }
////
////            //得到imageView和titleLabel的宽高
////            let imageWidth = self.imageView?.frame.size.width
////            let imageHeight = self.imageView?.frame.size.height
////
////            var labelWidth: CGFloat! = 0.0
////            var labelHeight: CGFloat! = 0.0
////
////            labelWidth = self.titleLabel?.frame.size.width
////            labelHeight = self.titleLabel?.frame.size.height
////
////            //初始化imageEdgeInsets和labelEdgeInsets
////            var imageEdgeInsets = UIEdgeInsets.zero
////            var labelEdgeInsets = UIEdgeInsets.zero
////
////            //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
////            switch style {
////            case .top:
////                //上 左 下 右
////                imageEdgeInsets = UIEdgeInsets(
////                    top: -labelHeight - imageTitleSpace / 2, left: 0, bottom: 0, right: -labelWidth)
////                labelEdgeInsets = UIEdgeInsets(
////                    top: 0, left: -imageWidth!, bottom: -imageHeight! - imageTitleSpace / 2,
////                    right: 0)
////                break
////
////            case .left:
////                imageEdgeInsets = UIEdgeInsets(
////                    top: 0, left: -imageTitleSpace / 2, bottom: 0, right: imageTitleSpace)
////                labelEdgeInsets = UIEdgeInsets(
////                    top: 0, left: imageTitleSpace / 2, bottom: 0, right: -imageTitleSpace / 2)
////                break
////
////            case .bottom:
////                imageEdgeInsets = UIEdgeInsets(
////                    top: 0, left: 0, bottom: -labelHeight! - imageTitleSpace / 2, right: -labelWidth
////                )
////                labelEdgeInsets = UIEdgeInsets(
////                    top: -imageHeight! - imageTitleSpace / 2, left: -imageWidth!, bottom: 0,
////                    right: 0)
////                break
////
////            case .right:
////                imageEdgeInsets = UIEdgeInsets(
////                    top: 0, left: labelWidth + imageTitleSpace / 2, bottom: 0,
////                    right: -labelWidth - imageTitleSpace / 2)
////                labelEdgeInsets = UIEdgeInsets(
////                    top: 0, left: -imageWidth! - imageTitleSpace / 2, bottom: 0,
////                    right: imageWidth! + imageTitleSpace / 2)
////                break
////
////            }
////
////            self.titleEdgeInsets = labelEdgeInsets
////            self.imageEdgeInsets = imageEdgeInsets
////        }).disposed(by: rx.disposeBag)
////    }
//}

extension UIButton {
    struct TTButtonExtensionPropertiesKey {
        static var expandEdges = "TTButton_expandEdges"
    }

    // 扩大
    public var expandEdges: UIEdgeInsets {
        get {
            return
                (objc_getAssociatedObject(self, &TTButtonExtensionPropertiesKey.expandEdges)
                as? UIEdgeInsets) ?? .zero
        }
        set {
            objc_setAssociatedObject(
                self, &TTButtonExtensionPropertiesKey.expandEdges, newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    //MARK: - 常用regelar字号
    class func regular(size: CGFloat = 16, textColor: UIColor = .black, text: String = "")
        -> UIButton
    {
        let button = UIButton.customButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.regular(size)
        button.setTitleColor(textColor, for: .normal)
        return button
    }

    class func regular(
        size: CGFloat = 16, textColor: UIColor = .black, text: String = "",
        cornerRadius: CGFloat = 0, backgroundColor: UIColor = .clear
    ) -> UIButton {
        let button = UIButton.regular(size: size, textColor: textColor, text: text)
        button.backgroundColor = backgroundColor
        if cornerRadius > 0 {
            button.cornerRadius = cornerRadius
        }
        return button
    }

    //MARK: - 常用mediu字号
    class func medium(size: CGFloat = 16, textColor: UIColor = .black, text: String = "")
        -> UIButton
    {
        let button = UIButton.customButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.medium(size)
        button.setTitleColor(textColor, for: .normal)
        return button
    }

    class func medium(
        size: CGFloat = 16, textColor: UIColor = .black, text: String = "",
        backgroundColor: UIColor = .clear
    ) -> UIButton {
        let button = UIButton.medium(size: size, textColor: textColor, text: text)
        button.backgroundColor = backgroundColor
        return button
    }

    //MARK: - 常用bold字号
    class func bold(size: CGFloat = 16, textColor: UIColor = .black, text: String = "") -> UIButton
    {
        let button = UIButton.customButton()
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.bold(size)
        button.setTitleColor(textColor, for: .normal)
        return button
    }
  
    class func bold(
        size: CGFloat = 16, textColor: UIColor = .black, text: String = "",
        backgroundColor: UIColor = .clear
    ) -> UIButton {
        let button = UIButton.medium(size: size, textColor: textColor, text: text)
        button.backgroundColor = backgroundColor
        return button
    }

    // MARK: - 单状态带图片的按钮
//    class func singleStatus(
//        font: UIFont = .regular(16), textColor: UIColor = .black, text: String = "",
//        image: UIImage? = nil,iconPosition: TTButtonType = .iconOnTheLeft) -> UIButton {
//        let button = UIButton.customButton()
//        button.config(font: font, textColor: textColor, text: text)
//        button.setImage(image, for: .normal)
//        button.setImage(image, for: .highlighted)
//        button.setImage(image, for: .selected)
//        button.titleLabel?.lineBreakMode = .byWordWrapping
//        button.titleLabel?.numberOfLines = 1
//
//
//        switch iconPosition {
//        case .top,.bottom:
//            button.titleLabel?.setContentCompressionResistancePriority(.required, for: .vertical)
//        case .left,.right:
//            button.titleLabel?.setContentCompressionResistancePriority(.required, for: .horizontal)
//        default:
//            break
//        }
//
//        return button
//    }

//    // MARK: - 多状态带图片按钮
//    class func multipleStatus(
//        font: UIFont = .regular(16), textColors: [UIColor], contents: [String], images: [UIImage?],
//        status: [UIButton.State], textImageInterval: CGFloat = 4,
//        iconPosition: TTButtonType = .iconOnTheLeft, backGroundColors: [UIColor] = [],
//        needCircle: Bool = false, fiexdSize: CGSize? = nil
//    ) -> UIButton {
//        let button = UIButton.customButton()
//        button.titleLabel?.font = font
//
//        if fiexdSize != nil {
//            button.frame = .init(x: 0, y: 0, width: fiexdSize!.width, height: fiexdSize!.height)
//        }
//
//        // 遍历状态数
//        for index in 0..<status.count {
//
//            // 拿到状态,根据状态赋值
//            let state = status[index]
//
//            // 颜色
//            if textColors.count > 0 {
//                var color: UIColor
//                if index < textColors.count {
//                    color = textColors[index]
//                } else {
//                    color = textColors.last!
//                }
//
//                button.setTitleColor(color, for: state)
//            }
//
//            // 内容
//            if contents.count > 0 {
//                var title: String
//                if index < contents.count {
//                    title = contents[index]
//                } else {
//                    title = contents.last!
//                }
//                button.setTitle(title, for: state)
//            }
//
//            // 图标
//            if images.count > 0 {
//                var image: UIImage?
//                if index < images.count {
//                    image = images[index]
//                } else {
//                    image = images.last!
//                }
//
//                button.setImage(image, for: state)
//            }
//
//            // 背景色
//            if backGroundColors.count > 0 {
//                var backgroundColor: UIColor
//                if index < backGroundColors.count {
//                    backgroundColor = backGroundColors[index]
//                } else {
//                    backgroundColor = backGroundColors.last!
//                }
//
//                let normalColor = backGroundColors.first!
//                switch state {
//                case .normal:
//                    button.backgroundColor = normalColor
//                case .selected:
//                    button.config(
//                        normalBackgroundColor: normalColor, selectedBackgroundColor: backgroundColor
//                    )
//                case .disabled:
//                    button.config(
//                        normalBackgroundColor: normalColor, disableBackgroundColor: backgroundColor)
//                default:
//                    break
//                }
//
//                //                button.cs.setBackgroundColor(backgroundColor, for: state)
//
//                //                // 有固定尺寸，处理倒圆角
//                //                if let fiexdSize = fiexdSize, needCircle == true{
//                //                    let multiply: CGFloat = 3
//                //                    let image = UIImage.init(color: backgroundColor, size: CGSize.init(width: fiexdSize.width * multiply, height: fiexdSize.height * multiply))
//                //                    if let image = image.withRoundedCorners(radius: fiexdSize.height * multiply / 2) {
//                //                        button.setBackgroundImage(image, for: state)
//                //                    }else {
//                //                        button.setBackgroundImage(UIImage.init(color: backgroundColor, size: .init(width: 5, height: 5)), for: state)
//                //                    }
//                //                }else {
//                //                    button.setBackgroundImage(UIImage.init(color: backgroundColor, size: .init(width: 5, height: 5)), for: state)
//                //                }
//
//            }
//
//            if needCircle {
//                button.circle(maskToBounds: false)
//            }
//        }
//
//        // 间隔
//        if textImageInterval > 0, images.count > 0, contents.count > 0 {
//            button.layoutButton(style: iconPosition, imageTitleSpace: textImageInterval)
//        }
//
//        return button
//    }

    // 重写扩展方法
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {

        // 如果设置了扩大点击域
        if expandEdges != .zero {
            let rect = self.bounds

            let x = rect.origin.x - expandEdges.left
            let y = rect.origin.y - expandEdges.top
            let width = rect.width + expandEdges.left + expandEdges.right
            let height = rect.height + expandEdges.top + expandEdges.bottom
            let bigRect = CGRect.init(x: x, y: y, width: width, height: height)

            // 是否在更大点击域里
            return bigRect.contains(point)
        } else {
            return super.point(inside: point, with: event)
        }
    }

}

// MARK: -  配置
extension UIButton {
    // 直接配置一个lable
    func config(
        font: UIFont = UIFont.regular(16), textColor: UIColor = .black, text: String = "",
        backgroundColor: UIColor = .clear
    ) {
        self.titleLabel?.font = font
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = backgroundColor
        if text.isNotEmpty {
            setTitle(text, for: .normal)
        }
    }

    func config(font: UIFont = UIFont.regular(16), textColor: UIColor = .black, text: String) {
        self.config(font: font, textColor: textColor, text: text, backgroundColor: .clear)
    }

    // 设置选中背景色
    func config(normalBackgroundColor: UIColor, selectedBackgroundColor: UIColor) {
        self.rx.observeWeakly(Bool.self, "selected").filterNil().subscribe(onNext: {
            [weak self] (isSelcted) in guard let self = self else { return }
            self.backgroundColor = isSelcted ? selectedBackgroundColor : normalBackgroundColor
        }).disposed(by: rx.disposeBag)
    }

    // 设置不可用颜色
    func config(normalBackgroundColor: UIColor, disableBackgroundColor: UIColor) {
        self.rx.observeWeakly(Bool.self, "enabled").filterNil().subscribe(onNext: {
            [weak self] (isEnabled) in guard let self = self else { return }
            // 是否选中,选中的话重新触发一下，重新设置选中颜色
            if self.isSelected, isEnabled {
                self.isSelected = true
            } else {
                self.backgroundColor = isEnabled ? normalBackgroundColor : disableBackgroundColor
            }
        }).disposed(by: rx.disposeBag)
    }

    // 设置选中border颜色
    func config(normalBorderColor: UIColor, selectedBorderColor: UIColor) {
        self.rx.observeWeakly(Bool.self, "selected").subscribe(onNext: { [weak self] (isSelcted) in
            guard let self = self else { return }
            self.addBorder(
                color: self.isSelected ? selectedBorderColor : normalBorderColor,
                width: .onePointHeight)
        }).disposed(by: rx.disposeBag)
    }

    // 设置不可用颜色
    func config(normalBorderColor: UIColor, disabledBorderColor: UIColor) {
        self.rx.observeWeakly(Bool.self, "enabled").subscribe(onNext: { [weak self] (isEnabled) in
            guard let self = self else { return }
            self.addBorder(
                color: self.isEnabled ? normalBorderColor : disabledBorderColor,
                width: .onePointHeight)
        }).disposed(by: rx.disposeBag)
    }
}



extension UIButton {
    func title(_ title: String) {
        setTitle(title, for: .normal)
    }
}


//// MARK：扩展按钮的点击区域
//import Foundation
//func associatedObject<ValueType: AnyObject>(
//    base: AnyObject,
//    key: UnsafePointer<UInt8>,
//    initialiser: () -> ValueType)
//    -> ValueType {
//        if let associated = objc_getAssociatedObject(base, key)
//            as? ValueType { return associated }
//        let associated = initialiser()
//        objc_setAssociatedObject(base, key, associated,
//                                 .OBJC_ASSOCIATION_RETAIN)
//        return associated
//}
//func associateObject<ValueType: AnyObject>(
//    base: AnyObject,
//    key: UnsafePointer<UInt8>,
//    value: ValueType) {
//    objc_setAssociatedObject(base, key, value,
//                             .OBJC_ASSOCIATION_RETAIN)
//}
//
//private var topKey: UInt8 = 20
//private var bottomKey: UInt8 = 20
//private var leftKey: UInt8 = 20
//private var rightKey: UInt8 = 20
//extension UIButton {
//    var top: NSNumber {
//        get {
//            return associatedObject(base: self, key: &topKey)
//            { return 0 }
//        }
//        set {
//            associateObject(base: self, key: &topKey, value: newValue)
//        }
//    }
//
//    var bottom: NSNumber {
//        get {
//            return associatedObject(base: self, key: &bottomKey)
//            { return 0 }
//        }
//        set {
//            associateObject(base: self, key: &bottomKey, value: newValue)
//        }
//    }
//
//    var left: NSNumber {
//        get {
//            return associatedObject(base: self, key: &leftKey)
//            { return 0 }
//        }
//        set {
//            associateObject(base: self, key: &leftKey, value: newValue)
//        }
//    }
//
//    var right: NSNumber {
//        get {
//            return associatedObject(base: self, key: &rightKey)
//            { return 0 }
//        }
//        set {
//            associateObject(base: self, key: &rightKey, value: newValue)
//        }
//    }
//
//    func setEnlargeEdge(top: Float, bottom: Float, left: Float, right: Float) -> Void {
//        self.top = NSNumber.init(value: top)
//        self.bottom = NSNumber.init(value: bottom)
//        self.left = NSNumber.init(value: left)
//        self.right = NSNumber.init(value: right)
//    }
//
//    func enlargedRect() -> CGRect {
//        let top = self.top
//        let bottom = self.bottom
//        let left = self.left
//        let right = self.right
//        if top.floatValue >= 0, bottom.floatValue >= 0, left.floatValue >= 0, right.floatValue >= 0 {
//            return CGRect.init(x: self.bounds.origin.x - CGFloat(left.floatValue),
//                               y: self.bounds.origin.y - CGFloat(top.floatValue),
//                               width: self.bounds.size.width + CGFloat(left.floatValue) + CGFloat(right.floatValue),
//                               height: self.bounds.size.height + CGFloat(top.floatValue) + CGFloat(bottom.floatValue))
//        }
//        else {
//            return self.bounds
//        }
//    }
//
//    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        let rect = self.enlargedRect()
//        if rect.equalTo(self.bounds) {
//            return super.point(inside: point, with: event)
//        }
//        return rect.contains(point) ? true : false
//    }
//}
//
