//
//  NSAttributedString+Colorful.h
//  HTToolBox
//
//  Created by hong  on 2018/9/3.
//  Copyright © 2018年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Colorful)
// 根据段落数和渲染颜色获取富文本(一段)
+ (instancetype)colorFulStringWithString:(NSString *)string  beginIndex:(NSInteger)beginIndex lengthArray:(NSArray *)lengthArray colorArray:(NSArray *)colorArray allColor:(UIColor *)allColor;

// 根据段落数和渲染颜色获取富文本(多段)
+ (instancetype)colorFulStringWithString:(NSString *)string  indexArray:(NSArray *)indexArray lengthArray:(NSArray *)lengthArray colorArray:(NSArray *)colorArray allColor:(UIColor *)allColor;

+ (NSMutableAttributedString *)creatFlagWithContent:(NSString *)content titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor textAlignment:(NSTextAlignment)textAlignment flagContent:(NSString *)flagContent flagFont:(UIFont *)flagFont flagSize:(CGSize)flagSize flagInset:(UIEdgeInsets)flagInset numbLines:(NSInteger)numbLines;
@end
