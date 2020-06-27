//
//  HTHud.h
//  HTPlace
//
//  Created by hong on 2019/12/31.
//  Copyright © 2019 HZY. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

#define HTLoadingOnView(windowOrView) [HTHud showLoadingWithView: windowOrView]
#define HTHiddenOnView(windowOrView) [HTHud removeHUDFromView:windowOrView]

//加载中
#define HTLoading dispatch_async(dispatch_get_main_queue(), ^{\
 [HTHud showLoadingWithView:nil];\
})\
//仅显示文字
#define HTShowHint(hint) dispatch_async(dispatch_get_main_queue(), ^{\
 [HTHud showMesseage:hint showView:nil];\
})\
//显示成功
#define HTShowSuccess(hint) dispatch_async(dispatch_get_main_queue(), ^{\
 [HTHud showSuccess:hint showView:nil];\
})\
//显示失败
#define HTShowError(hint) dispatch_async(dispatch_get_main_queue(), ^{\
 [HTHud showError:hint showView:nil];\
})\

//展示白色图片+文字
#define HTShowWhiteHud(hint) dispatch_async(dispatch_get_main_queue(), ^{\
  [HTHud showWhiteSuccess:hint showView:nil];\
})\

//取消加载
#define HTHiddenLodding dispatch_async(dispatch_get_main_queue(), ^{\
 [HTHud removeHUDFromView:nil];\
})\




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
