//
//  UIButton+HTButton.h
//  ChingoItemZDTY
//
//  Created by hong  on 2019/3/6.
//  Copyright © 2019 HSKY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HTButton)

/**
 @param title 标题
 @param selctor 选择器
 @param target 目标
 @param iconName 图标名
 */
+ (instancetype)title:(NSString *)title selector:(SEL)selctor target:(id)target iconName:(NSString *)iconName;

/**
 改变按钮标题
 */
- (void)changeTitle:(NSString *)title;

/**
 @param title 标题
 @param size 标题字体大小
 @param iconName 图标名
 */
+ (instancetype)title:(NSString *)title iconName:(NSString *)iconName fontSize:(CGFloat)size;



/**
 @param title 标题
 @param size 标题字体大小
 */
+ (instancetype)creatByTitle:(NSString *)title titleColor:(UIColor *)titleCorlor fontSize:(CGFloat)size ;


@end

NS_ASSUME_NONNULL_END
