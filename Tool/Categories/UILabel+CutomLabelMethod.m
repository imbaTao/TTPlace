//
//  UILabel+CutomMethod.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/27.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "UILabel+CutomLabelMethod.h"

@implementation UILabel (CutomMethod)
+ (UILabel *)creatLabelWithText:(NSString *)text textColor:(UIColor *)color fontSize:(CGFloat)size{
    UILabel *newLable = [[UILabel alloc] init];
    newLable.text = text;
    newLable.textColor = color;
    newLable.font = [UIFont systemFontOfSize:size];
    newLable.textAlignment = NSTextAlignmentCenter;
    return newLable;
}
@end
