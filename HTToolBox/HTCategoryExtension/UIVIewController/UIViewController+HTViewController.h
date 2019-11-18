//
//  UIViewController+HTViewController.h
//  Jihuigou-Native
//
//  Created by hong on 2019/11/12.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HTViewController)

/**
 设置导航栏背景图
 */
- (void)confingNavigationBarBackGroundWithImgName:(nullable NSString *)imgName;

/**
 禁止导航栏底部的线
 */
- (void)banNavigationBarBaseLine;
@end

NS_ASSUME_NONNULL_END
