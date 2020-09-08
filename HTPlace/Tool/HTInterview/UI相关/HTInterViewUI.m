//
//  HTInterViewUI.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/1.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HTInterViewUI.h"



@implementation HTInterViewUI



/**
 总结
 
 主要包含,ios ui的绘制原理，UIView的构成，离屏渲染的原因,事件传递流程,事件响应流程
 */

#pragma mark - UIView的构成
// 主要由CALayer和UIView共同组成，UIView负责事件的响应和处理，layer负责内容contens的显示，体现了单一职责原则

#pragma mark - 点击事件的传递
/**
 主要有两个方法:
 hitTest:(CGPoint)point WithEvent:(UIEvent *)event
 这个方法用来查找判定哪个视图响应了此次点击，以倒叙遍历子视图subviews的方式，最终会通过hitTest得到一个不为nil的视图，就是响应视图，如何为nil，那就没有视图响应,UIWindow作为本身的响应视图
 
 pointInside方法，判断点击区域是否在点击的范围内，主要用来扩大按钮的点击作用域
 */

#pragma mark - 事件的响应流程
/**
 是由顶部视图自上向下topView -> containerView -> view(ViewController) -> Controller -> keyWindow -> UIApplication -> UIAPPlicationDelegate
 */

#pragma mark - UITableView的复用原理

@end
