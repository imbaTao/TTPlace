//
//  TTLayoutTool.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/24.
//  Copyright © 2020 刘超. All rights reserved.
//

import Foundation


let screenRatio = SCREEN_W / 375.0
// 获取比例宽
func hor(_ value: CGFloat) -> CGFloat{
    return value * screenRatio
}

// 获取纵向比例高
func ver(_ value: CGFloat) -> CGFloat {
    return htSize(size: CGSize.init(width: SCREEN_W, height: value)).height
}

// 根据原尺寸宽获取纵向比例高
func ver(_ sourceWidth: CGFloat ,_ value: CGFloat) -> CGFloat {
    return htSize(size: CGSize.init(width: sourceWidth, height: value)).height
}

//// 根据原尺寸,获取比例的size
func htSize(size: CGSize) -> CGSize {
    let ratioWidth = size.width * screenRatio
    let ratioHeight = ratioWidth * (size.height / size.width)
    return CGSize.init(width: ratioWidth, height: ratioHeight)
}

// 根据宽高设置尺寸
func htSize(_ width: CGFloat,_ height: CGFloat) -> CGSize {
    let ratioWidth = width * screenRatio
    let ratioHeight = ratioWidth * (height / width)
    return CGSize.init(width: ratioWidth, height: ratioHeight)
}

// 根据宽高设置尺寸
func htSize(_ value: CGFloat) -> CGSize {
    return htSize(value, value)
}
