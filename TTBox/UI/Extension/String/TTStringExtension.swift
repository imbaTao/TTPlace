//
//  TTStringExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/19.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation


// MARK: - 字符串截取
extension String {
    /// String使用下标截取字符串
    /// string[index] 例如："abcdefg"[3] // c
    subscript (i:Int)->String{
        let startIndex = self.index(self.startIndex, offsetBy: i)
        let endIndex = self.index(startIndex, offsetBy: 1)
        return String(self[startIndex..<endIndex])
    }
    /// String使用下标截取字符串
    /// string[index..<index] 例如："abcdefg"[3..<4] // d
    subscript (r: Range<Int>) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
            let endIndex = self.index(self.startIndex, offsetBy: r.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    /// String使用下标截取字符串
    /// string[index,length] 例如："abcdefg"[3,2] // de
    subscript (index:Int , length:Int) -> String {
        get {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let endIndex = self.index(startIndex, offsetBy: length)
            return String(self[startIndex..<endIndex])
        }
    }
    // 截取 从头到i位置
    func substring(to:Int) -> String{
        return self[0..<to]
    }
    // 截取 从i到尾部
    func substring(from:Int) -> String{
        return self[from..<self.count]
    }
    
    
    // 一个中文字符算两位
    func lengthWhenCountingNonASCIICharacterAsTwo() -> Int {
        var length = 0
        for i in 0..<self.count {
            let position = self.index(self.startIndex, offsetBy: i) //获取String.index
            let character: Int32 = Int32("\(self[position])") ?? 0
            if isascii(character) > 0 {
                length += 1;
            }else {
                length += 2;
            }
        }
        return length
    }
    
    
    /// 检测邮政编码是否可用
    ///
    /// - Returns: 邮政编码是否可用
    func validatePostalcode() -> Bool {
        let nameRegEx: String = "^[0-8]\\d{5}(?!\\d)$"
        return self.isMatchsRegualExp(string: nameRegEx)
    }
    
    /// 检测url是否可用
    ///
    /// - Returns: url是否可用
    func validateUrl() -> Bool {
        let nameRegEx: String = "^((http)|(https))+:[^\\s]+\\.[^\\s]*$"
        return self.isMatchsRegualExp(string: nameRegEx)
    }
    
    /// 检测身份证号是否有效
    ///
    /// - Returns: 身份证是否有效
    func validateIdentifyCard() -> Bool {
        let nameRegEx: String = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        return self.isMatchsRegualExp(string: nameRegEx)
    }
    
    /// 检测邮箱是否可用
    ///
    /// - Returns: 邮箱是否可用
    func validateEmailAddress() -> Bool {
        let nameRegEx: String = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return self.isMatchsRegualExp(string: nameRegEx)
    }
    
    /// 检测手机号是否可用
    ///
    /// - Returns: 手机号是否可用
    func validateMobilNumber() -> Bool {
        /**
         * 手机号码
         * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
         * 联通：130,131,132,152,155,156,185,186,1709
         * 电信：133,1349,153,180,189,1700
         */
        /**
         10         * 中国移动：China Mobile
         11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
         12         */
        let CM: String = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$"
        /**
         15         * 中国联通：China Unicom
         16         * 130,131,132,152,155,156,185,186,1709
         17         */
        let CU: String = "^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$"
        /**
         20         * 中国电信：China Telecom
         21         * 133,1349,153,180,189,1700
         22         */
        let CT: String = "^1((33|53|8[09])\\d|349|700)\\d{7}$"
        /**
         25         * 大陆地区固话及小灵通
         26         * 区号：010,020,021,022,023,024,025,027,028,029
         27         * 号码：七位或八位
         28         */
        let PHS: String = "^0(10|2[0-5789]|\\d{3})\\d{7,8}$"
        if self.isMatchsRegualExp(string: CM) == true || self.isMatchsRegualExp(string: CU) == true || self.isMatchsRegualExp(string: CT) == true || self.isMatchsRegualExp(string: PHS) {
            return true
        }
        return false
    }
    
    /// 谓词过滤
    /// - Parameter string: 被检测的字符串
    func isMatchsRegualExp(string: String) -> Bool {
        let predicate: NSPredicate = NSPredicate.init(format: "SELF MATCHES %@", string)
        return predicate.evaluate(with: self)
    }
    
    /// 对url进行编码 防止出现中文或者其余特殊字符不能被识别的情况
    public func urlStringEncodingByURLQueryAllowed() -> String {
        let urlString: String = self
        return urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    /// 避免float或者double类型的参数在解析时丢失精度
    ///
    /// - Returns: 没有丢失精度的double
    func doubleFromDecimalString() -> Double {
        let num: Double = Double(self)!
        let string: String = String(format: "%lf", num)
        return NSDecimalNumber.init(string: string).doubleValue
    }
    
    /// double字符串四舍五入
    ///
    /// - Returns: 四舍五入后得到的字符串
    func decimalStringFromRound() -> String {
        let roundUp: NSDecimalNumberHandler = NSDecimalNumberHandler.init(roundingMode: .plain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
        var number: NSDecimalNumber = NSDecimalNumber.init(string: self)
        number = number.rounding(accordingToBehavior: roundUp)
        let roundString: String = String(format: "%.2f", number.doubleValue)
        return roundString
    }
    
    
}



extension NSString {
    // 一个中文字符算两位
    func lengthWhenCountingNonASCIICharacterAsTwo() -> Int {
        var length = 0
        for i in 0..<self.length {
            
            let character: unichar = self.character(at: i)
            if (isascii(Int32(character))) > 0 {
                length += 1;
            }else {
                length += 2;
            }
        }
        return length
    }
    
    // 一个中文字符算两位
    func lengthWhenCountingNonASCIICharacterAsOne() -> Int {
        var length = 0
        for i in 0..<self.length {
            
            let character: unichar = self.character(at: i)
            if (isascii(Int32(character))) > 0 {
                length += 1;
            }else {
                length += 1;
            }
        }
        return length
    }
}

//NSUInteger length = 0;
//for (NSUInteger i = 0, l = self.length; i < l; i++) {
//    unichar character = [self characterAtIndex:i];
//    if (isascii(character)) {
//        length += 1;
//    } else {
//        length += 2;
//    }
//}
//return length;
