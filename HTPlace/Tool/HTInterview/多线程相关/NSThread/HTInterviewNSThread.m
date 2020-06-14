//
//  HTInterviewNSThread.m
//  HTPlace
//
//  Created by Mr.hong on 2020/6/2.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

#import "HTInterviewNSThread.h"

@interface HTInterviewNSThread()

/**
 总是可以运行
 */
@property(nonatomic, readwrite, assign)NSInteger runAlways;


/**
  常驻子线程
 */
@property(nonatomic, readwrite, strong)NSThread *thread ;

@end
@implementation HTInterviewNSThread



- (instancetype)init
{
    @synchronized (self) {
        
    };
    
    self = [super init];
    if (self) {
        // NSThread实现一个常驻线程
        self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadAction) object:nil];
        
        [self.thread setName:@"HTThread"];
        [self.thread start];
        
        
//        [self performSelector:@selector(<#selector#>) onThread:self.thread withObject:nil waitUntilDone:false];
        NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
            NSLog(@"threadTimer在执行");
        }];
        
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
    return self;
}

- (void)threadAction {
    NSLog(@"子线程在执行");
    // 创建一个source
    CFRunLoopSourceContext context = {0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL};
    
    // 创建RunLoop，同时向runLoop的DefaultModel下面添加Source
    CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
    
    // 如果可以运行
    while (self.runAlways) {
        @autoreleasepool {
            // 令当前RunLoop运行在DefaultModel下面
            CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, true);
        }
    }
    
    // 某一实际 静态变量runAlways = NO时可以保证跳出RunLoop，线程退出
    CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    CFRelease(source);
}

@end
