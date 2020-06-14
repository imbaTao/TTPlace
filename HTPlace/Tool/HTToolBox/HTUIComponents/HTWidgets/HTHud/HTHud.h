//
//  HTHud.h
//  HTPlace
//
//  Created by hong on 2019/12/31.
//  Copyright © 2019 HZY. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN


#define HTLoading [HTHud showLoadingWithView: nil]
#define HTHidden [HTHud removeHUDFromView:nil]

#define HTLoadingOnView(windowOrView) [HTHud showLoadingWithView: windowOrView]
#define HTHiddenOnView(windowOrView) [HTHud removeHUDFromView:windowOrView]

@interface MBProgressHUD (HTHudExtension)

/**
 不可点击的HUD
 */
- (void)isMask;

/**
 变更单个hud隐藏事件
 */
- (void)changeHiddenTimeWithDelayTimeInterval:(NSTimeInterval)interval animate:(BOOL)animate;

@end

@interface HTHud : NSObject

/**
 加载中一个圈圈在那转,默认可点击穿透
 */
+ (MBProgressHUD *)showLoadingWithView:(nullable UIView *)showView;

/**
 展示消息
 */
+ (MBProgressHUD *)showMesseage:(NSString *)message showView:(nullable UIView *)showView;

/**
 成功
 */
+ (MBProgressHUD *)showSuccess:(NSString *)message showView:(nullable UIView *)showView;

// 提示白色面板成功
+ (MBProgressHUD *)showWhiteSuccess:(NSString *)message showView:(nullable UIView *)showView;

// 提示失败
+ (MBProgressHUD *)showError:(NSString *)message showView:(nullable UIView *)showView;

/**
 移除hud
 */
+ (void)removeHUDFromView:(nullable UIView *)showView;
@end

NS_ASSUME_NONNULL_END
