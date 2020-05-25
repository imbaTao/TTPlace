//
//  UINavigationController+HTUINavigationController.m
//  Jihuigou-Native
//
//  Created by hong on 2019/11/14.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "UINavigationController+HTUINavigationController.h"

@implementation UINavigationController (HTUINavigationController)

- (UIViewController *)childViewControllerForStatusBarStyle {
   return self.visibleViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.visibleViewController;
}
@end
