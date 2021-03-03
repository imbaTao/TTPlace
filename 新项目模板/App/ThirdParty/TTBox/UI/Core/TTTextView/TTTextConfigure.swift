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
    
    var filter1: TTTextFilter?
    
}


enum TTTextFilterType {
    case legal // 正常的合法字符,不含特殊符号
    case onlyNumber // 纯数字
    case name // 姓名，昵称
    case ID // 身份证
}


class TTTextFilter: NSObject {
    var expression = ""
    
    init(_ type: TTTextFilterType? = .legal) {
        switch type {
        case .legal:
            expression = "^[a-zA-Z0-9_\u{4e00}-\u{9fa5}]+$"
        case .onlyNumber:
            expression = "^[0-9]+$"
        case .name:
            expression = "^[a-zA-Z\u{4e00}-\u{9fa5}]+$"
        case .ID:
            expression = "^[a-zA-Z0-9]+$"
        default:
            break
        }
    }
    
    
    // 过滤,是否满足
    func filter(_ text: String) -> Bool {
        var reusult = true
        let pred = NSPredicate(format: "SELF MATCHES %@",expression)
        for char in text {
            reusult = pred.evaluate(with: "\(char)")
            if reusult == false {
                return reusult
            }
        }
        return reusult
    }
    
    
//    // 英文字符
//    let englishLettersPattern = "[a-zA-Z]"
//
//    // 数字字符
//    let numberPattern = "[0-9]"
//
//    // 中文谓词
//    let chinisePattern = "^[\u{4e00}-\u{9fa5}]+$"
//
//    // emoji谓词
//    let emojiPattern = "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"
//
//    // 普通合法使用场景汉字，数字，英文
//    let legalPattern = "^[a-zA-Z0-9_\u{4e00}-\u{9fa5}]+$
    
}


