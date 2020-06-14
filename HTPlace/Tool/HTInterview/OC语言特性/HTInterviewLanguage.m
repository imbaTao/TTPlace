//
//  HTInterviewLanguage.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/2.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HTInterviewLanguage.h"

@implementation HTInterviewLanguage


// 动态方法决议
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return [super resolveInstanceMethod:sel];
}


- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
}

@end
