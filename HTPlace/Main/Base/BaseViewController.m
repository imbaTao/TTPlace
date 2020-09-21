//
//  BaseViewController.m
//  HTPlace
//
//  Created by Mr.hong on 2020/9/21.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "BaseViewController.h"
//#import <UINavigationController+FDFullscreenPopGesture.h>

@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.fd_prefersNavigationBarHidden = NO;
        self.hidesBottomBarWhenPushed = true;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;

    [self configNavigationBar];
}


// 设置导航栏
- (void)configNavigationBar {
    [UINavigationBar appearance].backIndicatorImage = [UIImage imageNamed:@"back1"];
    UIBarButtonItem *item = [UIBarButtonItem qmui_backItemWithTitle:@"    " target:self action:@selector(handleBackButtonEvent:)];
    item.customView.tintColor = [UIColor blackColor];
   self.navigationItem.leftBarButtonItem = item;
   self.navigationItem.rightBarButtonItems = nil;

}

- (void)handleBackButtonEvent:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)forceEnableInteractivePopGestureRecognizer {
    return true;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    if (self.contentOffset.x <= 0) {
//        if ([otherGestureRecognizer.delegate isKindOfClass:NSClassFromString(@"_FDFullscreenPopGestureRecognizerDelegate")]) {
//            return YES;
//        }
//    }
//    return NO;
//}

@end
