//
//  YNFormTableViewCell.h
//  HTPlace
//
//  Created by Mr.hong on 2020/6/25.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HTCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface YNFormTableViewCell : HTCommonTableViewCell
/**
作为一个基类,把里面的控件都使用懒加载，需要的子类触发懒加载
*/

/**
 标题
 */
@property(nonatomic, readwrite, strong)UILabel *titleLable;

/**
 内容textField
 */
@property(nonatomic, readwrite, strong)UITextField *inputTextFiled;

/**
 分割线
 */
@property(nonatomic, readwrite, strong)UIView *segementLine;

/**
 内容textFiled上的透明事件按钮用来拦截内容编辑事件，进行跳转用
 */
@property(nonatomic, readwrite, strong)UIButton *eventButton;

/**
 右侧箭头
 */
@property(nonatomic, readwrite, strong)UIImageView *rightImageView;


@end

NS_ASSUME_NONNULL_END
