//
//  UIView+HTUIViewTool.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/6/18.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HTUIViewTool)
/**
 设置圆角
 @param radius 圆角大小
 */
- (void)settingCornerRadius:(CGFloat)radius maskToBounds:(BOOL)maskToBounds;

/**
 设置圆角默认是maskToBounds是true
 */
- (void)settingCornerRadius:(CGFloat)radius;

/**
 设置阴影
 @param sr 圆角大小
 @param offset 阴影偏移
 @param color 颜色
 @param opacity 不透明度
 */
- (void)settingShadowWithShadowRadius:(CGFloat)sr offset:(CGSize)offset color:(UIColor *)color opacity:(CGFloat)opacity;

/**
 设置渐变色图层
 @param rect 大小
 @param colors 渐变色值数组
 @param cornerRadius 圆角大小
 */
- (CAGradientLayer *)settingGradientLayerWithRect:(CGRect)rect colors:(NSArray *)colors cornerRadius:(CGFloat)cornerRadius;

/**
 设置渐变色图层
 @param rect 大小
 @param colors 渐变色值数组
 @param cornerRadius 圆角大小
 @param startPoint 起始点
 @param endPoint 终止点
 */
- (CAGradientLayer *)settingGradientLayerWithRect:(CGRect)rect colors:(NSArray *)colors cornerRadius:(CGFloat)cornerRadius startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 二者都设置
 */
- (CAGradientLayer *)settingGrandientAndShadowWithOffset:(CGSize)of shadowColor:(UIColor *)c opacity:(CGFloat)op rect:(CGRect)rect colors:(NSArray *)colors cornerRadius:(CGFloat)cornerRadius shadowRadius:(CGFloat)sr;

/**
 找到当前视图的控制器
 */
- (nullable UINavigationController *)findBelongNavigationControllerForView:(UIView *)view;

/**
 设置特定角的圆角
 */
- (void)setCornerWithByRoundingCorners:(UIRectCorner)corners radius:(CGFloat)radius;

/**
 设置通用面板的圆角和阴影
 */
- (void)setCommonBoardRadiusAndShadow;
@end

NS_ASSUME_NONNULL_END
