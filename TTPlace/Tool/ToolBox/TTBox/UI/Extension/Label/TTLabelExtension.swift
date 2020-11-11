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
    class func regular(size: CGFloat,textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = UIFont.regular(size)
        return label
    }
    
    // 常用regelar字号
    class func regular(size: CGFloat,textColor: UIColor,text: String) -> UILabel {
        let label = self.regular(size: size,textColor: textColor)
        label.text = text
        return label
    }
    
    
    // 带textAlignment
    class func regular(size: CGFloat,textColor: UIColor,alignment: NSTextAlignment) -> UILabel {
        let label = self.regular(size: size,textColor: textColor)
        label.textAlignment = alignment
        return label
    }
    
    
    //MARK: - 常用mediu字号
    class func medium(size: CGFloat,textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = UIFont.medium(size)
        return label
    }
    
    // 常用medium字号
    class func medium(size: CGFloat,textColor: UIColor,text: String) -> UILabel {
        let label = self.medium(size: size,textColor: textColor)
        label.text = text
        return label
    }

    
    
    // 带textAlignment
    class func medium(size: CGFloat,textColor: UIColor,alignment: NSTextAlignment) -> UILabel {
        let label = self.medium(size: size,textColor: textColor)
        label.textAlignment = alignment
        return label
    }
    
    // 带textAlignment和字
    class func medium(size: CGFloat,textColor: UIColor,text: String,alignment: NSTextAlignment) -> UILabel {
          let label = self.medium(size: size,textColor: textColor,alignment: alignment)
          label.textAlignment = alignment
          label.text = text
          return label
      }

    
    
    //MARK: - 常用bold字号
    class func bold(size: CGFloat,textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = UIFont.bold(size)
        return label
    }
    
    // 常用medium字号
    class func bold(size: CGFloat,textColor: UIColor,text: String) -> UILabel {
        let label = self.bold(size: size,textColor: textColor)
        label.text = text
        return label
    }

    // 带textAlignment
    class func bold(size: CGFloat,textColor: UIColor,alignment: NSTextAlignment) -> UILabel {
        let label = self.bold(size: size,textColor: textColor)
        label.textAlignment = alignment
        return label
    }
    
}


extension YYLabel {
    //MARK: - 常用regelar字号
    class func regular(size: CGFloat,textColor: UIColor) -> YYLabel {
        let label = YYLabel()
        label.textColor = textColor
        label.font = UIFont.regular(size)
        return label
    }
    
    // 常用regelar字号
    class func regular(size: CGFloat,textColor: UIColor,text: String) -> YYLabel {
        let label = self.regular(size: size,textColor: textColor)
        label.text = text
        return label
    }
    
    
    // 带textAlignment
    class func regular(size: CGFloat,textColor: UIColor,alignment: NSTextAlignment) -> YYLabel {
        let label = self.regular(size: size,textColor: textColor)
        label.textAlignment = alignment
        return label
    }
    
    
    //MARK: - 常用mediu字号
    class func medium(size: CGFloat,textColor: UIColor) -> YYLabel {
        let label = YYLabel()
        label.textColor = textColor
        label.font = UIFont.medium(size)
        return label
    }
    
    // 常用medium字号
    class func medium(size: CGFloat,textColor: UIColor,text: String) -> YYLabel {
        let label = self.medium(size: size,textColor: textColor)
        label.text = text
        return label
    }

    
    
    // 带textAlignment
    class func medium(size: CGFloat,textColor: UIColor,alignment: NSTextAlignment) -> YYLabel {
        let label = self.medium(size: size,textColor: textColor)
        label.textAlignment = alignment
        return label
    }
    
    // 带textAlignment和字
    class func medium(size: CGFloat,textColor: UIColor,text: String,alignment: NSTextAlignment) -> YYLabel {
          let label = self.medium(size: size,textColor: textColor,alignment: alignment)
          label.textAlignment = alignment
          label.text = text
          return label
      }

    
    
    //MARK: - 常用bold字号
    class func bold(size: CGFloat,textColor: UIColor) -> YYLabel {
        let label = YYLabel()
        label.textColor = textColor
        label.font = UIFont.bold(size)
        return label
    }
    
    // 常用medium字号
    class func bold(size: CGFloat,textColor: UIColor,text: String) -> YYLabel {
        let label = self.bold(size: size,textColor: textColor)
        label.text = text
        return label
    }

    // 带textAlignment
    class func bold(size: CGFloat,textColor: UIColor,alignment: NSTextAlignment) -> YYLabel {
        let label = self.bold(size: size,textColor: textColor)
        label.textAlignment = alignment
        return label
    }
}

//            let letClickAttributeString = NSMutableAttributedString.init(string: "注册即同意《中国联通认证服务协议》与《用户协议》以及《隐私协议》")
//            letClickAttributeString.setTextHighlight(NSString.init(string: letClickAttributeString.string).range(of: "中国联通认证服务协议》"), color: .orange, backgroundColor: .clear) { (v, attStr, range, rect) in
//                print("富文本点击了")
//            }
//            lable.attributedText = letClickAttributeString
