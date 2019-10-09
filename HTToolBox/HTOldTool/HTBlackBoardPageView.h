//
//  HTBlackBoardPageView.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/11.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTBlackBoardPageView : UIButton

/**
 传进来的subView
 */
@property(nonatomic, readwrite, strong)UIView *cusSubView;

- (void)showOrhideBoard;

- (instancetype)initWithFrame:(CGRect)frame __attribute__ ((unavailable("请使用下面的初始化方法")));

@end

NS_ASSUME_NONNULL_END
