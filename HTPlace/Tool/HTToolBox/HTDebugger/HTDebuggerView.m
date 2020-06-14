//
//  HTDebuggerView.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/1.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HTDebuggerView.h"
@interface HTDebuggerView()
@property (weak, nonatomic) IBOutlet UIButton *testButton;

/**
 
 */
@property(nonatomic, readwrite, copy)NSMutableString *mstr;

@end

@implementation HTDebuggerView
- (instancetype)init
{
    self = [super init];
    if (self) {
      NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [runloop run];
    }
    return self;
}

- (void)awakeFromNib {
    self.mstr = [[[NSMutableString alloc] initWithString:@"123"] mutableCopy];
           
    NSLog(@"%@",[self.mstr class]);
    
    NSLog(@"");
}

void testIMP (void) {
    NSLog(@"test invoke");
}


+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(test)) {
        NSLog(@"resoveInstanceMethod:");
        class_addMethod(self, @selector(test), testIMP, "v@:");
        
        return YES;
    }else {
      return  [super resolveInstanceMethod:sel];
    }
}

- (UIView *)hitTest:(CGPoint) point withEvent:(UIEvent *)event {
    NSLog(@"走了hitTest方法");
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
     NSLog(@"走了pointInside方法");
    return true;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"我是debugger视图,点击开始了");
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"我是debugger视图,点击移除了");
//}
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"我是debugger视图,点击结束了");
//}

@end
