//
//  HTHud.m
//  HTPlace
//
//  Created by hong on 2019/12/31.
//  Copyright © 2019 HZY. All rights reserved.
//

#import "HTHud.h"
#import "HTSVIndefiniteAnimatedView.h"

#define KEYWINDOW [UIApplication sharedApplication].keyWindow



@implementation MBProgressHUD (HTHudExtension)

- (void)isMask {
    self.userInteractionEnabled = true;
}

- (void)changeHiddenTimeWithDelayTimeInterval:(NSTimeInterval)interval animate:(BOOL)animate{
    // 先取消之前的默认两秒的隐藏事件
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideAnimated:afterDelay:) object:nil];
    [self hideAnimated:animate afterDelay:interval];
}

@end

@implementation HTHud

// 从svg扣下来的转圈圈
+ (MBProgressHUD *)showLoadingWithView:(UIView *)showView {
    MBProgressHUD *hud = [self creatHUDWithView:showView];
    HTSVIndefiniteAnimatedView *circleView =   [[HTSVIndefiniteAnimatedView alloc] init];
    circleView.frame = CGRectMake(-30, -30, 60, 60);
    circleView.radius = 18; //24
    circleView.strokeThickness = 2;
    circleView.strokeColor = UIColor.whiteColor;
    hud.mode = MBProgressHUDModeCustomView;
    
    //  hud.label.text = @"12312";
    //  hud.bezelView.color = [UIColor redColor];
    //  hud.margin = 110;
    
    [hud setMinSize:CGSizeMake(60, 60)];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    imgV.backgroundColor = [UIColor redColor];
    [imgV addSubview:circleView];
    [hud setCustomView:imgV];
    [hud showAnimated:true];
    return hud;
}

// 仅仅提示文字
+ (MBProgressHUD *)showMesseage:(NSString *)message showView:(UIView *)showView {
    MBProgressHUD *hud = [self creatHUDWithView:showView];
    
    /// UIActivityIndicatorView.
//    MBProgressHUDModeIndeterminate,
//    /// A round, pie-chart like, progress view.
//    MBProgressHUDModeDeterminate,
//    /// Horizontal progress bar.
//    MBProgressHUDModeDeterminateHorizontalBar,
//    /// Ring-shaped progress view.
//    MBProgressHUDModeAnnularDeterminate,
//    /// Shows a custom view.
//    MBProgressHUDModeCustomView,
//    /// Shows only labels.
//    MBProgressHUDModeText
    
    
    hud.mode = MBProgressHUDModeText;
    hud.label.textColor = [UIColor whiteColor];
    hud.label.numberOfLines = 0;
    hud.label.text = message;
    return hud;
}

// 初始化一个HUD,默认可点击，黑色背板
+ (MBProgressHUD *)creatHUDWithView:(UIView *)showView {
    if (!showView) {
        showView = KEYWINDOW;
    }
    
    // 先做移除操作
    [self removeHUDFromView:showView];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:showView animated:YES];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.userInteractionEnabled = false;
    [hud hideAnimated:true afterDelay:2.0];
    return hud;
}




// 移除HUD
+ (void)removeHUDFromView:(UIView *)showView{
    if (!showView) {
        showView = KEYWINDOW;
    }
    bool result = [MBProgressHUD hideHUDForView:showView animated:true];
    if (result) {
        // 成功移除
    }else {
        // 没找到
    }
}

@end


