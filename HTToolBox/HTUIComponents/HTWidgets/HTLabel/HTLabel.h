//
//  HTLabel.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/6/17.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTLabel : UILabel

// 用来决定上下左右内边距,也可以提供一个借口供外部修改，在这里就先固定写死
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("请使用下面的初始化方法")));


/**
 
 记得创建布局的时候给一个size，要变化尺寸
 
 创建一个有边距的label
 @param edges 边距
 @param font 字体
 @param textColor 文本颜色
 @param backGroundColor 背景色
 @param text 占位符
 */
- (instancetype)initWithEdges:(UIEdgeInsets)edges font:(UIFont *)font textColor:(UIColor *)textColor backGroundColor:(UIColor *)backGroundColor text:(NSString *)text;




/**
 变更了文本尺寸会调用
 */
- (void)changeSize;
@end

NS_ASSUME_NONNULL_END
