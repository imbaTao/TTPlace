//
//  NSAttributedString+Colorful.m
//  HTToolBox
//
//  Created by hong  on 2018/9/3.
//  Copyright © 2018年 HT. All rights reserved.
//

#import "NSAttributedString+Colorful.h"

@implementation NSAttributedString (Colorful)
+ (instancetype)colorFulStringWithString:(NSString *)string  beginIndex:(NSInteger)beginIndex lengthArray:(NSArray *)lengthArray colorArray:(NSArray *)colorArray allColor:(UIColor *)allColor {
    if (lengthArray.count != colorArray.count || !lengthArray.count || !colorArray.count) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"渲染段落数必须跟颜色段落数相等" userInfo:nil];
        return nil;
    }
    NSMutableAttributedString *colorString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",string]];
    
    if (allColor) {
        [colorString addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0,colorString.length)];
    }

    for (int i = 0; i < lengthArray.count; i++) {
        long strLength = [lengthArray[i] integerValue];
         [colorString addAttribute:NSForegroundColorAttributeName value:colorArray[i] range:NSMakeRange(beginIndex,strLength)];
        beginIndex += strLength;
    }
    return colorString;
}


+ (instancetype)colorFulStringWithString:(NSString *)string  indexArray:(NSArray *)indexArray lengthArray:(NSArray *)lengthArray colorArray:(NSArray *)colorArray allColor:(UIColor *)allColor {
    if (lengthArray.count != colorArray.count || !lengthArray.count || !colorArray.count || !indexArray.count || !colorArray.count) {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"渲染段落数必须跟颜色段落数相等" userInfo:nil];
        return nil;
    }
    NSMutableAttributedString *colorString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",string]];
    
    if (allColor) {
        [colorString addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0,colorString.length)];
    }
    
    for (int i = 0; i < lengthArray.count; i++) {
        NSInteger index = [indexArray[i] integerValue];
        long strLength = [lengthArray[i] integerValue];
        [colorString addAttribute:NSForegroundColorAttributeName value:colorArray[i] range:NSMakeRange(index,strLength)];
    }
    return colorString;
}
@end
