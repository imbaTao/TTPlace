//
//  HTLabelExtension.swift
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
        label.font = UIFont.size(size)
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

