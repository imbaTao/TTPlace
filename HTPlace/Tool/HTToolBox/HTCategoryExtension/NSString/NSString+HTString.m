//
//  NSString+HTString.m
//  HTPlace
//
//  Created by Mr.hong on 2020/5/26.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "NSString+HTString.h"

@implementation NSString (HTString)



// 从YYModel中提出，根据字符串内容获取字符串的长款
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}



// 传入字体，获取宽度
- (CGFloat)ht_widthForFont:(UIFont *)font height:(CGFloat)height mode:(NSLineBreakMode)lineBreakMode {
    return [self sizeForFont:font size:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:lineBreakMode].width;
}

// 传入字体，获取高度
- (CGFloat)ht_heightForFont:(UIFont *)font width:(CGFloat)width mode:(NSLineBreakMode)lineBreakMode {
    return [self sizeForFont:font size:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:lineBreakMode].height;
}

- (bool)hasValue {
    return self.length > 0 && ![self containsString:@"null"] && ![self containsString:@"NULL"];
}

@end
