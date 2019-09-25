//
//  VipHeadInfoView.h
//  HTToolBox
//
//  Created by Mr.hong on 2019/7/25.
//  Copyright © 2019 HT. All rights reserved.
//

#import "HTLabel.h"

NS_ASSUME_NONNULL_BEGIN
@interface VipHeadInfoView : UIView

/**
 头像视图
 */
@property(nonatomic, readwrite, strong)UIImageView *headIcon;

/**
 昵称
 */
@property(nonatomic, readwrite, strong)UILabel *nickName;

/**
 开通状态
 */
@property(nonatomic, readwrite, strong)HTLabel *vipStatus;

/**
 提示说明
 */
@property(nonatomic, readwrite, strong)UILabel *tips;

/**
 贴在右侧的vip信息，显示身份和天数等信息
 */
@property(nonatomic, readwrite, strong)HTLabel *vipInfo;

/**
 vip图片
 */
@property(nonatomic, readwrite, strong)UIImageView *vipLogo;


@end

NS_ASSUME_NONNULL_END
