//
//  TTBoxColor.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/19.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation

class TTBoxColor: UIColor {
    static let shard = TTBoxColor()
    
    // 分割线颜色
    var segmentColor = rgba(238, 238, 238, 1)
}

extension UIColor {
    // 随机色
    func randomColor() -> UIColor {
        return rgba(CGFloat(arc4random()%255), CGFloat(arc4random()%255), CGFloat(arc4random()%255), 1)
    }
}

// rgba色
func rgba(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ a: CGFloat) -> UIColor {
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}




