//
//  UIViewController+HTViewController.m
//  Jihuigou-Native
//
//  Created by hong on 2019/11/12.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "UIViewController+HTViewController.h"
#import "UINavigationBar+HTNavigationBar.h"
@implementation UIViewController (HTViewController)

// 方法
- (void)setupUI{
    
}

- (void)confingNavigationBarBackGroundWithImgName:(NSString *)imgName {
    if (imgName.length) {
        UIImage *backGroundImage = [UIImage imageNamed:imgName];
        backGroundImage = [backGroundImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
        [self.navigationController.navigationBar setBackgroundColor:UIColor.clearColor];
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarMetrics:UIBarMetricsDefault];
    }else {
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)banNavigationBarBaseLine {
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
@end
