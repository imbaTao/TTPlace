//
//  HomeView.m
//  TTPlace
//
//  Created by hong on 2020/5/18.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HomeView.h"

typedef void(^Myblock)(void);

@interface HomeView()
/**
 block
 */
@property(nonatomic, readwrite, copy)Myblock block;

@end


@implementation HomeView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.delegate = self;
       
        self.block = ^{
            
        };
        
        NSLog(@"%@",self.block);
        
//        objc_getAssociatedObject(self.title, @"title");
        
        objc_setAssociatedObject(self, @"title", @"", OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return self;
}

- (NSString *)name {
    return [NSString stringWithFormat:@"%@",objc_getAssociatedObject(self, @"title")];
}


- (void)displayLayer:(CALayer *)layer {
    
}


//+ (void)load {
//    // 获取test方法
//    Method test = class_getClassMethod(self, @selector(test));
//
//    // 获取otherTest方法
//    Method other = class_getClassMethod(self, @selector(otherTest));
//
//    // 交换两个方法实现
//    method_exchangeImplementations(test, other);
//}


//- (void)test {
//    NSLog(@"我是实际的test方法");
//}
//- (void)otherTest {
//    [self otherTest];
//    NSLog(@"otherTest");
//}
//
//- (void)test {
//
//}

void testImp(void) {
    NSLog(@"test invoke");
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"2");
    return self;
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event  {
    NSLog(@"1");
        return true;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(test)) {
        NSLog(@"resolveInstanceMethod:");

        // 动态添加test方法的实现
//        class_addMethod(self, @selector(test), testImp, "v@:");

        return false;
    }else {
        return [super resolveInstanceMethod:sel];
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"forwardingTargetForSelector:");
    // 为空继续转发,走到方法签名

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@",self.layer.contents);
    });
    return nil;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(test)) {
         NSLog(@"methodSignatureForSelector:");
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }else {
        return [super methodSignatureForSelector:aSelector];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation:");
}

@end
