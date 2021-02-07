//
//  TTTextConfigure.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/7.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

// 根据配置对象去设置TextView
class TTTextViewConfigure: NSObject {

    // 默认文本颜色
    var textColor = UIColor.black
    
    // 默认字体
    var textFont = UIFont.regular(16)
    
    // 光标颜色
    var caretColor = UIColor.black
    
    // placeholderText
    var placeholderText = ""
    
    // placeholder颜色
    var placeholderColor = UIColor.gray
    
    // placeholder字体
    var placeholderFont: UIFont?
    
    // placeholder距离起始位置左侧偏移量
    var placeholderLeftOffset: CGFloat = 1

    // 文本排列方式,默认left
    var textAlignment = NSTextAlignment.left
    
    // 内边距
    var contentEdges = UIEdgeInsets.zero
    
    // 一个中文字符占几位
    var chiniseCharCount: Int = 2
    
    // 默认不限制最大输入字数
    var maxTextCount = 0
    
    // 默认过滤非法字符
    var filter = true
}
