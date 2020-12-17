//
//  TTLayoutTool.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/24.
//  Copyright © 2020 刘超. All rights reserved.
//

import Foundation

// 标准设计图规范375,667
// 屏幕宽度倍数
let screenWMultiple =  SCREEN_W / 375.0

// 屏幕高度倍数
let screenHMultiple =  SCREEN_H / 667.0

// 屏幕的宽高比
let screenRatio = SCREEN_W / SCREEN_H;

// 屏幕高宽比
let screenHWRatio = SCREEN_H / SCREEN_W;

// 获取比例宽
func hor(_ value: CGFloat) -> CGFloat{
    return value * screenWMultiple
}

// 获取屏幕等比适配纵向比例高
func ver(_ value: CGFloat) -> CGFloat {
    // 纵向按屏幕比例倍数放大
    return value * screenHMultiple
}


// 根据原尺寸宽获取纵 向比例高
func ver(_ sourceWidth: CGFloat ,_ height: CGFloat) -> CGFloat {
    
    // 获取控件等比高
    return ttSize(CGSize.init(width: sourceWidth, height: height)).height
}

//// 根据原尺寸,获取比例的size,是否采用控件比例
//func ttSize(size: CGSize) -> CGSize {
//    let ratioWidth = size.width * screenWMultiple
//    var ratioHeight = size.height == size.width ? ratioWidth :  ratioWidth * screenHWRatio
//    return CGSize.init(width:ratioWidth, height: ratioHeight)
//}


/// 传入控件的尺寸
func ttSize(_ componentsSize: CGSize) -> CGSize {
    let ratioWidth = componentsSize.width * screenWMultiple
    let ratioHeight = componentsSize.height == componentsSize.width ? ratioWidth : ratioWidth * (componentsSize.height / componentsSize.width)
    return CGSize.init(width: ceil(ratioWidth) , height: ceil(ratioHeight))
}

/// 等宽高尺寸
func ttSize(_ value: CGFloat) -> CGSize {
    return ttSize(value, value)
}

// 根据宽高设置尺寸
func ttSize(_ width: CGFloat,_ height: CGFloat) -> CGSize {
    return ttSize(CGSize.init(width: width, height: height))
}

// 屏幕宽高
func ttScreenSize() -> CGSize {
    return CGSize.init(width: SCREEN_W, height: SCREEN_H)
}


// 安全区
func ttSafeTop() -> CGFloat {
     if #available(iOS 11.0, *) {
        return  rootWindow().safeAreaInsets.top
    } else {
        return 0
    }
}

func ttSafeBottom() -> CGFloat {
     if #available(iOS 11.0, *) {
        return  rootWindow().safeAreaInsets.bottom
    } else {
        return 0
    }
}
