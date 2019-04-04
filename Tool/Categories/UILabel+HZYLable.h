//
//  UILabel+HZYLable.h
//  ChingoItemZDTY
//
//  Created by hong2 on 2019/3/14.
//  Copyright © 2019 洪正烨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (HZYLable)
/**
  初始化一个label
 */
+ (instancetype)size:(CGFloat)size color:(UIColor *)color textAlignment:(NSTextAlignment)alignment placeholder:(NSString *)placeholder;

/**
 计算label高
 */
+ (CGFloat)calculateHeight:(UILabel *)label fatherViewSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
