//
//  NSString+HTStringTool.h
//  Jihuigou-Native
//
//  Created by Mr.hong on 2019/6/20.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HTStringTool)
// 把当前完整日期时间转换为只有小时和分钟的时间
+ (NSString *)fetchHourAndMinTime:(NSString *)time;
@end

NS_ASSUME_NONNULL_END
