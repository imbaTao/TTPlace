//
//  YNPubulishProgressView.h
//  HTPlace
//
//  Created by Mr.hong on 2020/9/17.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YNPubulishProgressView : UIView

/**
 @value 传进来进度比100%
 */
- (void)showProgerss:(CGFloat)value;


/**
 根据icon初始化
 */
- (instancetype)initWithIcon:(UIImage *)icon;
@end

NS_ASSUME_NONNULL_END
