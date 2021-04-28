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



class ViewController1: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureView),
                                               name: Notification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil)
    }
    
    
    @objc func configureView() {
        view.removeSubviews()
        let  textFiled = UITextField()
        textFiled.borderColor = .black
        textFiled.borderWidth = 1
//        textFiled.backgroundColor = .orange
        textFiled.becomeFirstResponder()
        let countLabel = UILabel.regular(size: 10, textColor: .black, text: "数量", alignment: .right)
        
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


//        textFiled.markedTextRange
        textFiled.rx.text.orEmpty.scan("") { [weak self] (previous, newText) -> String in guard let self = self else { return  ""}
            
            print("旧的_\(previous)")
            print("新的_\(newText)")
            
            let count = newText.replacingOccurrences(of: " ", with: "").count
            
        
            if let range = textFiled.markedTextRange  {
                newText
            }else {
                
            }
    

            return newText
        }.bind(to: textFiled.rx.text).disposed(by: rx.disposeBag)
            
        
        textFiled.rx.text.changed.asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                
                
                let text = textFiled.text ?? ""
                // 获取非选中状态文字范围
                if let markTextRange = textFiled.markedTextRange {
                    // 获取光标位置
                    
                    let start = textFiled.cursorOffset!
                    
                    var text2 = NSString.init(string: text).substring(with: NSMakeRange(0,start))
                    countLabel.text = "\(text2.count)/10"
                }else {
                    // 没有非选中文字，截取多出的文字
                    if text.count > 10 {
                        let index = text.index(text.startIndex, offsetBy: 10)
                        textFiled.text = String(text[..<index]).appending(" ")
                        
                    }else {
                  
                    }
                }
                
             
             
//                if selectedRange == nil {
//                    let text = textFiled.text ?? ""
                                        
                    // 默认1个中文字符占两位
//                    if self.textOverMaxCout() {
//                        let index = text.index(text.startIndex, offsetBy: self.configure.maxTextCount)
//                        self.text = String(text[..<index])
//                    }
//                }
                
                
                
            })
            .disposed(by: rx.disposeBag)
           
        
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
