//
//  UILabel+HZYLable.m
//  ChingoItemZDTY
//
//  Created by hong2 on 2019/3/14.
//  Copyright © 2019 洪正烨. All rights reserved.
//

#import "UILabel+HZYLable.h"

@implementation UILabel (HZYLable)
+ (instancetype)size:(CGFloat)size color:(UIColor *)color textAlignment:(NSTextAlignment)alignment placeholder:(NSString *)placeholder{
    UILabel *lable = [[UILabel alloc] init];
    lable.font = [UIFont fontSize:size];
    lable.textColor = color;
    lable.textAlignment = alignment;
    lable.text = placeholder;
    return lable;
}


+ (CGFloat)calculateHeight:(UILabel *)label fatherViewSize:(CGSize)size{
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:label.font.pointSize]};
    
    //默认的
    CGRect infoRect =   [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return infoRect.size.height;
}

@end
