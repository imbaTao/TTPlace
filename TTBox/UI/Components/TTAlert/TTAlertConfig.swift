//
//  TTAlertConfig.swift
//  TTNew
//
//  Created by Mr.hong on 2022/3/9.
//

import Foundation

class TTAlertConfig: NSObject {
    // 点击隐藏
    var touchHidden = false

    // 竖屏内容尺寸的
    var portraitSize = ttSize(200, 200)
    // 横屏尺寸
    var landSize: CGSize?

    // 固定size    
    var absouluteWidth: CGFloat?
    var absouluteHeight: CGFloat?
    var absouluteSize: CGSize? {
        if let width = absouluteWidth, let height = absouluteHeight {
            return .init(width: width, height: height)
        }
        return nil
    }

    // 动画显示时间
    var showAnimateInterval: CGFloat = 0.4

    // 动画隐藏时间
    var dismissAnimateInterval: CGFloat = 0.3

    // 竖屏显示的风格
    var portraitAnimateStyle = TTAlertAnimateStyle.center
    
    // 横屏显示的风格
    var landscapeAnimateStyle: TTAlertAnimateStyle? = TTAlertAnimateStyle.center
    
    // 根据屏幕旋转选择动画风格
    var showAnimateStyle: TTAlertAnimateStyle {
        if TTDevice.shared.isLand {
            return landscapeAnimateStyle ?? portraitAnimateStyle
        }else {
            return portraitAnimateStyle
        }
    }
    
    // 倒内容圆角
    var cornerRadius: CGFloat = 8.0
    

    // 背板背景色
    var maskBackgroundColor = rgba(0, 0, 0, 0)

//    config.maskBackgroundColor = rgba(1, 2, 5, 0.4)
    
    // 是否需要模糊
    var needBlur = false

    // 是否忽略关闭按钮的信号
    var ignorcloseButtonSignal = false

    // 是否一开始就show
    var justShow = true

    // 额外内容高度
    var extraContentHeight: CGFloat = 0.0

    // 默认contentView背景色
    var defaultContentViewColor = UIColor.white

    // 默认支持缩放动画
    var enableScaleAnimate = true

    // 偏移量
    var offSet: CGFloat = 0.0
}
