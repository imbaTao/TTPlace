//
//  TTTextFiled.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/7.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class TTTextFiled: UITextField,UITextFieldDelegate {
    // 配置文件对象
    var configure = TTTextFiledConfigure() {
        didSet {
            makeUI()
        }
    }
    
    // textView，文本右侧字数提示
    lazy var textCountTips: UILabel = {
        var textCountTips = UILabel.regular(size: 12, textColor: .black, text: "0/\(configure.maxTextCount)", alignment: .right)
        addSubview(textCountTips)
        textCountTips.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-12)
        }

        return textCountTips
    }()
    
    
    func makeUI() {
        // config
        textColor = configure.textColor
        font = configure.textFont
        
        tintColor = configure.caretColor
        textAlignment = configure.textAlignment
        
        // 文本内边距
//        textContainerInset = configure.contentEdges
        
        // 默认代理签给管理者,管理者
        self.delegate = self
        
        // 是否显示文字提示
        textCountTips.isHidden = !configure.showTextCountTips
    }

    // 根据config初始化
    init(configure: TTTextFiledConfigure = TTTextFiledConfigure(),configAction:TextViewConfigClosure? = nil) {
        super.init(frame: .zero)
        self.configure = configure
        
        // 在外面配置config
        if configAction != nil {
            configAction!(self.configure)
        }
        setup()
    }
    
    init(configAction: TextViewConfigClosure? = nil) {
        configAction?(self.configure)
        super.init(frame: .zero)
        setup()
    }
    

    
    func setup() {
        // 基础UI配置
        makeUI()
        
        // 配置占位符
        configFilter()
        configPlaceHolder()
        bindViewModel()
    }
    
    
    // 设置占位符
    func configPlaceHolder() {
        if configure.placeholderText.count > 0 {
            let att = NSMutableAttributedString.init(string: configure.placeholderText)
//            att.font = configure.placeholderFont
//            att.color = configure.placeholderColor
            attributedPlaceholder = att
        }
    }
    
    
    
    // 输入非法字符过滤
    func configFilter() {
        if configure.filterType != .initial {
            let filter = TTTextFilter.init(configure.filterType)
            self.rx.text.orEmpty
                .scan("") {(previous, new) -> String in
                    // 如果新的是合法的,就返回新的，否则返回旧的
                    if filter.filter(new) {
                        return new
                    }else {
                        return previous
                    }
                }
                .bind(to: self.rx.text)
                .disposed(by: rx.disposeBag)
        }
        
//        if let filter = configure.filter {
//            self.rx.text.orEmpty
//                .scan("") { [weak self] (previous, newText) -> String in guard let self = self else { return  ""}
//                    // 如果新的是合法的,就返回新的，否则返回旧的
////                    var finalText = newText
//
//                   // 如果备选text范围不为空
////                    if let _ = self.markedTextRange {
//////                        if filter.type == .legal {
//////
//////                        }
////                        // 将备选范围里的空格去掉判断
////                        finalText = newText.replacingOccurrences(of: " ", with: "")
////                    }
////
//
//                    if filter.filter(finalText)  {
//                        // 返回的是默认最新的text
//                        if self.textOverMaxCout(text: finalText) {
//                            return previous
//                        }
//                        return newText
//                    }else {
//                        return previous
//                    }
//                }.bind(to: self.rx.text)
//                .disposed(by: rx.disposeBag)
//        }
    }
    
    
    
    
    // 处理rx事件
    func bindViewModel() {
        self.rx.text.changed.asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
    
                // 替换预排版内容
                if let newText = self.text?.replacingOccurrences(of: " ", with: "") {
                
                    // 大于10个，那么截取
                    if newText.lengthWhenCountingNonASCIICharacterAsTwo() > self.configure.maxTextCount {
                        let index = newText.index(newText.startIndex, offsetBy: self.configure.maxTextCount)
                        self.text = String(newText[..<index])
                     }
                }
                
                
                // 显示数量
                if self.configure.showTextCountTips {
                    if let newText = self.text?.replacingOccurrences(of: " ", with: "") {
                        self.textCountTips.text =  "\(newText.lengthWhenCountingNonASCIICharacterAsTwo())/\(self.configure.maxTextCount)"
                    }
                }
            }).disposed(by: rx.disposeBag)
    }
    
    
    // 返回键
    let returnKeyAction = PublishSubject<()>()
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnKeyAction.onNext(())
        return true
    }

    // 拦截
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        // 回车符放行
        if string == "" {
            return true
        }
        

        // 计算新文本
        if  let newText = textField.text?.appending(string).replacingOccurrences(of: " ", with: "") {
//            print("新文本长度\(newText.lengthWhenCountingNonASCIICharacterAsTwo())")
//            print("新文本\(newText)")
            
            
            
            
            if let filter = configure.filter {
                if !filter.filter(string) {
                    return false
                 }
            }
            
            // 新文本长度
            var textCount = newText.lengthWhenCountingNonASCIICharacterAsTwo()
            if textCount > configure.maxTextCount {
                textCount = configure.maxTextCount
             
    
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
                return true
            }
        }
        return true
    }
    
    // UI部分
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        var newBounds = super.textRect(forBounds: bounds)
//        newBounds.origin.x += configure.contentEdges.left
//        return newBounds
//    }
//
//    override func firstRect(for range: UITextRange) -> CGRect {
//        var newBounds = super.textRect(forBounds: bounds)
//        newBounds.origin.x += configure.contentEdges.left
//        return newBounds
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        var newBounds = super.textRect(forBounds: bounds)
//        newBounds.origin.x += configure.contentEdges.left
//        return newBounds
//    }
//
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        var newBounds = super.textRect(forBounds: bounds)
//        newBounds.origin.x += configure.contentEdges.left
//        return newBounds
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TTTextFiledConfigure: TTTextViewConfigure {
    
}
