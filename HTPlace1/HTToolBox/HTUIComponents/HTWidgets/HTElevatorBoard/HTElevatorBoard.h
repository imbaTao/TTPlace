//
//  HTElevatorBoard.h
//  Jihuigou-Native
//
//  Created by hong on 2019/11/26.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTElevatorBoard <__covariant T: UIView *>: UIView



/**
 动画市场
 */
@property(nonatomic, readwrite, assign)NSTimeInterval duration;


/**
  思路
 1.背板蒙版,点击蒙版收起内容版，隐藏自身
 2.内容板,外部传进来需要升降的,要固定起始位置
 */

/**
 内容板子
 */
@property(nonatomic, readwrite, strong)T v;

/**
 @param size 内容面板尺寸
*/
- (instancetype)initWithSize:(CGSize)size vClass:(Class)vClass;

/**
  @param view 内容面板
  @param size 内容面板尺寸
 */
- (instancetype)initWithContentView:(UIView *)view size:(CGSize)size;

/**
 初始化背景色
 */
- (instancetype)initWithBackGroundColor:(UIColor *)color content:(T)content;



/**
 展示内容板
 */
- (void)showBoard;

/**
 降内容板
 */
- (void)hideBoard;

@end

NS_ASSUME_NONNULL_END
