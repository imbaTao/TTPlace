//
//  UILabel+HTEx.m
//  ChingoItemZDTY
//
//  Created by hong2 on 2019/3/14.
//  Copyright © 2019 洪正烨. All rights reserved.
//

#import "UILabel+HTEx.h"

@implementation UILabel (HTlabel)
+ (instancetype)size:(CGFloat)size color:(UIColor *)color textAlignment:(NSTextAlignment)alignment placeholder:(NSString *)placeholder{
    UILabel *label = [self p_label];
    label.font = [UIFont fontSize:size];
    label.textColor = color;
    label.textAlignment = alignment;
    label.text = placeholder;
    return label;
}

+ (instancetype)font:(UIFont *)font color:(UIColor *)color textAlignment:(NSTextAlignment)alignment placeholder:(NSString *)placeholder{
    UILabel *label = [self p_label];
    label.font = font;
    label.textColor = color;
    label.textAlignment = alignment;
    label.text = placeholder;
    return label;
}

+ (instancetype)regularFontWithSize:(CGFloat)size color:(UIColor *)color {
    UILabel *label = [self p_label];
    label.font = [UIFont fontSize:size];
    label.textColor = color;
    return label;
}

+ (instancetype)centerRegularFontWithSize:(CGFloat)size color:(UIColor *)color {
    UILabel *label = [self p_label];
    label.font = [UIFont fontSize:size];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

+ (instancetype)mediumFontWithSize:(CGFloat)size color:(UIColor *)color {
    UILabel *label = [self p_label];
    label.font = [UIFont mediumFontSize:size];
    label.textColor = color;
    return label;
}

+ (instancetype)centerMediumFontWithSize:(CGFloat)size color:(UIColor *)color {
    UILabel *label = [self p_label];
    label.font = [UIFont mediumFontSize:size];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

+ (instancetype)boldFontWithSize:(CGFloat)size color:(UIColor *)color {
    UILabel *label = [self p_label];
    label.font = [UIFont boldFontSize:size];
    label.textColor = color;
    return label;
}

+ (instancetype)centerBoldFontWithSize:(CGFloat)size color:(UIColor *)color {
    UILabel *label = [self p_label];
    label.font = [UIFont boldFontSize:size];
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

#pragma mark - 计算高度
+ (CGFloat)calculateHeight:(UILabel *)label fatherViewSize:(CGSize)size{
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:label.font.pointSize]};
    //默认的
    CGRect infoRect =  [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return infoRect.size.height;
}

+ (instancetype)p_label {
    UILabel *label = [[self alloc] init];
    label.text = @"";
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

@end
