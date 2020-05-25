//
//  HTDate.h
//  Jihuigou-Native
//
//  Created by hong on 2019/11/6.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (HTDate)
#pragma mark - Component Properties

@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month; 
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) BOOL isToday; // 今天
@property (nonatomic, readonly) BOOL isYesterday; // 昨天
@property (nonatomic, readonly) BOOL isTomorrow; // 明天
@property (nonatomic, readonly) BOOL isTheDayAfterTomorrowOrlater;// 是否是明天或者后天

/**
  加一天，从YYDate借鉴来的
 */
- (nullable NSDate *)dateByAddingDays:(NSInteger)days;

/**
 字符串日期时间转都换为北京时间戳
 */
+ (NSTimeInterval)timeIntervalWithTimeText:(NSString *)timeText;


/**
 返回北京时间字符串
 */
- (NSString *)chinaTimeStr;

/**
 返回中国时间
 */
+ (NSString *)chinaDateTime:(NSTimeInterval)interval;

/**
 根据倒计时获取倒计时字符串 天：时：分：秒
 */
+ (NSString *)fetchCountDownContentWithCountDownValue:(NSTimeInterval)interval;

@end

NS_ASSUME_NONNULL_END
