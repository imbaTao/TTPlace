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
 content
 */
@property(nonatomic, readwrite, strong)UILabel *content;

/**
 icon
 */
@property(nonatomic, readwrite, strong)UIImageView *icon;

/**
 icon数组
 */
@property(nonatomic, readwrite, copy)NSArray *imgs;

/**
 颜色
 */
@property(nonatomic, readwrite, copy)NSArray <UIColor *>*colors;

/**
 角度
 */
@property(nonatomic, readwrite, assign)CGFloat angle;



/**
 创建一个水平排列的普通按钮
 */
-(instancetype)initWithHorizontalRotationButtonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)color imgName:(NSString *)imgName;


/**
 创建一个水平排列的普通按钮 图片在左侧还是右侧
 */
-(instancetype)initWithHorizontalRotationButtonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)color imgName:(NSString *)imgName position:(NSInteger)position;


/**
 创建一个水平排列可以旋转图标的按钮
 */
-(instancetype)initWithHorizontalRotationButtonWithTitle:(NSString *)title font:(UIFont *)font normalColor:(UIColor *)color selectedColor:(UIColor *)selectedColor imgs:(nonnull NSArray <NSString *>*)imgs angle:(CGFloat)angle;

/**
 变更标题
 */
- (void)changeNewTitle:(NSString *)newValue;

/**
 重置按钮的状态，图片旋转
 */
- (void)revertButtonStatus;

@end

NS_ASSUME_NONNULL_END
