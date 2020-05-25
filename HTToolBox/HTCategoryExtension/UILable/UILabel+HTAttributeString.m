//
//  UILabel+HTAttributeString.m
//  HTPlace
//
//  Created by hong on 2020/3/31.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "UILabel+HTAttributeString.h"

@implementation UILabel (HTAttributeString)
- (void)attributeText:(NSString *)text wordSpace:(CGFloat)wordSpace range:(NSRange)range {
    // 获取本身存在的富文本
    NSMutableAttributedString *attributedStr;
//    if (self.attributedText) {
//        attributedStr = [self.attributedText mutableCopy];
//    }else {
        attributedStr = [[NSMutableAttributedString alloc] initWithString:text];
//    }
    
    // 段落风格
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    // 遵循原来的对齐方式
    paragraphStyle.alignment = self.textAlignment;
    
    // 添加富文本属性
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    
    // 添加字间距
    [attributedStr addAttribute:NSKernAttributeName value:@(wordSpace) range:range];
    self.attributedText = attributedStr;
}


+ (void)attributeTextWithLabel:(UILabel *)label text:(NSString *)text wordSpace:(CGFloat)wordSpace range:(NSRange)range {
    // 获取本身存在的富文本
    NSMutableAttributedString *attributedStr;
//    if (self.attributedText) {
//        attributedStr = [self.attributedText mutableCopy];
//    }else {
    attributedStr = [[NSMutableAttributedString alloc] initWithString:text];
//    }
    
    // 段落风格
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    // 遵循原来的对齐方式
    paragraphStyle.alignment = label.textAlignment;
    
    // 添加富文本属性
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    
    // 添加字间距
    [attributedStr addAttribute:NSKernAttributeName value:@(wordSpace) range:range];
    label.attributedText = attributedStr;
}






// 富文本变更字体大小,分底层的字体，和需要修改的部分字体
- (void)attributeText:(NSString *)text baseFont:(UIFont *)baseFont subFont:(UIFont *)font range:(NSRange)range {
    NSMutableAttributedString *attributedStr = [self p_getAttributeStr:text];
    [attributedStr addAttribute:NSFontAttributeName value:baseFont range:NSMakeRange(0, text.length)];
    [attributedStr addAttribute:NSFontAttributeName value:font range:range];
   self.attributedText = attributedStr;
}





// 记录功能用的函数，暂时没用到
- (void)attributeText1:(NSString *)text range:(NSRange)range {
    NSMutableAttributedString *attributedStr = [self p_getAttributeStr:text];
    
    // 段落风格
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = self.textAlignment;
    
    // 添加字间距
    [attributedStr addAttribute:NSKernAttributeName value:@5 range:range];
    
    // 变更字体
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont fontSize:55] range:range];
    
    // 变更字体颜色
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    
    // 段落风格
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    
    // 变更背景颜色
    [attributedStr addAttribute:NSBackgroundColorAttributeName value:[UIColor cyanColor] range:range];
    
    // 字体连体，没0,1,2，NSNumber类型(没看出效果)
//    [attributedStr addAttribute:NSLigatureAttributeName value:@2 range:range];
    
    // 文字画横线
    [attributedStr addAttribute:NSStrikethroughStyleAttributeName value:@5 range:range];
    
    // 画横线颜色
    [attributedStr addAttribute:NSStrikethroughColorAttributeName value:[UIColor greenColor] range:range];
    
    // 文字下划线
    [attributedStr addAttribute:NSUnderlineStyleAttributeName value:@1 range:range];
    
    // 下划线颜色
    [attributedStr addAttribute:NSUnderlineColorAttributeName value:[UIColor grayColor] range:range];
    // 粗体颜色默认跟文本颜色一样
//    [attributedStr addAttribute:NSStrokeColorAttributeName value:[UIColor greenColor] range:range];
    
    // 文字描边
    [attributedStr addAttribute:NSStrokeWidthAttributeName value:@3 range:range];
    
    
    // 文本阴影
    NSShadow *shadow =  [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 3;
    shadow.shadowOffset = CGSizeMake(4, 3);
    [attributedStr addAttribute:NSShadowAttributeName value:shadow range:range];
    
    
    
    // 文本影响 设置文本特殊效果,目前只有图版印刷效果可用 我使用了string崩溃
//    [attributedStr addAttribute:NSTextEffectAttributeName value:@1 range:range];
    
    
    // 附件富文本
//    NSTextAttachment *attachemt = [[NSTextAttachment alloc] init];
//    attachemt.image = [UIImage imageNamed:@"1"];
//    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attachemt];
//    [attributedStr appendAttributedString:imgStr];
    
    
    // 添加点击链接,UILable和textFiled无法使用
//    [attributedStr addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"https:www.baidu.com"] range:range];


    // 底边线的偏移
    [attributedStr addAttribute:NSBaselineOffsetAttributeName value:@1 range:range];
    
    // 文字倾斜
    [attributedStr addAttribute:NSObliquenessAttributeName value:@0.3 range:range];
    
    // 文字膨胀
    [attributedStr addAttribute:NSExpansionAttributeName value:@0.2 range:range];
    
    // 书写方向
//    [attributedStr addAttribute:NSWritingDirectionAttributeName value:@[@(NSWritingDirectionRightToLeft | NSWritingDirectionOverride)] range:range];
    
    self.attributedText = attributedStr;
}




















#pragma mark - private
- (NSMutableAttributedString *)p_getAttributeStr:(NSString *)text {
    // 获取本身存在的富文本
    NSMutableAttributedString *attributedStr;
    
    attributedStr = [self.attributedText mutableCopy];
    
    // 如果内容不对等,那么重新生成
    if (![attributedStr.mutableString isEqualToString:text]) {
         attributedStr = [[NSMutableAttributedString alloc] initWithString:text];
    }
    
    // 段落风格
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    // 遵循原来的对齐方式
    paragraphStyle.alignment = self.textAlignment;
    
    // 添加富文本属性
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];
    return attributedStr;
}


@end
