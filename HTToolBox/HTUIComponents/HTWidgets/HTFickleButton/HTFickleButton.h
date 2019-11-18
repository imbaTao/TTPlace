//
//  HTFickleButton.h
//  Jihuigou-Native
//
//  Created by hong on 2019/11/11.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTFickleButton : UIButton

/**
 创建一个水平排列可以旋转图标的按钮
 */
-(instancetype)initWithHorizontalRotationButtonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)color selectedColor:(UIColor *)selectedColor imgs:(NSArray <NSString *>*)imgs angle:(CGFloat)angle;

/**
 变更标题
 */
- (void)changeNewTitle:(NSString *)newValue;

@end

NS_ASSUME_NONNULL_END
