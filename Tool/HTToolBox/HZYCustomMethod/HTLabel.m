//
//  HTLabel.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/6/17.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTLabel.h"

@interface HTLabel()

// 用来决定上下左右内边距，也可以提供一个借口供外部修改，在这里就先固定写死
@property (assign, nonatomic) UIEdgeInsets edgeInsets;
@end



@implementation HTLabel

- (instancetype)initWithFrame:(CGRect)frame edges:(UIEdgeInsets)edges;
{
    self = [super initWithFrame:frame];
    if (self) {
         self.edgeInsets = edges;
    }
    return self;
}

//下面三个方法用来初始化edgeInsets
- (instancetype)initWithedges:(UIEdgeInsets)edges customFont:(UIFont *)font textColor:(UIColor *)textColor backGroundColor:(UIColor *)backGroundColor textAlignment:(NSTextAlignment)alignment placeholder:(NSString *)placeholder
{
    if(self = [super init])
    {
        self.edgeInsets = edges;
        self.font = font;
        self.textColor = textColor;
        self.backgroundColor = backGroundColor;
        self.textAlignment = alignment;
        self.text = placeholder;
    }
    return self;
}






-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    /*
     调用父类该方法
     注意传入的UIEdgeInsetsInsetRect(bounds, self.edgeInsets),bounds是真正的绘图区域
     */
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds,
                                                                 self.edgeInsets) limitedToNumberOfLines:numberOfLines];
    //根据edgeInsets，修改绘制文字的bounds
    rect.origin.x -= self.edgeInsets.left;
    rect.origin.y -= self.edgeInsets.top;
    rect.size.width += self.edgeInsets.left + self.edgeInsets.right;
    rect.size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return rect;
}

//绘制文字
- (void)drawTextInRect:(CGRect)rect
{
    //令绘制区域为原始区域，增加的内边距区域不绘制
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}
@end
