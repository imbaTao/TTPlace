//
//  HTDebugger.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/7/29.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define  HTDEBUGGER(window) [[HTDebugger share] debugerWithKewindow:window]
#define  DEBUGGER [HTDebugger share]
@interface HTDebugger : NSObject
singleH();
/**
 预定的可直接调试的控制器数组名字
 */
@property(nonatomic, readwrite, strong)NSArray <NSString *>*vcNames;

/**
 当前调试的控制器下标
 */
@property(nonatomic, readwrite, assign)NSInteger debugVcIndex;

- (BOOL)debugerWithKewindow:(UIWindow *)window;


@end

NS_ASSUME_NONNULL_END
