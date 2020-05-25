//
//  HTDate.m
//  Jihuigou-Native
//
//  Created by hong on 2019/11/6.
//  Copyright © 2019 xiongbenwan. All rights reserved.
//

#import "NSDate+HTDate.h"

@implementation NSDate (YYAdd)
- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (BOOL)isLeapMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

- (BOOL)isLeapYear {
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}


- (BOOL)isYesterday {
    NSDate *added = [self dateByAddingDays:1];
    return [added isToday];
}

- (BOOL)isToday {
    // 时间大于一天直接返回false
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    
    // 用当天时间对比
    return [NSDate new].day == self.day;
}

- (BOOL)isTomorrow {
    return [[NSCalendar currentCalendar] isDateInTomorrow:self];
}

- (BOOL)isTheDayAfterTomorrowOrlater {
    // 不是今天不是明天,且时间大于1天，那么就是后天或者更后面的日期
    if (![self isToday] && ![self isTomorrow] &&  (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24)) {
        return true;
    }else {
        return false;
    }
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - 根据时间字符串返回北京时间戳
+ (NSTimeInterval)timeIntervalWithTimeText:(NSString *)timeText {
    NSDate *tempDate = [[self chinaTimeFormatter:timeText] dateFromString:timeText];
    return [tempDate timeIntervalSince1970];
}

#pragma mark - 返回北京时间字符串
- (NSString *)chinaTimeStr {
    NSString *timeText = [NSString stringWithFormat:@"%@",self];
    if ([timeText containsString:@"+"]) {
        timeText = [timeText componentsSeparatedByString:@"+"].firstObject;
    }
    
    NSDateFormatter *fomatter = [NSDate chinaTimeFormatter:timeText];
    NSDate *date = [fomatter dateFromString:timeText];
    return [fomatter stringFromDate:[date chinaTimeDate]];
}

#pragma mark - 任意时间转成北京日期
- (NSDate *)chinaTimeDate {
    // 设置转换后的目标日期时区
    NSTimeZone *chinaTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    // 目标日期与本地时区的偏差秒
    NSInteger destinationGMTOffset = [chinaTimeZone secondsFromGMTForDate:self];
    
    // 根据偏差值返回北京在时间
    return [[NSDate alloc] initWithTimeInterval:destinationGMTOffset sinceDate:self];
}

#pragma mark - 时间戳转换为中国时间日期字符串
+ (NSString *)chinaDateTime:(NSTimeInterval)interval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return [date chinaTimeStr];
}

#pragma mark - 中国时区的formatter
+ (NSDateFormatter *)chinaTimeFormatter:(NSString *)timeText {
    // 时间格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    if ([timeText containsString:@"."]) {
        //存在毫秒
        if ([timeText containsString:@"T"]) {
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
        } else {
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        }
    } else {
        if ([timeText containsString:@"T"]) {
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        } else {
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
    }
    return dateFormatter;
}

#pragma mark - 根据结束时间字符串获取倒计时时间戳
//+ (NSTimeInterval)fetchCountDonwWithStartTime:(NSString *)startTime endTime:(NSString *)endTime {
//
//    NSTimeInterval interval =

//    NSInteger count = [JHGSeckillCommonHandle fetchCountDownWithEndTime:endTime];

//    if (count >= 24 * 60 * 60) {
//        return [NSString stringWithFormat:@"%02ld天%02ld:%02ld:%02ld",(NSInteger)(count / (24 * 60 * 60)) ,(NSInteger)(count / 3600.0) % 24,(NSInteger)(count / 60) % 60,(NSInteger)count % 60];
//    }else {
//        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(NSInteger)(count / 3600.0),(NSInteger)(count / 60) % 60,(NSInteger)count % 60];
//    }
//}
@end
