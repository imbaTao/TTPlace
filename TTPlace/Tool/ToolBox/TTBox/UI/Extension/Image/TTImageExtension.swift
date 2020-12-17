//
//  TTImageExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/24.
//  Copyright © 2020 刘超. All rights reserved.
//

import Foundation


enum TTGradientImagePositon {
    case leftToRight
    case topToBottom
    case topLeftToRightBottom
}

extension UIImage {
    
    class func testImage() -> UIImage {
        return .name("TTTest")
    }
    class func testImage1() -> UIImage {
        return .name("TTTest1")
    }
    
    //MARK: - 直接根据名字来创建一个Image
    class func name(_ name: String) -> UIImage{
        if name.count == 0 {
            return UIImage()
        }
        
        let image = UIImage.init(named: name)
        return image ?? UIImage()
    }
    
    
    //MARK: - 渐变色图片
    class func gradientImage(position: TTGradientImagePositon = .leftToRight,startPoint: CGPoint? = nil,endPoint: CGPoint? = nil,colors: [UIColor]?, size: CGSize,radius: CGFloat = 0, opacity: CGFloat = 1) -> UIImage? {
           if colors?.count == nil || size.equalTo(CGSize.zero) {
               return nil
           }
         let gradientLayer = CAGradientLayer()
         gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
      
        
        if startPoint != nil {
            gradientLayer.startPoint = startPoint!
            gradientLayer.endPoint = endPoint!
        }else {
            switch position {
            case .leftToRight:
                gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            case .topToBottom:
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
            case .topLeftToRightBottom:
                gradientLayer.startPoint = CGPoint(x: 0, y: 0)
                gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            }
        }
            
    


            var cgColorArray = [CGColor]()
            for color in colors! {
                cgColorArray.append(color.cgColor)
            }
           gradientLayer.colors = cgColorArray
           gradientLayer.locations = [NSNumber(value: 0), NSNumber(value: 1.0)]
           gradientLayer.shadowColor = UIColor(red: 178 / 255.0, green: 108 / 255.0, blue: 249 / 255.0, alpha: 0.35).cgColor
           gradientLayer.shadowOffset = CGSize(width: 0, height: 2)
           gradientLayer.shadowOpacity = 1
           gradientLayer.shadowRadius = 20
           gradientLayer.opacity = Float(opacity)
           UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, gradientLayer.isOpaque, 0)
           if let context = UIGraphicsGetCurrentContext() {
               gradientLayer.render(in: context)
           }
           var outputImage = UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
    
            
        
            // 倒圆角
            if radius > 0.0 {
                 outputImage = outputImage?.byRoundCornerRadius(radius)
            }
           
           return outputImage
    } 
    
     open class func gradientImage(colors: [UIColor]?, size: CGSize,radius: CGFloat, opacity: CGFloat) -> UIImage? {
        return self.gradientImage(position: .leftToRight, colors: colors, size: size, radius: radius, opacity: opacity)
      }
    
    
    
    //获取压缩后的图片
    func zip(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

