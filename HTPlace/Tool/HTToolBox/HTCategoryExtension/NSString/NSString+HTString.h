//
//  NSString+HTString.h
//  HTPlace
//
//  Created by Mr.hong on 2020/5/26.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HTString)

/**
 是否有值
 */
@property(nonatomic, readwrite, assign)bool hasValue;


/**
传入字体、最大尺寸，直接获取实际尺寸
@param font 字体
@param size 最大尺寸
@param lineBreakMode 字体的分割模式
*/

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;


/**
 传入字体、高度，直接获取宽度
 @param font 字体
 @param height 字体的高度限制值
 @param model 字体的分割模式
 */
- (CGFloat)widthForFont:(UIFont *)font height:(CGFloat)height model:(NSLineBreakMode)model;


/**
传入字体、宽度，直接获取高度
@param font 字体
@param width 字体的高度限制值
@param model 字体的分割模式
*/
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width model:(NSLineBreakMode)model;


@end

NS_ASSUME_NONNULL_END
