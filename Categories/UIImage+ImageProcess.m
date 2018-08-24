//
//  UIImage+ImageProcess.m
//  HZYToolBox
//
//  Created by hong  on 2018/7/25.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "UIImage+ImageProcess.h"

@implementation UIImage (ImageProcess)
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
@end
