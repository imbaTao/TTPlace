//
//  HTDrawerView.h
//  Jihuigou-Native
//
//  Created by hong on 2019/11/11.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTDrawerView : UIView

/**
 展开
 */
- (void)unfold;

/**
 收起
 */
- (void)packUp;

/**
 初始化
 @param sSize 默认的原尺寸
 @param uSize 展开的尺寸
 @param duration 动画时间
 */
- (instancetype)initWithSourceSize:(CGSize)sSize unfloldSize:(CGSize)uSize duration:(CGFloat)duration;

/**
 改变展开的高度
 */
- (void)changeUnflodSize:(CGSize)flodSize;

/**
 展开完成时调用
 */
- (void)unflodComplet;
@end

NS_ASSUME_NONNULL_END
