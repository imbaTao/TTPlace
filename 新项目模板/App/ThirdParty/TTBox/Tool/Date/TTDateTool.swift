//
//  TTDateTool.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/11/14.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation

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
        if bit == 3 {
            return String.init(format: "%02d:%02d:%02d", hour,min,seconds)
        }else {
            return String.init(format: "%02d:%02d",min,seconds)
        }
    }
    
    func unitTime(bit: Int = 3) -> String {
        if bit == 3 {
            return String.init(format: "%02d时%02d分%02d秒", hour,min,seconds)
        }else {
            return String.init(format: "%02d分%02d秒",min,seconds)
        }
    }
    
    // 天/时/分/秒依次
    func translateToChiniseTimeUnit() -> String {

       var timeStr = ""
        if day > 0 {
            timeStr.append("\(day)天")
        }
        if hour > 0 {
            timeStr.append("\(hour)小时")
        }
        if min > 0 {
            timeStr.append("\(min)分")
        }
        if seconds > 0 {
            timeStr.append("\(seconds)秒")
        }
        
        return timeStr
    }
    
    
    
    var min: Int {
        return Int(self % 3600 / 60)
    }
    
    var hour: Int {
        return Int(self / 3600)
    }
    
    var day: Int {
        return Int(self / (3600 * 24))
    }
    
    var seconds: Int {
        return Int(self % 60)
    }
    
    
    
//    时间显示规则
//    1.一小时以内：显示具体分钟 例：1分钟前、28分钟前、59分钟前
//    2.一天以内：显示具体小时 例：一小时前、12小时前、23小时前
//    3.三天以内：显示具体天数 例：一天前、三天前
//    4.三天以后：显示具体时间（不带年份） 例：2.18 5.19
    
    // 聊天时间显示
    func chatTime(needDivideThousand: Bool) -> String {
        // 计算时间差
        
        let time = needDivideThousand ? Double(self) / 1000.0 : Double(self)
        let timeInterval = Int(Swift.abs(time -  Date().timeIntervalSince1970))
        
        
        
        // 如果小于1分钟
        if timeInterval < 60 {
            return "刚刚"
        }
        
        // 如果小于1小时
        if timeInterval < 3600 {
            return "\(timeInterval.min)分钟前"
        }
        
        // 小于一天
        if timeInterval < 24 * 3600 {
            return "\(timeInterval.hour)小时前"
        }
        
        // 小于三天
        if timeInterval < 24 * 3600 * 3 {
            return "\(timeInterval.day)天前"
        }
        
        // 三天以后
        let date = Date.init(timeIntervalSinceNow: Double(-timeInterval))
        return String.init(format: "%02d.%02d", date.month,date.day)
    }
    
    // 微信的规则
//    1、当天的消息，以每5分钟为一个跨度的显示时间；
//    2、消息超过1天、小于1周，显示星期+收发消息的时间；
//    3、消息大于1周，显示手机收发时间的日期。
}

extension Date {
    // 根据Date 获取时间戳
    func toTimeInterval() -> TimeInterval {
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
}


class TTDateTool: NSObject {
    
}
