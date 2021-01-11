//
//  TTCollectionViewExtension.swift
//  TTSwiftLearn
//
//  Created by Mr.hong on 2019/8/23.
//  Copyright © 2019 Mr.hong. All rights reserved.
//

import UIKit
import Foundation

extension UIButton {
    
    private class func customButton() -> Self {
        let button = Self.init(type: .custom)
        
        // 取消高亮,和不可选中时，系统的效果
        button.adjustsImageWhenHighlighted = false
        button.adjustsImageWhenDisabled = false
        
        return button
    }
    
    class func iconName(_ iconName: String) -> UIButton{
       let button = UIButton.customButton()
        button.setImage(.name(iconName), for: .normal)
        button.setImage(.name(iconName), for: .selected)
        return button;
    }
    
    class func iconImage(_ iconImage: UIImage?) -> UIButton{
       let button = UIButton.customButton()
        button.setImage(iconImage, for: .normal)
        button.setImage(iconImage, for: .selected)
        return button;
    }
    
    
    class func title(title: String,titleColor: UIColor,font: UIFont) -> Self{
        let button = Self.customButton()
            
            // 设置一下默认状态，无高亮,需要高亮用其他初始化方法
            button.setTitle(title, for: .normal)
            button.setTitle(title, for: .selected)
//            button.setTitle(title, for: .highlighted)
            button.titleLabel?.font = font;
            
            button.setTitleColor(titleColor, for: .normal)
            button.setTitleColor(titleColor, for: .selected)
    //        button.setTitleColor(titleColor, for: .highlighted)
        
            return button;
        }
    
    
    
    class func title(title: String,titleColor: UIColor,font: UIFont,iconName: String) -> UIButton{
        let button = UIButton.customButton()
        
        // 设置一下默认状态，无高亮,需要高亮用其他初始化方法
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .selected)
//        button.setTitle(title, for: .highlighted)
        button.titleLabel?.font = font;
        
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor, for: .selected)
//        button.setTitleColor(titleColor, for: .highlighted)
        
        button.setImage(.name(iconName), for: .normal)
        button.setImage(.name(iconName), for: .selected)
//        button.setImage(.name(iconName), for: .highlighted)
        return button;
    }
    
    class func title(title: String,titleColor: UIColor,font: UIFont,backGroundName: String) -> UIButton{
        let button = UIButton.customButton()
        
        // 设置一下默认状态，无高亮,需要高亮用其他初始化方法
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .selected)
//        button.setTitle(title, for: .highlighted)
        
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor, for: .selected)
//        button.setTitleColor(titleColor, for: .highlighted)
        
        
        button.titleLabel?.font = font;
        
        button.setBackgroundImage(.name(backGroundName), for: .normal)
        //             button.setBackgroundImage(.name(backGroundName), for: .selected)
        //             button.setBackgroundImage(.name(backGroundName), for: .highlighted)
        
        return button;
    }
    
    
    class func button(title: String = "",titleColor: UIColor = .black,font: UIFont = .regular(16),iconName: String = "",backGroundName: String = "",backGroundColor: UIColor? = nil,cornerRadius: CGFloat = 0) -> UIButton{
        let button = UIButton.customButton()
        
        // 设置一下默认状态，无高亮,需要高亮用其他初始化方法
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .selected)
//        button.setTitle(title, for: .highlighted)
        button.titleLabel?.font = font;
        
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
        return button;
    }
    
    
    //MARK: - 生成渐变色按钮
    class func gradientButton(title: String,titleColor: UIColor,font: UIFont,positon: TTGradientImagePositon, colors: [UIColor],size: CGSize,radius: CGFloat, highLightEnable: Bool)  -> UIButton {
        let button = UIButton.title(title: title, titleColor: titleColor, font: font, backGroundName: "")
        button.setBackgroundImage(UIImage.gradientImage(position:positon, colors: colors, size: size, radius: radius, opacity: 1), for: .normal)
        
        // 禁止高亮的话,就再赋值一张图片
        if  highLightEnable == false {
            button.setBackgroundImage(UIImage.gradientImage(position:positon, colors: colors, size: size, radius: radius, opacity: 1), for: .highlighted)
        }
        return button
    }
}

