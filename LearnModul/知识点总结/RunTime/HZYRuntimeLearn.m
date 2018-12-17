//
//  HZYRuntimeLearn.m
//  HZYNoteBook
//
//  Created by hong  on 2018/12/14.
//  Copyright © 2018 HZY. All rights reserved.
//

#import "HZYRuntimeLearn.h"
#import <objc/message.h>
#import "MethodOne.h"
//#import "RuntimeModel.h"
@interface HZYRuntimeLearn()<UITableViewDelegate>

/** name */
@property(nonatomic,copy)NSString *name;
@end


@implementation HZYRuntimeLearn{
    NSString *_name2;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
          [self runtimeEat];
//        [self addMethodTest];
//        [self takeTheProperty];
    }
    return self;
}



// 通过runTime实现eat函数
- (void)runtimeEat{
//    RuntimeModel *model = [[RuntimeModel alloc] init];
//    objc_msgSend(model,sel_registerName("eat"));
    objc_msgSend(objc_msgSend(objc_msgSend(objc_getClass("RuntimeModel"), sel_registerName("alloc")), sel_registerName("init")), sel_registerName("eat"));
}
































// 动态添加方法
- (void)addMethodTest{
    MethodOne *method = [[MethodOne alloc] init];
    // 要求执行addMethod方法 但是类中没有声明该方法
    [method performSelector:@selector(addMethod) withObject:nil];
}

// 通过runtime 获取属性列表
- (void)takeTheProperty{
    unsigned int count;
    //获取属性列表
//    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
//    for (unsigned int  i=0; i < count; i++) {
//        const char *propertyName = property_getName(propertyList[i]);
//        NSLog(@"property--->%@",[NSString stringWithUTF8String:propertyName]);
//    }
//
//    // 获取方法列表
//    Method *methodList = class_copyMethodList([self class], &count);
//    for (unsigned int i = 0; i < count; i++) {
//        Method method = methodList[i];
//        NSLog(@"Method--->%@",NSStringFromSelector(method_getName(method)));
//
//    }
    
//    // 获取成员变量列表
//    Ivar *ivarList = class_copyIvarList([self class], &count);
//    for (unsigned int i = 0; i < count; i++) {
//        Ivar myIvar = ivarList[i];
//        const char *ivarName = ivar_getName(myIvar);
//        NSLog(@"Ivar---->%@",[NSString stringWithUTF8String:ivarName]);
//    }
    
    // 获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i=0; i < count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocalName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@",[NSString stringWithUTF8String:protocalName]);
    }

}


@end
