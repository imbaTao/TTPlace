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


// 传入字体，获取宽度
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/**
 <#???#>
 @param <#???#>
 */
- (CGFloat)widthForFont:(UIFont *)font height:(CGFloat)height mode:(NSLineBreakMode)lineBreakMode;

// 传入字体，获取高度
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width mode:(NSLineBreakMode)lineBreakMode;


@end

NS_ASSUME_NONNULL_END
