//
//  HTMaskBoard.h
//  HTPlace
//
//  Created by hong on 2019/12/3.
//  Copyright © 2019 HZY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTMaskBoard : UIButton

/**
 子视图
 */
@property(nonatomic, readwrite, strong)UIView *coreSubView;

/**
 是否在显示
 */
@property(nonatomic, readwrite, assign)BOOL showed;


/**
 显示和隐藏
 */
- (void)hideMask;
- (void)showMask;
- (void)destroyMask;

/**
 初始化
 */
- (instancetype)initWithSubiew:(UIView *)subView fatherView:(nullable UIView *)fatherView maskColor:(nullable UIColor *)maskColor touchHide:(BOOL)touchHide animateInterval:(CGFloat)animateInterval;


/**
 变更核心子视图
 */
- (void)changeCoreSubView:(UIView *)coreSubView;
@end

NS_ASSUME_NONNULL_END
