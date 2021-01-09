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
    class func regular(size: CGFloat = 16,textColor: UIColor = .black,text: String = "",backgroundColor: UIColor = .clear,cornerRadius: CGFloat = 0,alignment: NSTextAlignment = .left,numberOfline: Int = 1) -> UILabel {
        let label = UILabel.fetchLabel()
        label.textColor = textColor
        label.font = UIFont.regular(size)
        label.textAlignment = alignment
        label.text = text
        label.numberOfLines = numberOfline
        label.backgroundColor = backgroundColor
        if cornerRadius > 0 {
            label.cornerRadius = cornerRadius
        }
     
        return label
    }

    
    //MARK: - 常用mediu字号
    class func medium(size: CGFloat = 16,textColor: UIColor = .black,text: String = "",backgroundColor: UIColor = .clear,alignment: NSTextAlignment = .left,numberOfline: Int = 1) -> UILabel {
        let label = UILabel.fetchLabel()
        label.textColor = textColor
        label.font = UIFont.regular(size)
        label.textAlignment = alignment
        label.text = text
        label.numberOfLines = numberOfline
        label.backgroundColor = backgroundColor
        return label
    }
    

    //MARK: - 常用bold字号
    class func bold(size: CGFloat = 16,textColor: UIColor = .black,text: String = "",backgroundColor: UIColor = .clear,alignment: NSTextAlignment = .left,numberOfline: Int = 1) -> UILabel {
        let label = UILabel.fetchLabel()
        label.textColor = textColor
        label.font = UIFont.regular(size)
        label.textAlignment = alignment
        label.text = text
        label.numberOfLines = numberOfline
        label.backgroundColor = backgroundColor
        return label
    }
    
    func config(font: UIFont = UIFont.regular(16),textColor: UIColor = .black,text: String = "",backgroundColor: UIColor = .clear,alignment: NSTextAlignment = .left,numberOfline: Int = 1) {
        self.textColor = textColor
        self.font = font
        self.textAlignment = alignment
        self.text = text
        self.numberOfLines = numberOfline
        self.backgroundColor = backgroundColor
    }
    
   class func fetchLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }
}

extension UILabel {
    // 添加左侧或者右侧的间距
    func addLeftAndRightImage(_ name: String = "", interval: CGFloat = 0,leftInterval: CGFloat = 0,rightInterval: CGFloat = 0,leftImageName: String = "",rightImageName: String = "") {
        for index in 0..<2 {
          
            if index == 0 {
                let imageView = UIImageView.name(leftImageName.count > 0 ? leftImageName : name)
                addSubview(imageView)
                imageView.snp.makeConstraints { (make) in
                    make.right.equalTo(self.snp.left).offset(leftInterval > 0 ?  -leftInterval : -interval)
                    make.centerY.equalToSuperview()
                }
            }else {
                let imageView = UIImageView.name(rightImageName.count > 0 ? rightImageName : name)
                addSubview(imageView)
                imageView.snp.makeConstraints { (make) in
                    make.left.equalTo(self.snp.right).offset(rightInterval > 0 ?  rightInterval : interval)
                    make.centerY.equalToSuperview()
                }
            }
        }
    }
}



extension YYLabel {
    class func regular(size: CGFloat = 16,textColor: UIColor = .black,text: String = "",alignment: NSTextAlignment = .left) -> YYLabel {
        let label = YYLabel()
        label.textColor = textColor
        label.font = UIFont.regular(size)
        label.textAlignment = alignment
        label.text = text
        return label
    }
    
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
