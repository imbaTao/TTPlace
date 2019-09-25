//
//  UILabel+HTlabel.h
//  ChingoItemZDTY
//
//  Created by hong2 on 2019/3/14.
//  Copyright © 2019 洪正烨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (HTlabel)

/**
  初始化一个label
 */
+ (instancetype)size:(CGFloat)size color:(UIColor *)color textAlignment:(NSTextAlignment)alignment placeholder:(NSString *)placeholder;


/**
 初始化一个label
 */
+ (instancetype)customFont:(UIFont *)font color:(UIColor *)color textAlignment:(NSTextAlignment)alignment placeholder:(NSString *)placeholder;


/**
 计算label高
 */
+ (CGFloat)calculateHeight:(UILabel *)label fatherViewSize:(CGSize)size;


/**
 常规体
 */
+ (instancetype)regularFontWithSize:(CGFloat)size color:(UIColor *)color ;

/**
 中规体
 */
+ (instancetype)mediumFontWithSize:(CGFloat)size color:(UIColor *)color ;

/**
 粗体
 */
+ (instancetype)boldFontWithSize:(CGFloat)size color:(UIColor *)color ;

@end

NS_ASSUME_NONNULL_END
