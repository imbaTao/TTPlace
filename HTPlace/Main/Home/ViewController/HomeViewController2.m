//
//  HomeViewController2.m
//  HTPlace
//
//  Created by Mr.hong on 2020/9/8.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HomeViewController2.h"
#import "AnimationManager.h"
#import "NavgationAnimationManager.h"


@interface HomeViewController2 ()

//动画过渡转场
@property (nonatomic, strong) AnimationManager * transitionAnimation;

//手势过渡转场
//@property (nonatomic, strong) NavgationAnimationManager * transitionInteractive;
@end

@implementation HomeViewController2


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitionAnimation = [[AnimationManager alloc] init];
           self.transitionAnimation.isPush = true;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我是第二页";
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    
    
    self.tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, SCREEN_W, 200)];
    self.tempLabel.backgroundColor = [UIColor redColor];
    self.tempLabel.text = @"我是第二页";
    [self.view addSubview:self.tempLabel];
    
 
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:true];
}


#pragma mark -- UIViewControllerTransitioningDelegate


//返回处理push/pop动画过渡的对象
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        self.transitionAnimation.isPush = true;
        return self.transitionAnimation;
    }else if (operation == UINavigationControllerOperationPop){
        self.transitionAnimation.isPush = false;
    }
    return self.transitionAnimation;
}

////返回处理push/pop手势过渡的对象 这个代理方法依赖于上方的方法 ，这个代理实际上是根据交互百分比来控制上方的动画过程百分比
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{

    //手势开始的时候才需要传入手势过渡代理，如果直接pop或push，应该返回nil，否者无法正常完成pop/push动作
//    if ( self.transitionAnimation.transitionType == WSLTransitionFourTypePop) {
//        return self.transitionInteractive.isInteractive == YES ? self.transitionInteractive : nil;
//    }
    return nil;
}


- (void)viewDidDisappear:(BOOL)animated{
    self.navigationController.delegate = nil;
}
@end
