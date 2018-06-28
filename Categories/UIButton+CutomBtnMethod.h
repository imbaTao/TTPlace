//
//  UIButton+CutomBtnMethod.h
//  HZYToolBox
//
//  Created by hong  on 2018/6/27.
//  Copyright © 2018年 HZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CutomBtnMethod)

// only Img
+ (UIButton *)creatBtnWithImgName:(NSString *)name selector:(SEL)selector;

// backGroundImg && titile
+ (UIButton *)creatBtnWithBackgroundImgName:(NSString *)backgroundImgName selector:(SEL)selector text:(NSString *)text fontSize:(CGFloat)size;
@end
