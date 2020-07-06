//
//  YNFormLocationDetailCell.h
//  HTPlace
//
//  Created by Mr.hong on 2020/6/27.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HTCommonTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface YNFormLocationDetailCell : HTCommonTableViewCell

/**
 内容
 */
@property(nonatomic, readwrite, strong)UILabel *contentLabel;

/**
 分割线
 */
@property(nonatomic, readwrite, strong)UIView *segementLine;

@end

NS_ASSUME_NONNULL_END
