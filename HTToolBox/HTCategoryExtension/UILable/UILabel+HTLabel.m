//
//  UILabel+HTlabel.m
//  ChingoItemZDTY
//
//  Created by hong2 on 2019/3/14.
//  Copyright © 2019 洪正烨. All rights reserved.
//

#import "UILabel+HTlabel.h"

@implementation UILabel (HTlabel)
+ (instancetype)size:(CGFloat)size color:(UIColor *)color textAlignment:(NSTextAlignment)alignment placeholder:(NSString *)placeholder{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontSize:size];
    label.textColor = color;
    label.textAlignment = alignment;
    label.text = placeholder;
    return label;
}


+ (instancetype)customFont:(UIFont *)font color:(UIColor *)color textAlignment:(NSTextAlignment)alignment placeholder:(NSString *)placeholder {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = color;
    label.textAlignment = alignment;
    label.text = placeholder;
    return label;
}


+ (instancetype)regularFontWithSize:(CGFloat)size color:(UIColor *)color {
    UILabel *label = [self label];
    label.font = [UIFont fontSize:size];
    label.textColor = color;
    return label;
}


+ (instancetype)mediumFontWithSize:(CGFloat)size color:(UIColor *)color {
    UILabel *label = [self label];
    label.font = [UIFont mediumFontSize:size];
    label.textColor = color;
    return label;
}


+ (instancetype)boldFontWithSize:(CGFloat)size color:(UIColor *)color {
    UILabel *label = [self label];
    label.font = [UIFont boldFontSize:size];
    label.textColor = color;
    return label;
}

+ (CGFloat)calculateHeight:(UILabel *)label fatherViewSize:(CGSize)size{
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:label.font.pointSize]};
    //默认的
    CGRect infoRect =  [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return infoRect.size.height;
}

+ (instancetype)label {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}
@end
