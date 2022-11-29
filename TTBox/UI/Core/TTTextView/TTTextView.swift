//
//  TTTextView.swift
//  TTBox
//
//  Created by Mr.hong on 2020/12/7.
//

import Foundation
import UIKit

// 配置闭包,在init的时候配置，就不用单独再alloc一个对象
typealias TextViewConfigClosure = (_ configure: TTTextViewConfigure) -> Void
class TTTextView: UITextView, UITextViewDelegate,TextInputRuleDelegate {
    // 配置文件对象
    var configure = TTTextViewConfigure() {
        didSet {
            makeUI()
        }
    }

    // 占位文字lable，如果需要改变位置，直接重置约束，remake
    var htPlaceHolder = UILabel.regular(
        size: 14, textColor: rgba(153, 153, 153, 1), text: "请输入内容", alignment: .left)

    // 距离光标的起始位置,默认3
    var caretStartSpace: CGFloat = 3

    // textView，文本右侧字数提示
    lazy var textCountTips: UILabel = {
        var textCountTips = UILabel.regular(
            size: 12, textColor: .black, text: "0/\(configure.maxTextCount)", alignment: .right)
        addSubview(textCountTips)
        textCountTips.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-12)
        }

        return textCountTips
    }()

    init(
        configure: TTTextViewConfigure = TTTextViewConfigure(),
        configAction: TextViewConfigClosure? = nil
    ) {
        super.init(frame: .zero, textContainer: nil)
        self.configure = configure

        // 在外面配置config
        if configAction != nil {
            configAction!(self.configure)
        }
        setup()
    }

    init(configAction: TextViewConfigClosure) {
        super.init(frame: .zero, textContainer: nil)
        configAction(self.configure)
        setup()
    }

    func setup() {
        // 基础UI配置
        makeUI()

        // 配置占位符
        configPlaceHolder(configure.placeholderText)
        configFilter()
        bindViewModel()
    }

    func makeUI() {
        // config
        textColor = configure.textColor
        font = configure.textFont

        tintColor = configure.caretColor
        textAlignment = configure.textAlignment

        // 去掉默认边距
        textContainer.lineFragmentPadding = 0

        // 文本内边距
        textContainerInset = configure.contentEdges

        // 默认代理签给管理者,管理者
        self.delegate = TTTextViewManager.shared
    }

    // 设置占位符
    func configPlaceHolder(_ placeHolder: String) {
        if placeHolder.count > 0 {
            addSubview(htPlaceHolder)

            htPlaceHolder.snp.makeConstraints { (make) in
                make.left.equalTo(configure.contentEdges.left + configure.placeholderLeftOffset)
                make.right.equalTo(-configure.contentEdges.right)
                make.top.equalTo(configure.contentEdges.top)

                // 距离顶部的
                //  make.top.equalTo(configure.contentEdges.top)
            }

            htPlaceHolder.text = placeHolder

            // 默认跟正文一样大
            htPlaceHolder.font =
                configure.placeholderFont != nil ? configure.placeholderFont : configure.textFont
            htPlaceHolder.textColor = configure.placeholderColor

            // 监听变化隐藏placeholder
            self.rx.text.subscribe(onNext: { [weak self] _ in guard let self = self else { return }
                let text = self.text ?? ""
                self.htPlaceHolder.isHidden = text.count > 0
            }).disposed(by: rx.disposeBag)
        }
    }

    // 输入非法字符过滤
    func configFilter() {
//        if configure.filterType != .initial {
////            let filter = TTTextFilter.init(configure.filterType)
////            self.rx.text.orEmpty
////                .scan("") { (previous, new) -> String in
////                    // 如果新的是合法的,就返回新的，否则返回旧的
////                    if filter.filter(new) {
////                        return new
////                    } else {
////                        return previous
////                    }
////                }
////                .bind(to: self.rx.text)
////                .disposed(by: rx.disposeBag)
//        }
    }

    // 处理rx事件
    func bindViewModel() {
        self.rx.didChange
            .asObservable()
            .subscribe(onNext: { [weak self] _ in guard let self = self else { return }

//                // 获取非选中状态文字范围
//                let selectedRange = self.markedTextRange
//
//                // 没有非选中文字，截取多出的文字
//                if selectedRange == nil {
//                    let text = self.text ?? ""
//
//                    // 默认1个中文字符占两位
//                    if self.textOverMaxCout() {
//                        let index = text.index(
//                            text.startIndex, offsetBy: self.configure.maxTextCount)
//                        self.text = String(text[..<index])
//                    }
//                }
//
//                // 显示数量
//                if self.configure.showTextCountTips {
//                    if let newText = self.text?.replacingOccurrences(of: " ", with: "") {
//                        self.textCountTips.text =
//                            "\(newText.lengthWhenCountingNonASCIICharacterAsTwo())/\(self.configure.maxTextCount)"
//                    }
//                }
                
                
                self.limitLength(by: self.configure.filter?.expression ?? "", maxLength: self.configure.maxTextCount)
                
            })
            .disposed(by: rx.disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Delegate
    // 是否超过了最大字数,如果代理牵在自定义控制器，请在textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool代理里也做这个检测
    func textOverMaxCout() -> Bool {
        // 默认不做限制
        if configure.maxTextCount == 0 {
            return false
        }

        //  限制规则
        return
            (configure.chiniseCharCount == 2
            ? text.lengthWhenCountingNonASCIICharacterAsTwo() : self.text.count)
            > configure.maxTextCount
    }
}

// UITextFile和TextView都用这个控件
class TTTextViewManager: NSObject, UITextViewDelegate, UITextFieldDelegate {
    static let shared = TTTextViewManager()

    // 英文字符
    let englishLettersPattern = "[a-zA-Z]"

    // 数字字符
    let numberPattern = "[0-9]"

    // 中文谓词
    let chinisePattern = "^[\u{4e00}-\u{9fa5}]+$"

    // emoji谓词
    let emojiPattern =
        "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"

    // 普通合法使用场景汉字，数字，英文
    let legalPattern = "^[a-zA-Z0-9_\u{4e00}-\u{9fa5}]+$"

    func textField(
        _ textField: UITextField, shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {

        if let seletedRange = textField.selectedTextRange {
            if let position = textField.position(from: seletedRange.start, offset: 0) {
                // 有高亮选择的字符串，不做处理

                return true
            } else {
                return isLegal(string) || string == ""
            }
        } else {
            return true
        }

    }

    func hasEmoji(_ str: String) -> Bool {
        let pattern =
            "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return pred.evaluate(with: str)
    }

    func isChinise(_ text: String) -> Bool {
        let pred = NSPredicate(format: "SELF MATCHES %@", chinisePattern)
        return pred.evaluate(with: text)
    }

    func isNumber(_ text: String) -> Bool {
        let pred = NSPredicate(format: "SELF MATCHES %@", numberPattern)
        return pred.evaluate(with: text)
    }

    func isLegal(_ text: String) -> Bool {
        var reusult = true
        let pred = NSPredicate(format: "SELF MATCHES %@", legalPattern)
        for char in text {
            reusult = pred.evaluate(with: "\(char)")
            if reusult == false {
                return reusult
            }
        }
        return reusult
    }

    // 移除非法词汇
    func removeLegalWords(_ text: String) -> String {
        let pred = NSPredicate(format: "SELF MATCHES %@", legalPattern)
        var charStr = ""
        for char in text {
            // 如果能过就拼接
            if pred.evaluate(with: "\(char)") {
                charStr.append(char)
            }
        }

        return charStr
    }

    override init() {

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //    1、匹配中文:[\u4e00-\u9fa5]
    //
    //    2、英文字母:[a-zA-Z]
    //
    //    3、数字:[0-9]
    //
    //    4、匹配中文，英文字母和数字及下划线：^[\u4e00-\u9fa5_a-zA-Z0-9]+$
    //    同时判断输入长度：
    //    [\u4e00-\u9fa5_a-zA-Z0-9_]{4,10}
    //
    //    5、
    //    (?!_)　　不能以_开头
    //    (?!.*?_$)　　不能以_结尾
    //    [a-zA-Z0-9_\u4e00-\u9fa5]+　　至少一个汉字、数字、字母、下划线
    //    $　　与字符串结束的地方匹配
    //
    //    6、只含有汉字、数字、字母、下划线，下划线位置不限：
    //    ^[a-zA-Z0-9_\u4e00-\u9fa5]+$
    //
    //    7、由数字、26个英文字母或者下划线组成的字符串
    //    ^\w+$
    //
    //    8、2~4个汉字
    //    "^[\u4E00-\u9FA5]{2,4}$";
    //
    //    9、最长不得超过7个汉字，或14个字节(数字，字母和下划线)正则表达式
    //    ^[\u4e00-\u9fa5]{1,7}$|^[\dA-Za-z_]{1,14}$
    //
    //
    //    10、匹配双字节字符(包括汉字在内)：[^x00-xff]
    //    评注：可以用来计算字符串的长度（一个双字节字符长度计2，ASCII字符计1）
    //
    //    11、匹配空白行的正则表达式：ns*r
    //    评注：可以用来删除空白行
    //
    //    12、匹配HTML标记的正则表达式：<(S*?)[^>]*>.*?|<.*? />
    //    评注：网上流传的版本太糟糕，上面这个也仅仅能匹配部分，对于复杂的嵌套标记依旧无能为力
    //
    //    13、匹配首尾空白字符的正则表达式：^s*|s*$
    //    评注：可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式
    //
    //    14、匹配Email地址的正则表达式：^[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$
    //
    //    评注：表单验证时很实用
    //
    //    15、手机号：^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\d{8}$
    //
    //    16、身份证：(^\d{15}$)|(^\d{17}([0-9]|X|x)$)
    //
    //    17、匹配网址URL的正则表达式：[a-zA-z]+://[^s]*
    //    评注：网上流传的版本功能很有限，上面这个基本可以满足需求
    //
    //    18、匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
    //    评注：表单验证时很实用
    //
    //
    //    19、匹配国内电话号码：d{3}-d{8}|d{4}-d{7}
    //    评注：匹配形式如 0511-4405222 或 021-87888822
    //
    //    20、匹配腾讯QQ号：[1-9][0-9]{4,}
    //    评注：腾讯QQ号从10000开始
    //
    //    21、匹配中国邮政编码：[1-9]d{5}(?!d)
    //    评注：中国邮政编码为6位数字
    //
    //    22、匹配身份证：d{15}|d{18}
    //    评注：中国的身份证为15位或18位
    //
    //    23、匹配ip地址：d+.d+.d+.d+
    //    评注：提取ip地址时有用
    //
    //
    //    24、匹配特定数字：
    //    ^[1-9]d*$　 　 //匹配正整数
    //    ^-[1-9]d*$ 　 //匹配负整数
    //    ^-?[1-9]d*$　　 //匹配整数
    //    ^[1-9]d*|0$　 //匹配非负整数（正整数 + 0）
    //    ^-[1-9]d*|0$　　 //匹配非正整数（负整数 + 0）
    //    ^[1-9]d*.d*|0.d*[1-9]d*$　　 //匹配正浮点数
    //    ^-([1-9]d*.d*|0.d*[1-9]d*)$　 //匹配负浮点数
    //    ^-?([1-9]d*.d*|0.d*[1-9]d*|0?.0+|0)$　 //匹配浮点数
    //    ^[1-9]d*.d*|0.d*[1-9]d*|0?.0+|0$　　 //匹配非负浮点数（正浮点数 + 0）
    //    ^(-([1-9]d*.d*|0.d*[1-9]d*))|0?.0+|0$　　//匹配非正浮点数（负浮点数 + 0）
    //    评注：处理大量数据时有用，具体应用时注意修正
    //
    //
    //    25、匹配特定字符串：
    //    ^[A-Za-z]+$　　//匹配由26个英文字母组成的字符串
    //    ^[A-Z]+$　　//匹配由26个英文字母的大写组成的字符串
    //    ^[a-z]+$　　//匹配由26个英文字母的小写组成的字符串
    //    ^[A-Za-z0-9]+$　　//匹配由数字和26个英文字母组成的字符串
    //    ^w+$　　//匹配由数字、26个英文字母或者下划线组成的字符串
    //
    //    26、
    //    在使用RegularExpressionValidator验证控件时的验证功能及其验证表达式介绍如下:
    //    只能输入数字：“^[0-9]*$”
    //    只能输入n位的数字：“^d{n}$”
    //    只能输入至少n位数字：“^d{n,}$”
    //    只能输入m-n位的数字：“^d{m,n}$”
    //    只能输入零和非零开头的数字：“^(0|[1-9][0-9]*)$”
    //    只能输入有两位小数的正实数：“^[0-9]+(.[0-9]{2})?$”
    //    只能输入有1-3位小数的正实数：“^[0-9]+(.[0-9]{1,3})?$”
    //    只能输入非零的正整数：“^+?[1-9][0-9]*$”
    //    只能输入非零的负整数：“^-[1-9][0-9]*$”
    //    只能输入长度为3的字符：“^.{3}$”
    //    只能输入由26个英文字母组成的字符串：“^[A-Za-z]+$”
    //    只能输入由26个大写英文字母组成的字符串：“^[A-Z]+$”
    //    只能输入由26个小写英文字母组成的字符串：“^[a-z]+$”
    //    只能输入由数字和26个英文字母组成的字符串：“^[A-Za-z0-9]+$”
    //    只能输入由数字、26个英文字母或者下划线组成的字符串：“^w+$”
    //    验证用户密码:“^[a-zA-Z]w{5,17}$”正确格式为：以字母开头，长度在6-18之间，
    //    只能包含字符、数字和下划线。
    //    验证是否含有^%&',;=?$"等字符：“[^%&',;=?$x22]+”
    //    只能输入汉字：“^[u4e00-u9fa5],{0,}$”
    //    验证Email地址：“^w+[-+.]w+)*@w+([-.]w+)*.w+([-.]w+)*$”
    //    验证InternetURL：“^http://([w-]+.)+[w-]+(/[w-./?%&=]*)?$”
    //    验证身份证号（15位或18位数字）：“^d{15}|d{}18$”
    //    验证一年的12个月：“^(0?[1-9]|1[0-2])$”正确格式为：“01”-“09”和“1”“12”
    //    验证一个月的31天：“^((0?[1-9])|((1|2)[0-9])|30|31)$”
    //    正确格式为：“01”“09”和“1”“31”。
    //    匹配中文字符的正则表达式： [u4e00-u9fa5]
    //    匹配双字节字符(包括汉字在内)：[^x00-xff]
    //    匹配空行的正则表达式：n[s| ]*r
    //    匹配HTML标记的正则表达式：/<(.*)>.*|<(.*) />/
    //    匹配首尾空格的正则表达式：(^s*)|(s*$)
    //    匹配Email地址的正则表达式：w+([-+.]w+)*@w+([-.]w+)*.w+([-.]w+)*
    //    匹配网址URL的正则表达式：http://([w-]+.)+[w-]+(/[w- ./?%&=]*)?
}

public extension UITextView {
   
}


 
protocol TextInputRuleDelegate  {
    func limitLength(by rule: String?, maxLength: Int?)
}

extension TextInputRuleDelegate where Self: UITextView  {
    func limitLength(by rule: String?, maxLength: Int?) {
        if let marked = self.markedTextRange {
            if let text_marked =  self.text(in: marked) {
                if let oriText: NSString = self.text as NSString? {
                    let no_marked = oriText.replacingOccurrences(of: text_marked, with: "")
                    
                    if let subStr = no_marked.apply(rule: rule, maxLength: maxLength) {
                        if subStr == no_marked {
                            //Note: import
                            return
                        }
                        self.text = subStr
                        try? self.setMarkedText(text_marked, selectedRange: NSMakeRange(subStr.count, text_marked.count))
                    }
                }
            }
        }
        else {
            if let text = self.text as NSString? {
                if let subStr: NSString = text.apply(rule: rule, maxLength: maxLength) as NSString? {
                    if (subStr.isEqual(to: text as String) == false) {
                        self.text = subStr as String
                    }
                }
            }
        }
    }
}



extension TextInputRuleDelegate where Self: UITextField {
    
    func limitLength(by rule: String?, maxLength: Int?) {
        if let marked = self.markedTextRange {
            if let text_marked =  self.text(in: marked) {
                if let oriText: NSString = self.text as NSString? {
                    let no_marked = oriText.replacingOccurrences(of: text_marked, with: "")
                    
                    if let subStr = no_marked.apply(rule: rule, maxLength: maxLength) {
                        if subStr == no_marked {
                            //Note: import
                            return
                        }
                        self.text = subStr
                        try? self.setMarkedText(text_marked, selectedRange: NSMakeRange(subStr.count, text_marked.count))
                    }
                }
            }
        }
        else {
            if let text = self.text as NSString? {
                if let subStr: NSString = text.apply(rule: rule, maxLength: maxLength) as NSString? {
                    if (subStr.isEqual(to: text as String) == false) {
                        self.text = subStr as String
                    }
                }
            }
        }
    }
}


private extension NSString {
    func apply(rule: String?, maxLength: Int?) -> String? {
        var subStr: NSString = self
        if let r = rule,r.count > 0 {
            let range = self.range(of: r, options: .regularExpression)
            if range.location != NSNotFound {
                subStr = self.substring(with: range) as NSString
            } else {
                subStr = ""
            }
        }
        
        if let ml = maxLength, ml > 0, subStr.length > ml {
            subStr = subStr.substring(to: ml) as NSString
        }
        return subStr as String
    }
}

