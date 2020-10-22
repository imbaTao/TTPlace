//
//  HTFontExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/24.
//  Copyright © 2020 刘超. All rights reserved.
//

import Foundation

extension UIFont {
    class func size(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: CGFloat(size))
    }
    
    class func medium(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    class func bold(_ size: CGFloat) -> UIFont {
           return UIFont.systemFont(ofSize: size, weight: .bold)
       }
}
