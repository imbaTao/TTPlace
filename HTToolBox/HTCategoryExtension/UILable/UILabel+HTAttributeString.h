//
//  UILabel+HTAttributeString.h
//  HTPlace
//
//  Created by hong on 2020/3/31.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (HTAttributeString)

/**
 变更文字字间距
 @param text 内容
 @param wordSpace 字间距
 @param range 生效范围
 */
- (void)attributeText:(NSString *)text wordSpace:(CGFloat)wordSpace range:(NSRange)range;


/**
 变更文字字间距
 @param text 内容
 @param wordSpace 字间距
 @param range 生效范围
 */
+ (void)attributeTextWithLabel:(UILabel *)label text:(NSString *)text wordSpace:(CGFloat)wordSpace range:(NSRange)range;

/**
变更文字字间距
@param text 内容
@param baseFont 全局font
@param subFont 部分font
@param range 生效范围
*/
- (void)attributeText:(NSString *)text baseFont:(UIFont *)baseFont subFont:(UIFont *)subFont range:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
