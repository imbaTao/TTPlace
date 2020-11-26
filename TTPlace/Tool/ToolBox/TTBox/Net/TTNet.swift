//
//  TTNet.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/11/25.
//

import Foundation
import RxSwift
import Alamofire
import SwifterSwift
class TTNetModel: NSObject {
    var code: Int = 0
    var data = [String : Any]()
    var message = ""
    
    
    // 计算属性，是否真的成功了
    var realSuccuss: Bool {
        get {return code == TTNetManager.shared.successCode}
    }
}





// 初始化的时候,传入服务器制定的网络编码规则
class TTNetManager: NSObject {
    static let shared = TTNetManager()
    
    private static let tokenKey = "duyiwuerdeTokenKey"
    
    
    // domain
    var domain = ""
    
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
    func setupNetConfigure(domain: String,codeKey: String,dataKey: String,messageKey: String,successCode: Int,defaultParams: [String : String], token: String) {
        self.domain = domain
        self.codeKey = codeKey
        self.dataKey = dataKey
        self.messageKey = messageKey
        self.successCode = successCode
        self.defaultParams = defaultParams
        self.token = token
        
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
            // 拼接完整api,参数
            let fullApi = TTNetManager.shared.domain + api
            let fullParameters = addDefaultParams(sourceParameters: parameters)
            AF.request(fullApi,method: .get,parameters:fullParameters,encoding: JSONEncoding.default).responseJSON { (response) in
                
                // 返回模型
                let responseModel = TTNetModel.init()
    
                print("\(response.result)")
                
                switch response.result {
                    case .success:
                        // 字典转模型
                        if let data = response.value as? [String : Any] {
                            responseModel.data = data
                            responseModel.code = data[TTNetManager.shared.codeKey] as! Int
                            responseModel.message =  data[TTNetManager.shared.messageKey] as! String
                            
                            
                            // 如果不是最终成功,都算失败了
                            if responseModel.code != TTNetManager.shared.successCode {
                                single(.success(responseModel))
                            }else {
                                single(.error(TTNetError.init(responseModel.message)))
                            }
                        }
                    case .failure:
                        #if DEBUG
                        print("接口报错了🔥🔥🔥\(fullApi),参数是\(String(describing: fullParameters))")
                        #endif
                        
                        single(.error(TTNetError.init("网络报错了")))
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
            
            // 拼接完整api,参数
            let fullApi = TTNetManager.shared.domain + api
            let fullParameters = addDefaultParams(sourceParameters: parameters)
            AF.request(fullApi,method: .post,parameters:fullParameters,encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                    case .success:
                        // 生成数据模型
                        if let dataModel = self.disposeResponse(response) {
                            // 是否完全请求成功code无异常
                            if dataModel.realSuccuss {
                                single(.success(dataModel))
                            }else {
                                single(.error(TTNetError.init(dataModel.message)))
                            }
                        }else {
                            single(.error(TTNetError.init("模型解析失败了,后台需要检查数据结构")))
                        }
                    case .failure:
                        #if DEBUG
                        print("接口报错了🔥🔥🔥\(fullApi),参数是\(String(describing: fullParameters))")
                        #endif
                        
                        single(.error(TTNetError.init("网络报错了")))
                }
            }
            return Disposables.create {}
        }.observeOn(MainScheduler.instance)
    }
    
    
    // 处理返回的模型
   class func disposeResponse(_ response: AFDataResponse<Any>) -> TTNetModel? {
        // 字典转模型
        if let dataDic = response.value as? [String : Any] {
            
            // 返回模型
            let responseModel = TTNetModel.init()
            
            // 取出对应的data，key，message
            responseModel.data = dataDic[TTNetManager.shared.dataKey] as? [String : Any] ?? [String : Any]()
            responseModel.code = dataDic[TTNetManager.shared.codeKey] as? Int ?? -111111
            responseModel.message = dataDic[TTNetManager.shared.messageKey] as? String ?? ""
            return responseModel
        }
        return nil
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
                
                // 移除空key
                let hasEmptyKey = finalParamter?.keys.contains("")
                if hasEmptyKey == true {
                    finalParamter?.removeValue(forKey: "")
                }
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
