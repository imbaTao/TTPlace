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




// 创建一个头标签
+ (NSMutableAttributedString *)creatFlagWithContent:(NSString *)content titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor textAlignment:(NSTextAlignment)textAlignment flagContent:(NSString *)flagContent flagFont:(UIFont *)flagFont flagSize:(CGSize)flagSize flagInset:(UIEdgeInsets)flagInset numbLines:(NSInteger)numbLines {
    if (!content.length) {
        content = @" ";
    }else {
        content = [NSString stringWithFormat:@"%@",content];
    }
    
    // 如果有标签内容，那么插入标签
    if (flagContent.length > 0) {
        
        // 段落风格
       NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
       
       // 遵循原来的对齐方式
       paragraphStyle.alignment = textAlignment;
        
        // 富文本内容
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
        
        // 插入flag标签
        UILabel *flagLabel  = [[UILabel alloc] init];
        flagLabel.font = flagFont;
        flagLabel.textColor = [UIColor whiteColor];
        flagLabel.backgroundColor = rgba(222, 49, 33, 1);
        flagLabel.layer.cornerRadius = flagSize.height * 0.5;
        flagLabel.layer.masksToBounds = true;
        flagLabel.frame = CGRectMake(0, 0, flagSize.width, flagSize.height);
        flagLabel.textAlignment = NSTextAlignmentCenter;
        flagLabel.text = flagContent;
        flagLabel.textColor = UIColor.whiteColor;
     
        
//        // 间距块
//        UILabel *emptyLabel  = [[UILabel alloc] init];
//        emptyLabel.text = @" ";
//        emptyLabel.frame = CGRectMake(0, 0, 6, flagSize.height);
//        NSMutableAttributedString *attchText1 = [NSMutableAttributedString   attachmentStringWithContent:flagLabel contentMode:UIViewContentModeScaleAspectFit attachmentSize:flagLabel.frame.size alignToFont:titleFont alignment:YYTextVerticalAlignmentCenter];
//        
//        NSMutableAttributedString *attchText2 = [NSMutableAttributedString   attachmentStringWithContent:emptyLabel contentMode:UIViewContentModeScaleAspectFit attachmentSize:emptyLabel.frame.size alignToFont:titleFont alignment:YYTextVerticalAlignmentCenter];
//        
//        [attr insertAttributedString:attchText1 atIndex:0];
//        [attr insertAttributedString:attchText2 atIndex:1];
        
        [attr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attr.length)];
        return  attr;
    }
    return [[NSMutableAttributedString alloc] initWithString:content];
}
@end
