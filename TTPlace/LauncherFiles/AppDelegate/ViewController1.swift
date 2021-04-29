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
    
    
    let countLabel = UILabel.regular(size: 10, textColor: .black, text: "数量", alignment: .right)
    @objc func configureView() {
        view.removeSubviews()
        let  textFiled = TTTextFiled.init { (config) in
            config.maxTextCount = 10
            config.filter = .init(.legal)
        }
        textFiled.borderColor = .black
        textFiled.borderWidth = 1
//        textFiled.backgroundColor = .orange
        textFiled.becomeFirstResponder()
        
       
        
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
        
//
//
//        textFiled.rx.text.changed.asObservable()
//            .subscribe(onNext: { [weak self] _ in
//                guard let `self` = self else { return }
//
//                if let newText = textFiled.text?.replacingOccurrences(of: " ", with: "") {
//                    self.countLabel.text = "\(newText.lengthWhenCountingNonASCIICharacterAsTwo())/10"
//
//                    // 大于10个，那么截取
//                    if newText.lengthWhenCountingNonASCIICharacterAsTwo() > 10 {
//                        let index = newText.index(newText.startIndex, offsetBy: 10)
//                        textFiled.text = String(newText[..<index])
//                    }
//                }
//
//
//            }).disposed(by: rx.disposeBag)
//
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
