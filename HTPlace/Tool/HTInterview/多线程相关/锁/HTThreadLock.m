//
//  HTThreadLock.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/2.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HTThreadLock.h"

@implementation HTThreadLock
/**
 @synchronized //创建单例时候用
 atomic // 属性关键字，属性中保证赋值安全
 OSSpinLock // 自旋锁，是一个循环等待的锁，不释放当前资源
 用于轻量级数据访问 如+1 / - 1操作等
 NSLock 对临界区进行加锁处理，保证线程同步，双重加锁会重入，导致死锁
 可以用NSRecursiveLock递归锁进行解决

 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
