//
//  AnimationManager.m
//  HTPlace
//
//  Created by Mr.hong on 2020/9/8.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "AnimationManager.h"
#import "HomeViewController.h"
#import "HomeViewController2.h"

@implementation AnimationManager



//返回动画事件
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}


//所有的过渡动画事务都在这个方法里面完成
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
//    switch (_transitionType) {
//        case WSLTransitionFourTypePresent:
//            [self presentAnimation:transitionContext];
//            break;
//        case WSLTransitionFourTypeDissmiss:
//            [self dismissAnimation:transitionContext];
//            break;
//        case WSLTransitionFourTypePush:
//            [self pushAnimation:transitionContext];
//            break;
//        case WSLTransitionFourTypePop:
//            [self popAnimation:transitionContext];
//            break;
//    }
    
    if (self.isPush) {
        [self pushAnimation:transitionContext];
    }else {
        [self popAnimation:transitionContext];
    }
       
}


- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    HomeViewController * fromVC = (HomeViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
     HomeViewController2 * toVC = (HomeViewController2 *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    toVC.tempLabel.hidden = true;
    
    
    //取出转场前后视图控制器上的视图view
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
    
    
//    //左侧动画视图
//    UIView *leftFromView = [fromView snapshotViewAfterScreenUpdates:NO];
//    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fromView.frame.size.width/2, fromView.frame.size.height)];
//    leftView.clipsToBounds = YES;
//    [leftView addSubview:leftFromView];
//
//
//    //右侧动画视图
//    UIView *rightFromView = [fromView snapshotViewAfterScreenUpdates:NO];
    
//    rightFromView.frame = CGRectMake(- fromView.frame.size.width/2, 0, fromView.frame.size.width, fromView.frame.size.height);
//    UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(fromView.frame.size.width/2, 0, fromView.frame.size.width/2, fromView.frame.size.height)];
//    rightView.clipsToBounds = YES;
//    [rightView addSubview:rightFromView];
//
    
    
    NSLog(@"%@",fromVC.title);
    
    // 遍历图
    UIView *lableScreenShoot = [fromVC.tempLabel snapshotViewAfterScreenUpdates:NO];
    
//    for (UIView *subView in fromVC.view.subviews) {
//        if ([subView isKindOfClass:[UILabel class]]) {
////            lable = subView;
//            lable = [subView snapshotViewAfterScreenUpdates:NO];
////            lable.text = @"我是第二页";
//            break;
//        }
//    }
    
    
//  toView.frame = CGRectMake(SCREEN_W, 0, SCREEN_W, SCREEN_H);
    toView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    lableScreenShoot.frame = fromVC.tempLabel.frame;
    
    
    [containerView addSubview:toView];
    [containerView addSubview:lableScreenShoot];
//    [containerView addSubview:rightView];
    
    fromView.hidden = YES;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^{
                       
                        lableScreenShoot.frame = CGRectMake(0, 200, SCREEN_W, 200);
                        
//                         leftView.frame = CGRectMake(-fromView.frame.size.width/2, 0, fromView.frame.size.width/2, fromView.frame.size.height);
//                         rightView.frame = CGRectMake(fromView.frame.size.width, 0, fromView.frame.size.width/2, fromView.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         toVC.tempLabel.hidden = false;
                         lableScreenShoot.hidden = true;
//                         [leftView removeFromSuperview];
//                         [rightView removeFromSuperview];
                         [transitionContext completeTransition:YES];
        }];
}


- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //取出转场前后视图控制器上的视图view
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containerView = [transitionContext containerView];
    
//    //左侧动画视图
//    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(-toView.frame.size.width/2, 0, toView.frame.size.width/2, toView.frame.size.height)];
//    leftView.clipsToBounds = YES;
//    [leftView addSubview:toView];
//
//    //右侧动画视图
//    // 使用系统自带的snapshotViewAfterScreenUpdates:方法，参数为YES，代表视图的属性改变渲染完毕后截屏，参数为NO代表立刻将当前状态的视图截图
//    UIView *rightToView = [toView snapshotViewAfterScreenUpdates:YES];
//    rightToView.frame = CGRectMake(-toView.frame.size.width/2, 0, toView.frame.size.width, toView.frame.size.height);
//    UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(toView.frame.size.width, 0, toView.frame.size.width/2, toView.frame.size.height)];
//    rightView.clipsToBounds = YES;
//    [rightView addSubview:rightToView];
//
//    //加入动画视图
//    [containerView addSubview:fromView];
//    [containerView addSubview:leftView];
//    [containerView addSubview:rightView];
//
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^{
//                         leftView.frame = CGRectMake(0, 0, toView.frame.size.width/2, toView.frame.size.height);
//                         rightView.frame = CGRectMake(toView.frame.size.width/2, 0, toView.frame.size.width/2, toView.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         //由于加入了手势交互转场，所以需要根据手势动作是否完成/取消来做操作
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         if([transitionContext transitionWasCancelled]){
                             //手势取消
                         }else{
                             //手势完成
                             [containerView addSubview:toView];
                         }
                         
//                    for (UIView *subView in containerView.subviews) {
//                        [subView removeFromSuperview];
//            //                if ([subView isKindOfClass:[UILabel class]]) {
//            //        //            lable = subView;
//            ////                    lable = [subView snapshotViewAfterScreenUpdates:NO];
//            //        //            lable.text = @"我是第二页";
//            //                    break;
//            //                }
//                        }
            
//                         [leftView removeFromSuperview];
//                         [rightView removeFromSuperview];
                         toView.hidden = NO;
                         
                     }];
}
@end
