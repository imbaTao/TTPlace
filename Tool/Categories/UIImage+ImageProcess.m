//
//  UIImage+ImageProcess.m
//  HZYToolBox
//
//  Created by hong  on 2018/7/25.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "UIImage+ImageProcess.h"

@implementation UIImage (ImageProcess)
//图片倒圆角
+ (UIImage *)imageWithCornerRadius:(CGFloat)radius image:(UIImage *)image{
    
    CGRect rect = (CGRect){0.f, 0.f, image.size};
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, UIScreen.mainScreen.scale);
    CGContextAddPath(UIGraphicsGetCurrentContext(),
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(UIGraphicsGetCurrentContext());
    
    [image drawInRect:rect];
    UIImage *new = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return new;
}


/** 虚线 */
+(UIImage *)imageWithLineWithImageView:(UIImageView *)imageView color:(UIColor *)color length:(CGFloat)length interval:(CGFloat)interval{
    CGFloat width = imageView.frame.size.width;
    CGFloat height = imageView.frame.size.height;
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, width, height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGFloat lengths[] = {length,interval};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line,color.CGColor);
    CGContextSetLineDash(line, 0, lengths, 1);
    CGContextMoveToPoint(line, 0, 1);
    CGContextAddLineToPoint(line, width, 1);
    CGContextStrokePath(line);
    return  UIGraphicsGetImageFromCurrentImageContext();
}
@end
