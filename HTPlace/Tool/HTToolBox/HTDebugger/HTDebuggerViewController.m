//
//  HTDebuggerViewController.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/1.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HTDebuggerViewController.h"
#import "HTDebuggerView.h"


@interface HTDebuggerViewController ()


@end

@implementation HTDebuggerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
#if DEBUG
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(hotReload) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
#endif
}


- (void)hotReload {
    [self removeAllViews:self.view];
    [self viewDidLoad];
}


- (void)removeAllViews:(UIView *)view {
    while (view.subviews.count) {
        UIView* child = view.subviews.lastObject;
        [child removeFromSuperview];
    }
}






@end
