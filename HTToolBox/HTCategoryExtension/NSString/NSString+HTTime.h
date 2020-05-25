//
//  NSString+HTTime.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/8/15.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HTNSString)

/**
 根据倒计时获取倒计时字符串 天：时：分：秒
 */
+ (NSString *)fetchCountDownContentWithCountDownValue:(NSInteger)count;


@end

NS_ASSUME_NONNULL_END
