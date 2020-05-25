//
//  UIView+HTViewLayout.h
//  HZYToolBox
//
//  Created by hong on 2019/11/21.
//  Copyright © 2019 HZY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 按比例适配
#define ver(value)    [UIView verticalValue:value]
#define hor(value)    [UIView horizontal:value]
#define square(value) [UIView square:value]

@interface UIView (HTViewLayout)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign, readonly) CGFloat maxY;
@property (nonatomic, assign, readonly) CGFloat maxX;



/**
 水平、垂直、正方形
 */
+ (CGFloat)verticalValue:(CGFloat)value;
+ (CGFloat)horizontal:(CGFloat)value;
+ (CGSize)square:(CGFloat)value;




#pragma mark - Masonry 布局封装
// 填充满
- (void)edegesFull:(UIView *)referView;

#pragma mark - 居中
- (void)centerWithReferView:(UIView *)referView;
- (void)centerWithReferView:(UIView *)referView size:(CGSize)size;


// 中心y
- (void)centerYWithReferView:(UIView *)referView rihgt:(CGFloat)rihgt;

// 上
- (void)top:(CGFloat)t left:(CGFloat)left;
- (void)top:(CGFloat)top sideEdge:(CGFloat)sideEdge;
- (void)top:(CGFloat)top right:(CGFloat)right;
- (void)top:(CGFloat)top left:(CGFloat)left size:(CGSize)size;


// 左
- (void)left:(CGFloat)left right:(CGFloat)right top:(CGFloat)top height:(CGFloat)height referView:(nonnull UIView *)referView;

- (void)left:(CGFloat)left right:(CGFloat)right baseLineTop:(CGFloat)baseLineTop referView:(nonnull UIView *)referView;


// 下
- (void)bottom:(CGFloat)bottom left:(CGFloat)left right:(CGFloat)right height:(CGFloat)height;

/**
 上左下右的Masonry约束
 */
- (void)t:(CGFloat)t l:(CGFloat)l b:(CGFloat)b r:(CGFloat)r;
@end

NS_ASSUME_NONNULL_END
