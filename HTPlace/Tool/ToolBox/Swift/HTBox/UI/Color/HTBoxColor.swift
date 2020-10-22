//
//  HTBoxColor.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/19.
//  Copyright © 2020 刘超. All rights reserved.
//

import Foundation

// rgba色
func rgba(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ a: CGFloat) -> UIColor {
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}


// 随机色
func randomColor() -> UIColor {
    return rgba(CGFloat(arc4random()%255), CGFloat(arc4random()%255), CGFloat(arc4random()%255), 1)
}
