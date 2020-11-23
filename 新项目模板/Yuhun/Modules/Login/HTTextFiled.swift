//
//  HTTextFiled.swift
//  GanLiao
//
//  Created by Mr.hong on 2020/11/3.
//

import UIKit

//extension UITextField {
//
//    init() {
//        super.init(frame: .zero)
//        <#??#>
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}

class HTTextFiled: UITextField,UITextFieldDelegate {
    // 自定义占位文字
    var placeholderLabel = UILabel.regular(size: 12, textColor: rgba(151, 151, 151, 1))
    
    // 最大输入数
    var maxInputCount = LONG_MAX
   
    // 是否一个中文字符算两位
    var shouldCountingNonASCIICharacterAsTwo = false
    
    init(cursorColor: UIColor,placeHolder: String,font: UIFont) {
        super.init(frame: .zero)
        
        // 设置光标颜色
        self.tintColor = cursorColor
        self.font = font
        self.delegate = self
        
        // 设置占位符
        placeholderLabel.text = placeHolder
        placeholderLabel.font = font
    
        
        addSubview(placeholderLabel)
        
        // layout
        placeholderLabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.lastBaseline.equalToSuperview()
        }
        
        
        
        
        
        
//        self.rx.text.asObserver().mapObserver { (text) -> String? in
//
//        }
        
        
//        self.rx.text.bind(to: placeholderLabel.rx.text).disposed(by: rx.disposeBag)
        
        
//        self.placeholderLabel.rx.isHidden
        
        // 监听输入,隐藏显示占位文字
        self.rx.text.subscribe(onNext: {[weak self] (text) in
//            print(text ?? "")

            if let t = text {
                self?.placeholderLabel.isHidden = t.count > 0
            }

        }).disposed(by: rx.disposeBag)
    }
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        //限制长度
//        let proposeLength = (textField.text?.lengthOfBytes(using: String.Encoding.utf8))! - range.length + string.lengthOfBytes(using: String.Encoding.utf8)
//         if proposeLength > 4 { return false }
//
//        return true
//    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= self.maxInputCount
    }
    
    
//    func textField(textField:UITextField, shouldChangeCharactersInRange range:NSRange, replacementString string: String) -> Bool {
//               iftfTime == textField {
//                    //限制只能输入数字，不能输入特殊字符
//                   let length = string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
//                   for loopIndexin0..<length {
//                       let char = (stringas NSString).characterAtIndex(loopIndex)
//                       if char <48 {return false }
//                       if char >57 {return false }
//                    }
//
//                }
        
 
//       iftfCMD == textField {
//           let length = string.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
//           for loopIndexin0..<length {
//               let char = (stringas NSString).characterAtIndex(loopIndex)
//
//               //只能输入 a~z A~Z
//               if char <65 {return false }
//               if char >=91 && char <=112 {returnfalse }
//               if char >=123 {returnfalse }
//            }
//
//        }
//        return true
//    }
    
    
    
    
    // 是否是手机号
    fileprivate func validateNumber(_ textField: UITextField, range: NSRange, string: String, limit: Int = 11) -> Bool {
        
        guard let text = textField.text else { return false }

        ///拼接了参数string的afterStr
    //        let afterStr = text.replacingCharacters(in: text.ext2Range(range)!, with: string)
    //        DebugLog(afterStr)
        let afterStr = (text as NSString).replacingCharacters(in: range, with: string)
//        DebugLog(afterStr)
        
        ///限制长度
        if afterStr.count > limit {
            textField.text = (afterStr as NSString).substring(to: limit)
            return false
        }
        
        ///是否都是数字
        let set = CharacterSet(charactersIn: "0123456789").inverted
        let filteredStr = string.components(separatedBy: set).joined(separator: "")
        
        if filteredStr == string {
            return true
        }
        
        return false
    }
    
       required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



