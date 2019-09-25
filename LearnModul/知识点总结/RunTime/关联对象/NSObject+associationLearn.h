//
//  NSObject+associationLearn.h
//  HTToolBox
//
//  Created by Mr.hong on 2019/5/30.
//  Copyright © 2019 HT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (associationLearn)
//类拓展添加属性
@property (nonatomic, strong) NSString *dataStr;

@end

NS_ASSUME_NONNULL_END
