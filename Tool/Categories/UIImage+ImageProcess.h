//
//  UIImage+ImageProcess.h
//  HZYToolBox
//
//  Created by hong  on 2018/7/25.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageProcess)
// 倒圆角
+ (UIImage *)imageWithCornerRadius:(CGFloat)radius image:(UIImage *)image;

// 虚线
+(UIImage *)imageWithLineWithImageView:(UIImageView *)imageView color:(UIColor *)color length:(CGFloat)length interval:(CGFloat)interval;
@end
