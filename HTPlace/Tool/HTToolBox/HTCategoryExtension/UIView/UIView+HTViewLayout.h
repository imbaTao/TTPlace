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

// 传原高度，宽度，返回按比例的适配高宽
#define HTSIZE(w,h) [UIView htSize:w height:h]

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

/**
 根据视图比例返回比例后的高
 */
+ (CGSize)htSize:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
