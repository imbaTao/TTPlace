//
//  HTDebugger.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/29.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTDebugger.h"
#import "HomeViewController.h"

#define ISDEBUGER 1
@interface  HTDebuggerViewController : UIViewController

@end

@interface HTDebugger ()


@end
@implementation HTDebugger
singleM();

- (BOOL)debugerWithKewindow:(UIWindow *)window {
    [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
    
    if (!ISDEBUGER) {
         return false;
    }else {
        // 要调试第几个VC
        self.debugVcIndex = 1;
        
        UIViewController *testVC;
        // 已加入调试队列的vc名字
        self.vcNames = @[
                         @"HTDebuggerViewController",
                         @"HomeViewController",
                         ];
        
        HTCommonTableViewModel *vm = [[HTCommonTableViewModel alloc] init];
        vm.canPullUp = false;
        vm.canPulldown = false;
        testVC = [[HomeViewController alloc] initWithViewModel:vm];
        if (!testVC) {
            testVC =  [[NSClassFromString(self.vcNames[self.debugVcIndex]) alloc] init];
        }
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:testVC];
        [window makeKeyAndVisible];
        window.rootViewController = nav;
        return true;
    }
}

@end



@implementation HTDebuggerViewController
- (void)viewDidLoad {

}

- (void)injected
{
    for (UIView *value in self.view.subviews) {
        [value removeFromSuperview];
    }
    
    self.view.backgroundColor = UIColor.redColor;
    
}
@end
