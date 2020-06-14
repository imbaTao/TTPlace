//
//  UIView+HTView.h
//  Jihuigou-Native
//
//  Created by hong on 2019/11/12.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HTView)

- (void)color:(UIColor *)color;
- (void)whiteColor;
- (void)grayColor;
- (void)redColor;
- (void)yellowColor;




// 初始化布局
- (void)setupLayout:(void(^)(void))layoutBlock;

//指定父视图
- (void)setupLayoutWithSuperView:(UIView *)superView layout:(void(^)(void))layoutBlock;

/**
 添加成员变量视图到父视图上
 */
- (void)addMemberSubViews;


/**
 创建一个带颜色的视图
 */
+ (instancetype)viewWithColor:(UIColor *)color;

/**
 创建一个带颜色的带圆角的视图
 */
+ (instancetype)viewWithColor:(UIColor *)color cornerRadius:(CGFloat)radius;

/**
 根据圆角创建一个白色背板视图
 */
+ (instancetype)viewWithCornerRadius:(CGFloat)radius;
@end

NS_ASSUME_NONNULL_END
