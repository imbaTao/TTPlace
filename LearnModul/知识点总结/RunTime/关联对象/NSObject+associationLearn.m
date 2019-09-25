//
//  NSObject+associationLearn.m
//  HTToolBox
//
//  Created by Mr.hong on 2019/5/30.
//  Copyright © 2019 HT. All rights reserved.
//

#import "NSObject+associationLearn.h"
//定义常量 必须是C语言字符串
static char *PersonNameKey = "PersonNameKey";

@implementation NSObject (associationLearn)
- (void)setDataStr:(NSString *)dataStr {
    objc_setAssociatedObject(self, PersonNameKey, dataStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)test {
    
}

- (NSString *)dataStr {
    return objc_getAssociatedObject(self, PersonNameKey);
}



@end
