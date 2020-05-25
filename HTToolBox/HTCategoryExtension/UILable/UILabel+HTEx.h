//
//  UILabel+HTEx.h
//  ChingoItemZDTY
//
//  Created by hong2 on 2019/3/14.
//  Copyright © 2019 洪正烨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (HTlabel)

/**
 直接根据字体大小创建一个label,默认字体regular
 @params size 字号
 @params color 文本颜色
 @params alignment 字号
 @params placeholder 默认占位字符
 */
+ (instancetype)size:(CGFloat)size color:(UIColor *)color textAlignment:(NSTextAlignment)alignment placeholder:(NSString *)placeholder;

/**
 根据字体创建
 @params font 字号
 @params color 文本颜色
 @params alignment 字号
 @params placeholder 默认占位字符
 */
+ (instancetype)font:(UIFont *)font color:(UIColor *)color textAlignment:(NSTextAlignment)alignment placeholder:(NSString *)placeholder;

/**
 计算文本高度
 @param size 父视图最大尺寸
 */
- (CGFloat)calculateHeightWithfatherViewSize:(CGSize)size;

/**
 默认居左的常规体
 @param size 字号
 @param color 颜色
 */
+ (instancetype)regularFontWithSize:(CGFloat)size color:(UIColor *)color;

/**
 默认居中的常规体
 @param size 字号
 @param color 颜色
 */
+ (instancetype)centerRegularFontWithSize:(CGFloat)size color:(UIColor *)color;

/**
 默认居左中规体
 @param size 字号
 @param color 颜色
 */
+ (instancetype)mediumFontWithSize:(CGFloat)size color:(UIColor *)color;

/**
 默认居中常规体
 @param size 字号
 @param color 颜色
 */
+ (instancetype)centerMediumFontWithSize:(CGFloat)size color:(UIColor *)color;

/**
 默认居左粗体
 @param size 字号
 @param color 颜色
 */
+ (instancetype)boldFontWithSize:(CGFloat)size color:(UIColor *)color;

/**
 默认居中粗体
 @param size 字号
 @param color 颜色
 */
+ (instancetype)centerBoldFontWithSize:(CGFloat)size color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
