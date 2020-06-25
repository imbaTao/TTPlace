//
//  HTHud.m
//  HTPlace
//
//  Created by hong on 2019/12/31.
//  Copyright © 2019 HZY. All rights reserved.
//

#import "HTHud.h"
#import "HTSVIndefiniteAnimatedView.h"


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
#define HUDCircleWidth 84
#define HUDDefaultShowTime 1.2
#define HUDDefaultShowLongTime 2.0

// 从svg扣下来的转圈圈
+ (MBProgressHUD *)showLoadingWithView:(UIView *)showView {
    MBProgressHUD *hud = [self creatHUDWithView:showView];
    HTSVIndefiniteAnimatedView *circleView =   [[HTSVIndefiniteAnimatedView alloc] init];
    circleView.frame = CGRectMake(-HUDCircleWidth * 0.5, -HUDCircleWidth * 0.5, HUDCircleWidth, HUDCircleWidth);
    circleView.radius = 24; //24
    circleView.strokeThickness = 2;
    circleView.strokeColor = UIColor.whiteColor;
    hud.mode = MBProgressHUDModeCustomView;
    [hud setMinSize:CGSizeMake(HUDCircleWidth, HUDCircleWidth)];
    
    // 需要一个中间图层
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, HUDCircleWidth, HUDCircleWidth)];
    imgV.backgroundColor = [UIColor blackColor];
    [imgV addSubview:circleView];
    [hud setCustomView:imgV];
    [hud showAnimated:true];
    return hud;
}

// 仅仅提示文字
+ (MBProgressHUD *)showMesseage:(NSString *)message showView:(UIView *)showView {
    MBProgressHUD *hud = [self creatHUDWithView:showView];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.numberOfLines = 0;
    hud.detailsLabel.font = [UIFont fontSize:15];
    hud.detailsLabel.text = message;
    hud.margin = 12;
    
    [self p_checkTextWidth:hud showView:showView];
    return hud;
}

// 提示成功
+ (MBProgressHUD *)showSuccess:(NSString *)message showView:(UIView *)showView {
    MBProgressHUD *hud = [self creatHUDWithView:showView];
    UIImage *image = [UIImage imageNamed:@"HTHudSuccess"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    hud.customView = imageView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor whiteColor];
    hud.label.numberOfLines = 0;
    hud.label.font = [UIFont fontSize:15];
    hud.label.text = message;
    hud.bezelView.backgroundColor = rgba(51, 51, 51, 1);
    hud.margin = 13;
    [self p_checkTextWidth:hud showView:showView];
    return hud;
}

// 提示白色成功
+ (MBProgressHUD *)showWhiteSuccess:(NSString *)message showView:(UIView *)showView {
    MBProgressHUD *hud = [self creatHUDWithView:showView];
    UIImage *image = [UIImage imageNamed:@"HTHudSuccess_white"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    hud.customView = imageView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor whiteColor];
    hud.label.numberOfLines = 0;
    hud.label.font = [UIFont fontSize:15];
    hud.label.text = message;
    hud.bezelView.backgroundColor = rgba(51, 51, 51, 1);
    hud.margin = 13;
    
    [self p_checkTextWidth:hud showView:showView];
    return hud;
}

// 提示失败
+ (MBProgressHUD *)showError:(NSString *)message showView:(UIView *)showView {
    MBProgressHUD *hud = [self creatHUDWithView:showView];
    UIImage *image = [UIImage imageNamed:@"HTHudError"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    hud.customView = imageView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor whiteColor];
    hud.label.numberOfLines = 0;
    hud.label.font = [UIFont fontSize:15];
    hud.label.text = message;
    hud.margin = 13;
    [self p_checkTextWidth:hud showView:showView];
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
    [hud hideAnimated:true afterDelay:HUDDefaultShowTime];
    return hud;
}


// 检查文本长度限制一下
+ (void)p_checkTextWidth:(MBProgressHUD *)hud showView:(UIView *)showView {
    UILabel *textLabel;
    if (hud.label.text.length > hud.detailsLabel.text.length) {
        textLabel = hud.label;
    }else {
        textLabel = hud.detailsLabel;
    }
    
    // 计算文本高
    CGFloat textWidth = [textLabel.text sizeForFont:textLabel.font size:CGSizeMake(SCREEN_W, MAXFLOAT) lineBreakMode:textLabel.lineBreakMode].width;
                         
    // 宽度太宽了限制一下
    if (textWidth > SCREEN_W * 0.6) {
        hud.width = SCREEN_W * 0.6 + hud.margin * 2;
        
        // 居中
        hud.x = (SCREEN_W - hud.width + hud.margin) * 0.5;
        [hud hideAnimated:true afterDelay:HUDDefaultShowLongTime];
    }
}

// 移除HUD
+ (void)removeHUDFromView:(UIView *)showView{
    if (!showView) {
        showView = KEYWINDOW;
    }
    bool result = [MBProgressHUD hideHUDForView:showView animated:false];
    if (result) {
        // 成功移除
    }else {
        // 没找到
    }
}

@end


