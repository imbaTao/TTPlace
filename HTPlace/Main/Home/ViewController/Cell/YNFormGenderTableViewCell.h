//
//  YNFormGenderTableViewCell.h
//  HTPlace
//
//  Created by Mr.hong on 2020/6/25.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "YNFormTableViewCell.h"
#import "YNFormTableViewFormModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YNFormGenderTableViewCell : YNFormTableViewCell

/**
 男
 */
@property(nonatomic, readwrite, strong)UIButton *manButton;

/**
 女
 */
@property(nonatomic, readwrite, strong)UIButton *womanButton;


/**
 model
 */
@property(nonatomic, readwrite, strong)YNFormTableViewFormModel *model;

@end

NS_ASSUME_NONNULL_END
