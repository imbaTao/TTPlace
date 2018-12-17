//
//  UIButton+CutomBtnMethod.m
//  HZYToolBox
//
//  Created by hong  on 2018/6/27.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import "UIButton+CutomBtnMethod.h"

@implementation UIButton (CutomBtnMethod)

// only Img
+ (UIButton *)creatBtnWithImgName:(NSString *)name selector:(SEL)selector{
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newButton setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [newButton addTarget:self action:@selector(selector) forControlEvents:UIControlEventTouchUpInside];
    return newButton;
}

// backGroundImg && titile
+ (UIButton *)creatBtnWithBackgroundImgName:(NSString *)backgroundImgName selector:(SEL)selector text:(NSString *)text fontSize:(CGFloat)size{
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newButton setBackgroundImage:[UIImage imageNamed:backgroundImgName] forState:UIControlStateNormal];
    newButton.titleLabel.text = text;
    newButton.titleLabel.font = [UIFont systemFontOfSize:size];
    [newButton addTarget:self action:@selector(selector) forControlEvents:UIControlEventTouchUpInside];
    return newButton;
}



@end
