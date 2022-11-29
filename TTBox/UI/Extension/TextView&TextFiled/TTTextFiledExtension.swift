//
//  TextView&TextFiledExtension.swift
//  TTBox
//
//  Created by Mr.hong on 2020/12/25.
//

import Foundation

//MARK: - textField
extension UITextField {
    // 光标偏移
    var cursorOffset: Int? {
        guard let range = selectedTextRange else { return nil }
        return offset(from: beginningOfDocument, to: range.start)
    }

    // 光标所在的StringIndex
    var cursorIndex: String.Index? {
        guard
            let location = cursorOffset,
            case let length = text!.utf16.count - location
        else { return nil }
        return Range(.init(location: location, length: length), in: text!)?.lowerBound
    }

    // 光标距离, textView，selectedRange 转index用这个
    var cursorDistance: Int? {
        guard let cursorIndex = cursorIndex else { return nil }
        return text!.distance(from: text!.startIndex, to: cursorIndex)
    }
}
