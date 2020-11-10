//
//  TTStringExtension.swift
//  HotDate
//
//  Created by Mr.hong on 2020/8/19.
//  Copyright © 2020 刘超. All rights reserved.
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
//            let firstChar = testStr[position]
//            print(firstChar)

    
            
            let character: Int32 = Int32("\(self[position])")!
            if isascii(character) > 0 {
                length += 1;
            }else {
                length += 2;
            }
        }
        return length
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
