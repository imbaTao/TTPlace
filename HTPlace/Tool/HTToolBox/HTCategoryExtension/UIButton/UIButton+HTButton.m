//
//  UIButton+HTButton.m
//  ChingoItemZDTY
//
//  Created by hong  on 2019/3/6.
//  Copyright © 2019 HSKY. All rights reserved.
//

#import "UIButton+HTButton.h"

@implementation UIButton (HTButton)

-  (void)changeTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
}

+ (instancetype)title:(NSString *)title selector:(SEL)selctor target:(id)target iconName:(NSString *)iconName{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:selctor forControlEvents:UIControlEventTouchUpInside];
    if (iconName.length) {
         [button setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    }
    return button;
}

+ (instancetype)title:(NSString *)title iconName:(NSString *)iconName fontSize:(CGFloat)size {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    if (iconName.length) {
        [button setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    }
    return button;
}

+ (instancetype)iconName:(NSString *)iconName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (iconName.length) {
        [button setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    }
    return button;
}




+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleCorlor font:(UIFont *)font{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleCorlor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}

+ (instancetype)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleCorlor font:(UIFont *)font backGroundColor:(nullable UIColor *)backGroundColor cornerRadius:(CGFloat)radius {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleCorlor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    if (backGroundColor) {
        button.backgroundColor = backGroundColor;
    }
    
    if (radius > 0) {
     [button settingCornerRadius:radius];
    }
    return button;
}







#pragma mark - 扩大点击热区
- (BOOL)pointInside:(CGPoint)point
          withEvent:(UIEvent *)event {
    const static CGFloat minimumSide = 60;
    CGFloat differenceY = minimumSide - self.bounds.size.height;
    CGFloat differenceX = minimumSide - self.bounds.size.width;

    CGFloat insetY = MAX(0, differenceY);
    CGFloat insetX = MAX(0, differenceX);

    return CGRectContainsPoint(CGRectInset(self.bounds, -insetX, -insetY), point) || [super pointInside:point withEvent:event];
}
@end
