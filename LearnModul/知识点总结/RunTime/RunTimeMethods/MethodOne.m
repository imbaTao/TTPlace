//
//  MethodOne.m
//  HZYNoteBook
//
//  Created by hong  on 2018/12/14.
//  Copyright © 2018 HZY. All rights reserved.
//

#import "MethodOne.h"
#import "Person.h"

@implementation MethodOne
/**
 动态添加eat方法
 第一个参数cls:给哪个类添加方法
 第二个参数name:添加方法的方法编号
 第三个参数imp:添加方法的函数实现(函数地址)
 第四个参数types：函数的类型
 v: 标识函数的返回值void
 @: 表示参数id self
 : :表示SEL对象
 
 */

// 没有找到addMethod方法后触发
+(BOOL)resolveInstanceMethod:(SEL)sel{
    // 判断名称是否一致(是否应没有addMethod方法而触发)
    if ([NSStringFromSelector(sel) isEqualToString:@"addMethod"]) {
//        // 动态添加一个方法dynamicAddMethod
//        class_addMethod(self, sel, (IMP)dynamicAddMethod, "v@");
    }
    
    return YES;
}

//定义动态添加的方法
void dynamicAddMethod(id self, SEL _cmd, NSString *string){
    NSLog(@"这是动态添加的方法---%@",string);
}
/**
    在没有找到'addMethod'方法时
 触发了'+(BOOL)resolveInstanceMethod:(SEL)sel'方法
 我们动态的添加一个方法。
 那么就会执行dynamicAddMethod方法
 
 
 当resolveInstanceMethod 方法没有处理，即返回NO或者直接返回YES而没有添加方法，我们可以做重定向处理
 */

// 我们可以指定一个可以相应该方法的对象。返回self则会死循环。
- (id)forwardingTargetForSelector:(SEL)aSelector{
//    if (aSelector == @selector(addMethod)) {
//        // 注意Person类中定义了一个方法: -(void)addMethod;
//        return [[Person alloc] init];
//    }
//    return [super forwardingTargetForSelector:aSelector];
    return nil;
}

// 当重定向方法返回了Nil,我们可以做最后一步处理: 消息转发
@end
