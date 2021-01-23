//
//  123.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/1/22.
//

import Foundation

class TTNetModel: NSObject {
    var code: Int = 0
    var data = [String : Any]()
    var message = ""
    
    // 计算属性，是否真的成功了
    var realSuccuss: Bool {
        get {return code == TTNetManager.shared.successCode}
    }
    
    // 原参数
    var sourceParams: [String : Any]?
    
    // 保存原请求
    var sourceRequest: URLRequest?
}


struct TTNetError : LocalizedError {
    
    /// 描述
    var desc = "未知错误"
    
    /// 原因
    var reason = ""
    
    /// 建议
    var suggestion = ""
    
    /// 帮助
    var help = ""
    
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
}