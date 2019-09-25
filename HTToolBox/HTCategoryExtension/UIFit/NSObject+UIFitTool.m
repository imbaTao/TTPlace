//
//  NSObject+UIFitTool.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/29.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "NSObject+UIFitTool.h"

#define IPHone6sSize CGSizeMake(375, 667)
#define W_RATIO  [UIScreen mainScreen].bounds.size.width / IPHone6sSize.width
#define H_RATIO  [UIScreen mainScreen].bounds.size.height / IPHone6sSize.height

@implementation NSObject (UIFitTool)
// 工作原理，根据6s 4.7寸屏幕,或设计图尺寸进行全设备相对适配
/**
 1.上左下右顺序
 */
+ (CGFloat)verticalValue:(CGFloat)value{
    value *= H_RATIO;
    return value;
}

+ (CGFloat)horizontal:(CGFloat)value{
    value *= W_RATIO;
    return value;
}

+ (CGSize)square:(CGFloat)value {
    return CGSizeMake(value, value);
}
@end

