//
//  JHGOrderInpuPasswordView.h
//  HTPlace
//
//  Created by hong on 2019/12/5.
//  Copyright © 2019 HZY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTFickleButton.h"
#import "JHGOrderInpuPasswordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JHGOrderInpuPasswordViewCell : HTCommonCollectionViewCell
/**
 密码点
 */
@property(nonatomic, readwrite, strong)UIView *blackPoint;

/**
 模型
 */
@property(nonatomic, readwrite, strong)JHGOrderInpuPasswordModel *model;

/**
 是否添加过border
 */
@property(nonatomic, readwrite, assign)BOOL hasBorder;


@end

@interface JHGOrderInpuPasswordView : UIView

/**
 输入TF
 */
@property(nonatomic, readwrite, strong)UITextField *inputTF;

/**
 关闭按钮
 */
@property(nonatomic, readwrite, strong)UIButton *closeButton;

/**
 设置按钮
 */
@property(nonatomic, readwrite, strong)HTFickleButton *settingButton;

/**
 标题
 */
@property(nonatomic, readwrite, strong)UILabel *inputTitle;

/**
 提示语
 */
@property(nonatomic, readwrite, strong)UILabel *tips;

/**
 表格
 */
@property(nonatomic, readwrite, strong)HTCommonCollectionView *passworldTable;

/**
 处理密码文本
 */
- (void)disposePasswordText;

/**
 密码长度到了验证
 */
- (void)passworldVerify;
@end

NS_ASSUME_NONNULL_END
