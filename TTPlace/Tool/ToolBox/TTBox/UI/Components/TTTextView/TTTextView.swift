//
//  TTTextView.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/7.
//

import Foundation

// UITextFile和TextView都用这个控件
class TTTextView: UITextView,UITextViewDelegate{
    enum TTTextViewType {
        case textFiled
        case textView
    }
    
    // 占位文字lable，如果需要改变位置，直接重置约束，remake
    var htPlaceHolder = UILabel.regular(size: 14, textColor: rgba(153, 153, 153, 1), text: "请输入内容", alignment: .left)
    
    // textView，文本右侧字数提示
    lazy var textCountTips: UILabel = {
        var textCountTips = UILabel.regular(size: 12, textColor: .black, text: "0/10", alignment: .right)
        textInputView.addSubview(textCountTips)
        textCountTips.snp.makeConstraints { (make) in
            make.right.equalTo(hor(-12))
            make.centerY.equalToSuperview()
        }
        return textCountTips
    }()
    

    // 内边距
    var contentEdges = UIEdgeInsets.zero
    
    //默认类型，私有变量
    private var type = TTTextViewType.textView
    
    // 一个中文字符占几位
    private var chiniseCharCount: Int = 2
    
    // 默认不限制最大输入字数
    private var maxTextCount = 0;
    
    // chiniseCharCount 默认占两位
    init(type: TTTextViewType = .textView,defaulTtext: String = "",textColor: UIColor,font: UIFont,cursorColor: UIColor = .black,maxTextCount: Int = 0,chiniseCharCount: Int = 2,hasCountTips: Bool = false,placeHodler: String = "",placeHodlerColor: UIColor = rgba(102, 102, 102, 1),contentEdges: UIEdgeInsets = .zero) {
        super.init(frame: .zero,textContainer: nil)
        
        
        // config
        self.textColor = textColor
        self.font = font
        self.tintColor = cursorColor
        self.contentEdges = contentEdges
        self.type = type
        self.chiniseCharCount = chiniseCharCount
        self.maxTextCount = maxTextCount
        self.text = defaulTtext;
        self.htPlaceHolder.textColor = placeHodlerColor
//        self.dele = self
        

        
        
        
        // 如果需要占位文字
        if placeHodler.count > 0 {
            self.textInputView.addSubview(htPlaceHolder)
            htPlaceHolder.snp.makeConstraints { (make) in
                make.left.equalTo(contentEdges.left + 3)
                make.right.equalTo(0)
                make.centerY.equalToSuperview()
            }
            htPlaceHolder.text = placeHodler
            
            // 监听变化隐藏placeholder
            self.rx.text.subscribe(onNext: {[weak self] (_) in
                guard let `self` = self else { return }
                let text = self.text ?? ""
                self.htPlaceHolder.isHidden = text.count > 0
            }).disposed(by: rx.disposeBag)
        }
        
        
        
        if maxTextCount > 0 {
            self.rx.didChange
                      .asObservable()
                      .subscribe(onNext: { [weak self] _ in
                          guard let `self` = self else { return }

                          // 获取非选中状态文字范围
                          let selectedRange = self.markedTextRange
                        
                          // 没有非选中文字，截取多出的文字
                          if selectedRange == nil {
                              let text = self.text ?? ""
                            
                            // 默认1个中文字符占两位
                            if self.textOverMaxCout() {
                                  let index = text.index(text.startIndex, offsetBy: maxTextCount)
                                  self.text = String(text[..<index])
                              }
                          }
                        
                        
                        // 如果显示字数提示
                        if hasCountTips {
                            // 显示最大数提示
                            self.textCountTips.text = "\(self.text.count)/\(maxTextCount)"
                        }
                    
                      })
                .disposed(by: rx.disposeBag)
        }
    }
    
    

    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if type == .textFiled {
            self.isScrollEnabled = false;
            
            // 居中
            let attText = NSMutableAttributedString.init(string: "我是占位文字，只用来计算高度，居中不会被显示")
            attText.font = font
            let yyLayout = YYTextLayout.init(container: YYTextContainer.init(size: CGSize(width: SCREEN_W, height: SCREEN_H)), text: attText)
            

            if let textHeight = yyLayout?.textBoundingSize.height {
                let topBottomInterval = (self.height - textHeight) / 2
                
                    // 居中
                 self.textContainerInset = UIEdgeInsets.init(top: topBottomInterval, left: contentEdges.left, bottom: topBottomInterval, right: contentEdges.right)
            }
        }else {
            self.textContainerInset = contentEdges
        }
        
//        self.superview?.layoutIfNeeded()
//        self.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Delegate,暂时没解决这个限制问题，后续优化
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        return textOverMaxCout()
//    }
    
    
    // 是否超过了最大字数,如果代理牵在自定义控制器，请在textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool代理里也做这个检测
    func textOverMaxCout() -> Bool {
        if self.maxTextCount == 0 {
            return true
        }
        
        return (self.chiniseCharCount == 2 ? text.lengthWhenCountingNonASCIICharacterAsTwo() : self.text.count) > self.maxTextCount
    }

}
