////
////  AnimationManager.m
////  HTPlace
////
////  Created by Mr.hong on 2020/9/8.
////  Copyright © 2020 Mr.hong. All rights reserved.
////
//
//#import "AnimationManager.h"
//#import "HomeViewController.h"
//#import "HomeViewController2.h"
//
//@implementation AnimationManager
//
//
//
////返回动画事件
//- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
//    return 0.3;
//}
//
//
////所有的过渡动画事务都在这个方法里面完成
//- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//
////    switch (_transitionType) {
////        case WSLTransitionFourTypePresent:
////            [self presentAnimation:transitionContext];
////            break;
////        case WSLTransitionFourTypeDissmiss:
////            [self dismissAnimation:transitionContext];
////            break;
////        case WSLTransitionFourTypePush:
////            [self pushAnimation:transitionContext];
////            break;
////        case WSLTransitionFourTypePop:
////            [self popAnimation:transitionContext];
////            break;
////    }
//
//    if (self.isPush) {
//        [self pushAnimation:transitionContext];
//    }else {
//        [self popAnimation:transitionContext];
//    }
//}
//
//
//
////- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
////    HomeViewController * fromVC = (HomeViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
////     HomeViewController2 * toVC = (HomeViewController2 *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
////    toVC.tempLabel.hidden = true;
////
////
////    //取出转场前后视图控制器上的视图view
////    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
////    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
////
////    UIView *containerView = [transitionContext containerView];
////
////
////    // 遍历图
////    toView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, SCREEN_H);
////    [containerView addSubview:toView];
////    [UIView animateWithDuration:[self transitionDuration:transitionContext]
////                          delay:0
////                        options:UIViewAnimationOptionTransitionFlipFromRight
////                     animations:^{
////                        // 移动到目标位置
////                        toView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
////                     }
////                     completion:^(BOOL finished) {
//////                         toVC.tempLabel.hidden = false;
//////                         lableScreenShoot.hidden = true;
//////                        // 动画完成移除
//////                        [lableScreenShoot removeFromSuperview];
////                        [transitionContext completeTransition:YES];
////        }];
////}
////
////
////- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
////    HomeViewController2 * fromVC = (HomeViewController2 *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
////    HomeViewController * toVC = (HomeViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//////    toVC.tempLabel.hidden = true;
////
////    //取出转场前后视图控制器上的视图view
////      UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
////      UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
////
////      UIView *containerView = [transitionContext containerView];
////    [containerView addSubview:toView];
////    [containerView addSubview:fromView];
////
////    toView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
////    [UIView animateWithDuration:[self transitionDuration:transitionContext]
////                          delay:0
////                        options:UIViewAnimationOptionTransitionFlipFromRight
////                     animations:^{
////                                // 移动到目标位置
////         fromView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, SCREEN_H);
////
////    } completion:^(BOOL finished) {
//////                         //由于加入了手势交互转场，所以需要根据手势动作是否完成/取消来做操作
//////                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//////                         if([transitionContext transitionWasCancelled]){
//////                             //手势取消
//////                         }else{
//////                             //手势完成
//////                             [containerView addSubview:toView];
//////                         }
//////                         toView.hidden = NO;
////
////
//////                toVC.tempLabel.hidden = false;
//////                lableScreenShoot.hidden = true;
//////
//////               // 动画完成移除
//////               [lableScreenShoot removeFromSuperview];
////               [transitionContext completeTransition:YES];
////         }];
////}
//
//
//
//
//- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
//    HomeViewController * fromVC = (HomeViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//     HomeViewController2 * toVC = (HomeViewController2 *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    toVC.tempLabel.hidden = true;
//
//
//    //取出转场前后视图控制器上的视图view
//    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//
//    UIView *containerView = [transitionContext containerView];
//
//
//    // 遍历图
//    UIView *lableScreenShoot = [fromVC.tempLabel snapshotViewAfterScreenUpdates:NO];
//    toView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
//
//
//    lableScreenShoot.frame = fromVC.tempLabel.frame;
//    [containerView addSubview:toView];
//    [containerView addSubview:lableScreenShoot];
//    [UIView animateWithDuration:[self transitionDuration:transitionContext]
//                          delay:0
//                        options:UIViewAnimationOptionTransitionFlipFromRight
//                     animations:^{
//                        // 移动到目标位置
//                        lableScreenShoot.frame = CGRectMake(0, 200, SCREEN_W, 200);
//                     }
//                     completion:^(BOOL finished) {
//                         toVC.tempLabel.hidden = false;
//                         lableScreenShoot.hidden = true;
//                        // 动画完成移除
//                        [lableScreenShoot removeFromSuperview];
//                        [transitionContext completeTransition:YES];
//        }];
//}
//
//
//- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
//    HomeViewController2 * fromVC = (HomeViewController2 *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    HomeViewController * toVC = (HomeViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    toVC.tempLabel.hidden = true;
//
//    //取出转场前后视图控制器上的视图view
//    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
//    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
//
//
//    // 遍历图
//       UIView *lableScreenShoot = [fromVC.tempLabel snapshotViewAfterScreenUpdates:NO];
//    lableScreenShoot.frame = fromVC.tempLabel.frame;
//
//    UIView *containerView = [transitionContext containerView];
//    [containerView addSubview:toView];
//    [containerView addSubview:lableScreenShoot];
//
//
//    fromVC.tempLabel.hidden = true;
//    [UIView animateWithDuration:[self transitionDuration:transitionContext]
//                          delay:0
//                        options:UIViewAnimationOptionTransitionFlipFromRight
//                     animations:^{
//                                // 移动到目标位置
//        lableScreenShoot.frame = CGRectMake(toVC.tempLabel.x, toVC.tempLabel.y +  HTNavigationBarHeight, toVC.tempLabel.width, toVC.tempLabel.height);
//                     }
//
//                     completion:^(BOOL finished) {
////                         //由于加入了手势交互转场，所以需要根据手势动作是否完成/取消来做操作
////                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
////                         if([transitionContext transitionWasCancelled]){
////                             //手势取消
////                         }else{
////                             //手势完成
////                             [containerView addSubview:toView];
////                         }
////                         toView.hidden = NO;
//
//
//                            toVC.tempLabel.hidden = false;
//                            lableScreenShoot.hidden = true;
//
//                           // 动画完成移除
//                           [lableScreenShoot removeFromSuperview];
//                           [transitionContext completeTransition:YES];
//                     }];
//}
//@end
