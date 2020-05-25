//
//  UIFont+HTFont.h
//  ChingoItemZDTY
//
//  Created by hong2 on 2019/3/7.
//  Copyright © 2019 HSKY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIFont (HTFont)
/**
 常规体
 */
+ (instancetype)fontSize:(CGFloat)size;
+ (instancetype)fontSize:(CGFloat)size name:(NSString *)name;

/**
 粗体
 */
+ (instancetype)boldFontSize:(CGFloat)size;

/**
 中规体
 */
+ (instancetype)mediumFontSize:(CGFloat)size;


/**
 特粗体
 */
+ (instancetype)heavyFontSize:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
