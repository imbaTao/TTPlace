//
//  TTNet.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/11/25.
//

import Foundation
import RxSwift
import Alamofire

class TTNetModel: NSObject {
    var code: Int = 0
    var data: Data?
    var message = ""
}





// 初始化的时候,传入服务器制定的网络编码规则
class TTNetManager: NSObject {
    static let shared = TTNetManager()
    
    private static let tokenKey = "duyiwuerdeTokenKey"
    
    // data的Key
    var dataKey = "data"
    
    // 请求结果代码key
    var codeKey = "code"
    
    // 消息key
    var messageKey = "message"
    
    // 成功code
    var successCode: Int = 200
    
    // 默认参数
    var defaultParams = [String : Any]()
    
    // 一般app都得设置token
    var token = UD.value(forKey: tokenKey) ?? ""

    // token一般存在
    func setupNetConfigure(codeKey: String,dataKey: String,messageKey: String,successCode: Int,defaultParams: [String : String], token: String) {
        
    }
    
    
//    let headers = ["Authorization": token, "Content-Type": "application/json"]

//    Alamofire.request("http://localhost:8000/create", method: .post,  parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
//   }
    
    // 更新网络请求token
    func updateToken(token: String) {
        UD.setValue(token, forKey: TTNetManager.tokenKey)
    }
}

// 用户偏好设置
let UD = UserDefaults.standard


class TTNet: NSObject {
    class func getRequst(api: String, parameters:[String : Any]?) -> Single<TTNetModel> {
        return Single<TTNetModel>.create {(single) -> Disposable in
            AF.request(api,method: .get,parameters:addDefaultParams(sourceParameters: parameters),encoding: JSONEncoding.default).responseJSON { (reponse) in
                // 返回模型
                let responseModel = TTNetModel.init()
                responseModel.data = reponse.data

                switch reponse.result {
                    case .success: single(.success(responseModel))
                    case .failure: single(.error(TTNetError.init("网络报错了")))
                }
            }
            return Disposables.create {}
        }.observeOn(MainScheduler.instance)
    }
    
    
    // 无参数get请求
    class func getRequst(api: String) -> Single<TTNetModel> {
        return self.getRequst(api: api, parameters: nil)
    }
    
    // post请求
    class func postRequst(api: String,parameters: [String : Any]?) -> Single<TTNetModel> {
        return Single<TTNetModel>.create {(single) -> Disposable in
            AF.request(api,method: .post,parameters:addDefaultParams(sourceParameters: parameters),encoding: JSONEncoding.default).responseJSON { (reponse) in
                // 返回模型
                let responseModel = TTNetModel.init()
                responseModel.data = reponse.data

                switch reponse.result {
                    case .success: single(.success(responseModel))
                    case .failure: single(.error(TTNetError.init("网络报错了")))
                }
            }
            return Disposables.create {}
        }.observeOn(MainScheduler.instance)
    }
    
    // 无参数post请求
    class func postRequst(api: String) -> Single<TTNetModel> {
        return self.postRequst(api: api, parameters: nil)
    }
    
    
    
    // 添加默认传给服务器的参数
    private class func addDefaultParams(sourceParameters: [String : Any]?) -> [String : Any]? {
        var finalParamter = sourceParameters;
        
        if  sourceParameters != nil  && TTNetManager.shared.defaultParams.count > 0 {
            // 如果有默认参数
            if TTNetManager.shared.defaultParams.count > 0 {
                //合并两个字典
                finalParamter?.merge(TTNetManager.shared.defaultParams, uniquingKeysWith: { (key, value) -> Any in
                    return key
                })
            }
        }
        return finalParamter
    }
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
