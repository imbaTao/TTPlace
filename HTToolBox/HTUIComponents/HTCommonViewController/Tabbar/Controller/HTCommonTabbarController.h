//
//  HTCommonTabbarController.h
//  Jihuigou-Native
//
//  Created by hong on 2019/12/17.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonTabbarController : UITabBarController

/**
 初始化是否隐藏头部
 @param hidde 默认false
 */
- (instancetype)initWithHiddeNavigationBar:(BOOL)hidde;
@end

NS_ASSUME_NONNULL_END
