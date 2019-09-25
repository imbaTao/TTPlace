//
//  HTLabel.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/6/17.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTLabel : UILabel

- (instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("请使用下面的初始化方法")));

-(instancetype)initWithFrame:(CGRect)frame edges:(UIEdgeInsets)edges;

- (instancetype)initWithedges:(UIEdgeInsets)edges customFont:(UIFont *)font textColor:(UIColor *)textColor backGroundColor:(UIColor *)backGroundColor textAlignment:(NSTextAlignment)alignment placeholder:(NSString *)placeholder;
@end

NS_ASSUME_NONNULL_END
