//
//  GCUserInfoCardView.h
//  HTPlace
//
//  Created by Mr.hong on 2020/9/14.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol GCUserInfoCardViewDelegate <NSObject>



/**
 头像点击事件
 */
- (void)userIconClickAction;

/**
 举报按钮点击事件
 */
- (void)reportAction;


/**
 按钮点击事件
 */
- (void)bottomButtonAction:(UIButton *)sender;

@end

@interface GCUserInfoCardView : UIControl

/**
 delegate
 */
@property(nonatomic,weak)id <GCUserInfoCardViewDelegate>delegate;

/**
 背板
 */
@property(nonatomic, readwrite, strong)UIView *whiteBoard;

/**
 用户头像icon
 */
@property(nonatomic, readwrite, strong)UIImageView *userIcon;

/**
 举报按钮
 */
@property(nonatomic, readwrite, strong)UIButton *reportButton;

/**
 热趣号
 */
@property(nonatomic, readwrite, strong)UILabel *requIdNumber;

/**
 标签tag承载面板
 */
@property(nonatomic, readwrite, strong)UIView *tagBard;


/**
 魅力值数值面板
 */
@property(nonatomic, readwrite, strong)UIView *textBoard;


/**
 分割线
 */
@property(nonatomic, readwrite, strong)UIView  *sgLine;


/**
 底下按钮承载面吧
 */
@property(nonatomic, readwrite, strong)UIView *bottomButtonBoard;

// 显示
-(void)show;

// 隐藏
-(void)hidde;




@end

NS_ASSUME_NONNULL_END
