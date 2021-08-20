//
//  123.swift
//  TTBox
//
//  Created by Mr.hong on 2021/1/22.
//

import Foundation

// 这个模型用来装载返回结果
class TTNetModel: HandyJSON {
    var code: Int = 0
    var data = [String : Any]()
    
    // 元数据
    var sourceData: Any?
    var message = ""
    
    // 计算属性，是否真的成功了
    var realSuccuss: Bool {
        get {return code == TTNetManager.shared.successCode}
    }
    
    // 原参数
    var sourceParams: [String : Any]?
    
    // 保存原请求
    var sourceRequest: URLRequest?
    
    required init() {
        
    }
}


struct TTEmptyError : Error {
    
}

/// 报错结构体
struct TTNetError : Error {
    
    /// 描述
    var desc = "未知错误"
    
    /// 原因
    var reason = ""
    
    /// 建议
    var suggestion = ""
    
    /// 帮助
    var help = ""
    
    // 报错码
    var code = 400
    
    /// 必须实现，否则报The operation couldn’t be completed.
    var errorDescription: String? {
        return desc
    }
    
    var failureReason: String? {
        return reason
    }
    
    var recoverySuggestion: String? {
        return suggestion
    }
    
    var helpAnchor: String? {
        return help
    }
    
    init(_ desc: String) {
        self.desc = desc
    }
    
    init(_ desc: String,_ code: Int) {
        self.desc = desc
        self.code = code
    }
}
