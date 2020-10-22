//
//  HTImageExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/24.
//  Copyright © 2020 刘超. All rights reserved.
//

import Foundation

extension UIImage {
    // 直接根据名字来创建一个Image
    class func name(_ name: String) -> UIImage{
        let image = UIImage.init(named: name)
        return image ?? UIImage()
    }
    
    // 渐变色图片
   open class func gradientImage(withColors colors: [UIColor]?, rect: CGRect, cornerRadius radius: CGFloat, opacity: CGFloat) -> UIImage? {
           if colors?.count == nil || rect.equalTo(CGRect.zero) {
               return nil
           }
           let gradientLayer = CAGradientLayer()
           gradientLayer.frame = rect
           gradientLayer.startPoint = CGPoint(x: 0, y: 0)
           gradientLayer.endPoint = CGPoint(x: 1, y: 0)


            var cgColorArray = [CGColor]()
            for color in colors! {
                cgColorArray.append(color.cgColor)
            }
           gradientLayer.colors = cgColorArray

           gradientLayer.locations = [NSNumber(value: 0), NSNumber(value: 1.0)]
           gradientLayer.cornerRadius = radius
           gradientLayer.shadowColor = UIColor(red: 178 / 255.0, green: 108 / 255.0, blue: 249 / 255.0, alpha: 0.35).cgColor
           gradientLayer.shadowOffset = CGSize(width: 0, height: 2)
           gradientLayer.shadowOpacity = 1
           gradientLayer.shadowRadius = 20
           gradientLayer.opacity = Float(opacity)
           UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, gradientLayer.isOpaque, 0)
           if let context = UIGraphicsGetCurrentContext() {
               gradientLayer.render(in: context)
           }
           let outputImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return outputImage
       }
}

