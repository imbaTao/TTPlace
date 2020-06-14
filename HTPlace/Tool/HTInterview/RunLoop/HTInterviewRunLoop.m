//
//  HTInterviewRunLoop.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/2.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HTInterviewRunLoop.h"


@implementation HTInterviewRunLoop

/**
 是通过维护内部事件循环来对事件/消息进行管理的一个对象
 没有消息需要处理时，由用户态转换到内核态进行休眠
 有消息需要处理时，由内核态转换到用户态
 */


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
