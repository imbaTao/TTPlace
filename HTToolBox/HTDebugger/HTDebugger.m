//
//  HTDebugger.m
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/29.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "HTDebugger.h"

#define ISDEBUGER 0
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
        self.debugVcIndex = 0;
        UIViewController *testVC;
        self.vcNames = @[
                         @"HTDebuggerViewController",
                         @"JHGGroupShoppingOrderSuccessVC",
                         @"JHGHomeViewController",
                         ];
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

@interface  HTDebuggerViewController : UIViewController
@end


@implementation HTDebuggerViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [self injected];
}


- (void)injected
{

    
}



@end
