//
//  UIView+HTViewLayout.m
//  HZYToolBox
//
//  Created by hong on 2019/11/21.
//  Copyright © 2019 HZY. All rights reserved.
//

#import "UIView+HTViewLayout.h"

#define IPHone6sSize CGSizeMake(375, 667)
#define W_RATIO  [UIScreen mainScreen].bounds.size.width / IPHone6sSize.width
//#define H_RATIO  [UIScreen mainScreen].bounds.size.height / IPHone6sSize.height

@implementation UIView (HTViewLayout)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

+ (CGFloat)verticalValue:(CGFloat)value{
    return [self htSize:375 height:value].height;;
}

+ (CGFloat)horizontal:(CGFloat)value{
    value *= W_RATIO;
    return value;
}

+ (CGSize)square:(CGFloat)value {
    return CGSizeMake(value, value);
}

+ (CGSize)htSize:(CGFloat)width height:(CGFloat)height {
    // 按比例后的宽度
    CGFloat mutiwidth = width * W_RATIO;
    return CGSizeMake(mutiwidth, mutiwidth * height / width);
}

@end
