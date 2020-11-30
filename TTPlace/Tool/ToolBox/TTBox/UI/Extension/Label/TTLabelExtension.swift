//
//  TTLabelExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/24.
//  Copyright © 2020 刘超. All rights reserved.
//

import Foundation


extension UILabel {
    //MARK: - 常用regelar字号
    class func regular(size: CGFloat = 16,textColor: UIColor = .black,text: String = "",alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = UIFont.regular(size)
        label.textAlignment = alignment
        return label
    }

    
    //MARK: - 常用mediu字号
    class func medium(size: CGFloat = 16,textColor: UIColor = .black,text: String = "",alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = UIFont.medium(size)
        label.textAlignment = alignment
        label.text = text
        return label
    }
    

    //MARK: - 常用bold字号
    class func bold(size: CGFloat = 16,textColor: UIColor = .black,text: String = "",alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = UIFont.bold(size)
        label.textAlignment = alignment
        label.text = text
        return label
    }
}


extension YYLabel {
    //MARK: - 常用regelar字号
    class func regular(size: CGFloat,text: String,textColor: UIColor,alignment: NSTextAlignment) -> YYLabel {
        let label = YYLabel()
        label.textColor = textColor
        label.font = UIFont.regular(size)
        label.textAlignment = alignment
        return label
    }

    
    //MARK: - 常用mediu字号
    class func medium(size: CGFloat = 16,textColor: UIColor = .black,text: String = "",alignment: NSTextAlignment = .left) -> YYLabel {
        let label = YYLabel()
        label.textColor = textColor
        label.font = UIFont.medium(size)
        label.textAlignment = alignment
        label.text = text
        return label
    }
    

    //MARK: - 常用bold字号
    class func bold(size: CGFloat = 16,textColor: UIColor = .black,text: String = "",alignment: NSTextAlignment = .left) -> YYLabel {
        let label = YYLabel()
        label.textColor = textColor
        label.font = UIFont.bold(size)
        label.textAlignment = alignment
        label.text = text
        return label
    }
}

//            let letClickAttributeString = NSMutableAttributedString.init(string: "注册即同意《中国联通认证服务协议》与《用户协议》以及《隐私协议》")
//            letClickAttributeString.setTextHighlight(NSString.init(string: letClickAttributeString.string).range(of: "中国联通认证服务协议》"), color: .orange, backgroundColor: .clear) { (v, attStr, range, rect) in
//                print("富文本点击了")
//            }
//            lable.attributedText = letClickAttributeString
