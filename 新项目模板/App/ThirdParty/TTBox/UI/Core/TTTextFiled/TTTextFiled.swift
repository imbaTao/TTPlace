//
//  TTTextFiled.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/7.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation


class TTTextFiled: UITextField,UITextFieldDelegate {
    // 配置文件对象
    var configure = TTTextFiledConfigure() {
        didSet {
            makeUI()
        }
    }
    
    func makeUI() {
        // config
        textColor = configure.textColor
        font = configure.textFont
        
        tintColor = configure.caretColor
        textAlignment = configure.textAlignment
        
        // 文本内边距
//        textContainerInset = configure.contentEdges
        
        // 默认代理签给管理者,管理者
        self.delegate = TTTextViewManager.shared
    }
    
    init(configure: TTTextFiledConfigure = TTTextFiledConfigure(),configAction:TextViewConfigClosure? = nil) {
        super.init(frame: .zero)
        self.configure = configure
        
        // 在外面配置config
        if configAction != nil {
            configAction!(self.configure)
        }
        setup()
    }
    
    init(configAction:TextViewConfigClosure) {
        super.init(frame: .zero)
        configAction(self.configure)
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
            att.font = configure.placeholderFont
            att.color = configure.placeholderColor
            attributedPlaceholder = att
        }
    }
    
    
    
    // 输入非法字符过滤
    func configFilter() {
        if let filter = configure.filter {
            self.rx.text.orEmpty
                .scan("") { [weak self] (previous, new) -> String in guard let self = self else { return  ""}

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
    }
    
    
    
    
    // 处理rx事件
    func bindViewModel() {
        self.rx.text.changed.asObservable()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                
                // 获取非选中状态文字范围
                let selectedRange = self.markedTextRange
                
                // 没有非选中文字，截取多出的文字
                if selectedRange == nil {
                    let text = self.text ?? ""
                    
                    // 设置
//                    self.text = TTTextViewManager.shared.removeLegalWords(text)
                    
                    
                    // 默认1个中文字符占两位
                    if self.textOverMaxCout() {
                        let index = text.index(text.startIndex, offsetBy: self.configure.maxTextCount)
                        self.text = String(text[..<index])
                    }
                }
            })
            .disposed(by: rx.disposeBag)
    }

    // 是否超过最大数
    func textOverMaxCout() -> Bool {
        if configure.maxTextCount == 0 {
            return false
        }
        
        // 文本
        let text = self.text ?? ""
        
        // 中文字符长度处理
        return (configure.chiniseCharCount == 2 ? text.lengthWhenCountingNonASCIICharacterAsTwo() : text.count) > configure.maxTextCount
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TTTextFiledConfigure: TTTextViewConfigure {
    
}
