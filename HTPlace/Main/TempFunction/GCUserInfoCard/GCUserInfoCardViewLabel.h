//
//  GCUserInfoCardViewLabel.h
//  HTPlace
//
//  Created by Mr.hong on 2020/9/14.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCUserInfoCardViewLabel : UIView
/**
 主内容
 */
@property(nonatomic, readwrite, strong)UILabel *mainLabel;

/**
 副内容
 */
@property(nonatomic, readwrite, strong)UILabel *subLabel;


@end

NS_ASSUME_NONNULL_END
