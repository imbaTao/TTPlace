//
//  ViewController1.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/10/26.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

//import UIKit
import Foundation
import RxSwift
import Alamofire
import SwiftyJSON
import Kingfisher
import RxCocoa
import HandyJSON
import SwiftyJSON


class ViewController: TTViewController {
    
}

class TTButton1: UIButton {
    
}



class ViewController1: ViewController,UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureView),
                                               name: Notification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil)
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("原文本\(textField.text!)")
        print("replaceString\(string)")
        print("shouldChangeCharactersIn\(range)")
        
        if string == "" {
            return true
        }
        
        
        if  let newText = textField.text?.appending(string).replacingOccurrences(of: " ", with: "") {
            print("新文本长度\(newText.lengthWhenCountingNonASCIICharacterAsTwo())")
            print("新文本\(newText)")
            
            
            var textCount = newText.lengthWhenCountingNonASCIICharacterAsTwo()
            if textCount > 10 {
                textCount = 10
                countLabel.text = "\(textCount)/10"
    
                if textField.markedTextRange == nil {
                    return false
                }else {
                    // 有预选词就不限制，让最终生成长度，然后在didChange里做截取
                    // 最后预选词转化为最终词，一般会大于1个，就直接通过
                    if string.lengthWhenCountingNonASCIICharacterAsTwo() > 1 {
                        return true
                    }else {
                        // 否则单个的限制长度
                        return false
                    }
                }
            }else {
                if string == "" && textCount == 1 {
                    textCount = 0
                }
                
                countLabel.text = "\(textCount)/10"
                return true
            }
        }
        
        
        
    

//        print("文本数量\()")
        return true
    }
    
    let countLabel = UILabel.regular(size: 10, textColor: .black, text: "数量", alignment: .right)
    @objc func configureView() {
        view.removeSubviews()
        let  textFiled = UITextField()
        textFiled.borderColor = .black
        textFiled.borderWidth = 1
//        textFiled.backgroundColor = .orange
        textFiled.becomeFirstResponder()
        textFiled.delegate = self
       
        
        addSubview(textFiled)
        addSubview(countLabel)
        
        textFiled.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.left.right.equalTo(0)
            make.height.equalTo(40)
        }
        
        countLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(textFiled.snp.bottom).offset(20)
        }
        

//        textFiled.rx.text.orEmpty.scan("") { [weak self] (previous, newText) -> String in guard let self = self else { return  ""}
            
//            print("旧的_\(previous)")
//            print("新的_\(newText)")
            
//            let count = newText.replacingOccurrences(of: " ", with: "").count
//
//
//            if let selectedRange = textFiled.markedTextRange {
//                let position = textFiled.position(from: selectedRange.start, offset: 0)
//
//               let offSet =   textFiled.offset(from: position!, to: selectedRange.end)
//
//
////                print("光标偏移量\(offSet)")
//                // 实现原理是先获取一个基于文尾的偏移，然后加上要施加的偏移，再重新根据文尾计算位置，最后利用选取来实现光标定位。
////                  UITextRange *selectedRange = [self selectedTextRange];
////                  NSInteger currentOffset = [self offsetFromPosition:self.endOfDocument toPosition:selectedRange.end];
////                  currentOffset += offset;
////                  UITextPosition *newPos = [self positionFromPosition:self.endOfDocument offset:currentOffset];
////                  self.selectedTextRange = [self textRangeFromPosition:newPos toPosition:newPos];
//
////                print("位置是\(position)")
//            }
//
//
//
//            if let range = textFiled.markedTextRange  {
//                newText
//            }else {
//
//            }
//

//            return newText
//        }.bind(to: textFiled.rx.text).disposed(by: rx.disposeBag)
            
        
        textFiled.rx.text.changed.asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                
                if let newText = textFiled.text?.replacingOccurrences(of: " ", with: "") {
                    self.countLabel.text = "\(newText.lengthWhenCountingNonASCIICharacterAsTwo())/10"
                    
                    // 大于10个，那么截取
                    if newText.lengthWhenCountingNonASCIICharacterAsTwo() > 10 {
                        let index = newText.index(newText.startIndex, offsetBy: 10)
                        textFiled.text = String(newText[..<index])
                    }
                }
 
                
            }).disposed(by: rx.disposeBag)
           
    }
}




extension UIView {
    
    var inset: CGFloat {
        return 12
    }
    
}

extension UIColor {
    // 性别颜色， 男1，女2
    class func genderColor(_ gender: Int = 1) -> UIColor {
        if gender == 1 {
            return rgba(124, 200, 255, 1)
        }else {
            return rgba(255, 127, 182, 1)
        }
    }
    
    // 主要文本颜色
    static var mainStyleColor: UIColor {
        return #colorLiteral(red: 0.5607843137, green: 0.2509803922, blue: 0.9647058824, alpha: 1)
    }
    
    // 主要文本颜色
    static var mainTextColor: UIColor {
        return rgba(51, 51, 51, 1)
    }
    
    // 主要文本颜色2
    static var mainTextColor2: UIColor {
        return rgba(102, 102, 102, 1)
    }
    
    
}
