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


//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self setupUI];
//    }
//    return self;
//}

//
//+ (void)load {
//#ifdef DEBUG
//    SEL originSelector = @selector(init);
//    SEL swiSelector = @selector(hotReloadInit);
//    Class class = [self class];
//    Method oriMethod = class_getInstanceMethod(class, originSelector);
//    Method swiMethod = class_getInstanceMethod(class, swiSelector);
//
//    BOOL success = class_addMethod(class, originSelector, method_getImplementation(swiMethod), method_getTypeEncoding(swiMethod));
//    if (success) {
//        class_replaceMethod(class, swiSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
//    }else{
//        method_exchangeImplementations(oriMethod, swiMethod);
//    }
//#endif
//}

//- (instancetype)hotReloadInit {
//    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(hotReload) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
//    return [self hotReloadInit];
//}
//
//- (void)hotReload {
//    
//}

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
