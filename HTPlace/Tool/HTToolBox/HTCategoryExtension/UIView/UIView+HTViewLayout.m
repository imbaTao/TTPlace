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
#define H_RATIO  [UIScreen mainScreen].bounds.size.height / IPHone6sSize.height

@implementation UIView (HTViewLayout)

//- (void)top:(CGFloat)top right:(CGFloat)right;

#pragma mark - masonry布局代码
// 间距
- (void)edeges:(UIEdgeInsets)edges {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(edges);
    }];
}

// 填充
- (void)edegesFull:(UIView *)referView {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(referView);
    }];
}

#pragma mark - top
// 左上
- (void)top:(CGFloat)top left:(CGFloat)left {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(top);
        make.left.offset(left);
    }];
}

// 左上
- (void)top:(CGFloat)top left:(CGFloat)left size:(CGSize)size {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(top);
        make.left.offset(left);
        make.size.mas_equalTo(size);
    }];
}


// 上 两侧边距
- (void)top:(CGFloat)top sideEdge:(CGFloat)sideEdge {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(top);
        make.left.offset(sideEdge);
        make.right.offset(-sideEdge);
    }];
}

// 上右
- (void)top:(CGFloat)top right:(CGFloat)right {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(top);
        make.right.offset(-right);
    }];
}

// 右上角布局
- (void)top:(CGFloat)top right:(CGFloat)right left:(CGFloat)left {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(top);
        make.left.offset(left);
        make.right.offset(-right);
    }];
}


#pragma mark - left
// 左 右 baseLine
- (void)left:(CGFloat)left right:(CGFloat)right top:(CGFloat)top height:(CGFloat)height referView:(nonnull UIView *)referView {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(left);
        make.right.offset(-right);
        make.top.equalTo(referView.mas_bottom).offset(top);
        make.height.offset(height);
    }];
}


// 左 右 baseLine
- (void)left:(CGFloat)left right:(CGFloat)right baseLineTop:(CGFloat)baseLineTop referView:(nonnull UIView *)referView {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(left);
        make.right.offset(-right);
        make.baseline.equalTo(referView.mas_bottom).offset(baseLineTop);
    }];
}


#pragma mark - bottom

// 下
- (void)bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right height:(CGFloat)height {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(left);
        make.right.offset(-right);
        make.bottom.offset(-bottom);
        make.height.offset(height);
    }];

}

#pragma mark - 最简单的中心布局
- (void)centerWithReferView:(UIView *)referView {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(referView);
    }];
}

// 带尺寸的中心布局
- (void)centerWithReferView:(UIView *)referView size:(CGSize)size {
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(referView);
        make.size.mas_equalTo(size);
    }];
}

// 中心X布局 top距离
- (void)centerXWithReferView:(UIView *)referView top:(CGFloat)top{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(referView);
        make.top.equalTo(referView.mas_bottom).offset(top);
    }];
}

// 中心x top size
- (void)centerXWithReferView:(UIView *)referView top:(CGFloat)top size:(CGSize)size{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(referView);
        make.top.equalTo(referView.mas_bottom).offset(top);
        make.size.mas_equalTo(size);
    }];
}

// 中心X布局 baseLinetop距离
- (void)centerXWithReferView:(UIView *)referView baseLineTop:(CGFloat)baseLineTop{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(referView);
       make.baseline.equalTo(referView.mas_bottom).offset(baseLineTop);
    }];
}




// 中心X布局 baseLinetop距离
- (void)centerXWithReferView:(UIView *)referView baseLineTop:(CGFloat)baseLineTop size:(CGSize)size{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(referView);
       make.baseline.equalTo(referView.mas_bottom).offset(baseLineTop);
        make.size.mas_equalTo(size);
    }];
}

#pragma mark - centerY布局
// 中心y 右侧
- (void)centerYWithReferView:(UIView *)referView rihgt:(CGFloat)rihgt{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(referView);
        make.right.offset(-rihgt);
    }];
}




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

// 工作原理，根据6s 4.7寸屏幕,或设计图尺寸进行全设备相对适配
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
