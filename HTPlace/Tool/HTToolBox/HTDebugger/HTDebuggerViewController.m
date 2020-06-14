//
//  HTDebuggerViewController.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/1.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HTDebuggerViewController.h"
#import "HTInterviewNSThread.h"
#import "HTDebuggerView.h"

@interface HTDebuggerViewController ()
@property (weak, nonatomic) IBOutlet HTDebuggerView *debugerView;

/**
 HTInterviewNSThread *threadObj
 */
@property(nonatomic, readwrite, strong)HTInterviewNSThread *threadObj;

@end

@implementation HTDebuggerViewController

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [super allocWithZone:zone];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.debugerView = [[[NSBundle mainBundle] loadNibNamed:@"HTDebuggerView" owner:nil options:nil] lastObject];
    [self.view addSubview:self.debugerView];
    [self.debugerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.debugerView test];
    
  

    
    
    self.threadObj = [[HTInterviewNSThread alloc] init];
    
    
//#if DEBUG
//    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(hotReload) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
//#endif
}



//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"我是debugger控制器,点击开始了");
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"我是debugger控制器,点击移除了");
//}
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"我是debugger控制器,点击结束了");
//}


//- (void)hotReload {
//    [self removeAllViews:self.view];
//    [self viewDidLoad];
//}
//
//- (void)removeAllViews:(UIView *)view {
//    while (view.subviews.count) {
//        UIView* child = view.subviews.lastObject;
//        [child removeFromSuperview];
//    }
//}

@end
