//
//  TTDateTool.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/11/14.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation


extension Double {
    
    
}

extension Int {
    // 返回中文数字
    func chineseNumber() -> String {
        switch self {
        case 0:
           return "零"
        case 1:
            return "一"
        case 2:
            return "二"
        case 3:
            return "三"
        case 4:
            return "四"
        case 5:
            return "五"
        case 6:
            return "六"
        case 7:
            return "七"
        case 8:
            return "八"
        case 9:
            return "九"
        case 10:
            return "十"
        default:
            return "函数chineseNumber()数字出错，超过十进制请检查"
        }
    }
    
    
    // 返回中国周表达文本
    func chineseWeekText() -> String {
        switch self {
        case 1:
            return "一"
        case 2:
            return "二"
        case 3:
            return "三"
        case 4:
            return "四"
        case 5:
            return "五"
        case 6:
            return "六"
        case 7:
            return "日"
        default:
            return "函数chineseWeekText()出错，传入日期不对超过一周7天请检查"
        }
    }
    
    // 返回小时，分钟，秒, bit默认3位，两位就分钟秒
    func time(bit: Int = 3) -> String {
        let hour = Int(self / 3600)
        let min = Int(self % 3600 / 60)
        let seconds = Int(self % 60)
        
        if bit == 3 {
            return String.init(format: "%02d:%02d:%02d", hour,min,seconds)
        }else {
            return String.init(format: "%02d:%02d",min,seconds)
        }
    }
    
    func unitTime(bit: Int = 3) -> String {
        let hour = Int(self / 3600)
        let min = Int(self % 3600 / 60)
        let seconds = Int(self % 60)
        
        if bit == 3 {
            return String.init(format: "%02d时%02d分%02d秒", hour,min,seconds)
        }else {
            return String.init(format: "%02d分%02d秒",min,seconds)
        }
    }
}

extension Date {
    
    // 根据日期String
    
    
    // 根据Date 获取时间戳
    func toTimeInterval() -> TimeInterval {
        
        let date1 = Date()
        let date = NSDate()
        
        date.weekday;
        
        
        return self.timeIntervalSince1970
    }
    
    // 返回年份
    func year() -> Int {
        
        return Calendar.current.component(.year, from: self)
    }
    
    // 返回月份
    func month() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    
    // 返回周
    func weekday() -> Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    // 返回中国周
    func chineseWeek() -> Int {
        // 默认数字number 为1时是从周日开始的，所以为7时，实际是周六，做个处理
        var weekDay = Calendar.current.component(.weekday, from: self) - 1
        
        // 为0是周一
        if weekDay == 0 {
            weekDay = 7
        }
        return weekDay
    }
    
    // 返回天
    func day() -> Int {
        //MARK: - Response
        return Calendar.current.component(.day, from: self)
    }
    
    
    
    
    
    
//    // 返回年份
//    func year() -> Int {
//        return Calendar.current.component(.year, from: self)
//    }
//
//    // 返回年份
//    func year() -> Int {
//        return Calendar.current.component(.year, from: self)
//    }
    

    
    // 思路，将所有的服务器得到的字符串，都转化为日期对象，然后自行拼接
    
    
    
    
    
//    - (NSInteger)year {
//        return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
//    }
//
//    - (NSInteger)month {
//        return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
//    }
//
//    - (NSInteger)day {
//        return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
//    }
//
//    - (NSInteger)hour {
//        return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
//    }
//
//    - (NSInteger)minute {
//        return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
//    }
//
//    - (NSInteger)second {
//        return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
//    }
}


class TTDateTool: NSObject {
    
}
