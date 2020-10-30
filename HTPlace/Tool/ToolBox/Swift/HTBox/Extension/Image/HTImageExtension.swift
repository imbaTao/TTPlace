//
//  HTImageExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/24.
//  Copyright © 2020 刘超. All rights reserved.
//

import Foundation


enum HTGradientImagePositon {
    case leftToRight
    case topToBottom
}

extension UIImage {
    //MARK: - 直接根据名字来创建一个Image
    class func name(_ name: String) -> UIImage{
        let image = UIImage.init(named: name)
        return image ?? UIImage()
    }
    
    
    //MARK: - 渐变色图片
     class func gradientImage(position: HTGradientImagePositon, withColors colors: [UIColor]?, size: CGSize,radius: CGFloat, opacity: CGFloat) -> UIImage? {
           if colors?.count == nil || size.equalTo(CGSize.zero) {
               return nil
           }
           let gradientLayer = CAGradientLayer()
           gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
           gradientLayer.startPoint = CGPoint(x: 0, y: 0)
           gradientLayer.endPoint = CGPoint(x: 1, y: 0)


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
    
            outputImage = outputImage?.byRoundCornerRadius(radius)
           return outputImage
    }
    
     open class func gradientImage(colors: [UIColor]?, size: CGSize,radius: CGFloat, opacity: CGFloat) -> UIImage? {
        return self.gradientImage(position: .leftToRight, withColors: colors, size: size, radius: radius, opacity: opacity)
      }
    
    
//    - (UIImage *)imageByRoundCornerRadius:(CGFloat)radius {
//        return [self imageByRoundCornerRadius:radius borderWidth:0 borderColor:nil];
//    }
//
//    - (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
//                              borderWidth:(CGFloat)borderWidth
//                              borderColor:(UIColor *)borderColor {
//        return [self imageByRoundCornerRadius:radius
//                                      corners:UIRectCornerAllCorners
//                                  borderWidth:borderWidth
//                                  borderColor:borderColor
//                               borderLineJoin:kCGLineJoinMiter];
//    }
//
//    - (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
//                                  corners:(UIRectCorner)corners
//                              borderWidth:(CGFloat)borderWidth
//                              borderColor:(UIColor *)borderColor
//                           borderLineJoin:(CGLineJoin)borderLineJoin {
//
//        if (corners != UIRectCornerAllCorners) {
//            UIRectCorner tmp = 0;
//            if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
//            if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
//            if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
//            if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
//            corners = tmp;
//        }
//
//        UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
//        CGContextScaleCTM(context, 1, -1);
//        CGContextTranslateCTM(context, 0, -rect.size.height);
//
//        CGFloat minSize = MIN(self.size.width, self.size.height);
//        if (borderWidth < minSize / 2) {
//            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
//            [path closePath];
//
//            CGContextSaveGState(context);
//            [path addClip];
//            CGContextDrawImage(context, rect, self.CGImage);
//            CGContextRestoreGState(context);
//        }
//
//        if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
//            CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
//            CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
//            CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
//            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
//            [path closePath];
//
//            path.lineWidth = borderWidth;
//            path.lineJoinStyle = borderLineJoin;
//            [borderColor setStroke];
//            [path stroke];
//        }
//
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return image;
//    }

}

