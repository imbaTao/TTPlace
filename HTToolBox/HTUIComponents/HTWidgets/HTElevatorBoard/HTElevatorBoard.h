//
//  HTElevatorBoard.h
//  Jihuigou-Native
//
//  Created by hong on 2019/11/26.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


// 升降板类型
typedef NS_OPTIONS(NSInteger, HTElevatorBoardType) {
    HTElevatorBoardTypeTop = 1, // 顶部
    HTElevatorBoardTypeBottom,// 底部
};

@interface HTElevatorBoard <__covariant T: UIView *>: UIView


/**
 类型
 */
@property(nonatomic, readwrite, assign)HTElevatorBoardType type;


/**
 是否在显示
 */
@property(nonatomic, readwrite, assign)BOOL isShowing;



/**
 类型
 */
@property(nonatomic, readwrite, assign)NSTimeInterval duration;

/**
 内容板子
 */
@property(nonatomic, readwrite, strong)T v;

/**
 @param size 内容面板尺寸
*/
- (instancetype)initWithSize:(CGSize)size vClass:(nullable Class)vClass;

/**
 是否添加到window上
 */
- (instancetype)initWithSize:(CGSize)size vClass:(Class)vClass onWindow:(BOOL)onWindow;


/**
 @param size 内容面板尺寸
 @param subview 子视图
*/
- (instancetype)initWithSize:(CGSize)size subView:(UIView *)subview;

/**
  @param view 内容面板
  @param size 内容面板尺寸
 */
- (instancetype)initWithContentView:(UIView *)view size:(CGSize)size;

/**
 @param size 内容面板尺寸
 @param onWindow 是否在window上
 @param topInterval 顶部的距离
 */
- (instancetype)initWithSize:(CGSize)size vClass:(Class)vClass onWindow:(BOOL)onWindow topInterval:(CGFloat)topInterval;
/**
 初始化背景色
 */
- (instancetype)initWithBackGroundColor:(UIColor *)color content:(T)content;

/**
 展示内容板
 */
- (void)showBoard:(nullable void (^)(void))complete;

/**
 降内容板
 */
- (void)hiddenBoard:(nullable void (^)(void))complete;


/**
 变更子视图高度
 */
- (void)changeSubViewHeight:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
