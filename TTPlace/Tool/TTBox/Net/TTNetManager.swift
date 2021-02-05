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
import SwiftyJSON
import HandyJSON


// 初始化的时候,传入服务器制定的网络编码规则
class TTNetManager: NSObject {
    static let shared = TTNetManager()
    
    // domain域名
    var domain = ""
    
    // data的Key 默认data
    var dataKey = "data"
    
    // 请求结果代码key默认code
    var codeKey = "code"
    
    // 消息key默认message
    var messageKey = "message"
    
    // 成功code，默认200
    var successCode = 200
    
    // 默认需要添加参数
    var defaultParams: [String : Any]?
    
    // 网络请求token
    var token =  ""
    
    // 初始化超时时间，默认15秒
    var timeOutInterval = 15.0
    
    // 授权头关键词
    var authorizationWords = ""
    
    // 头部
    var headers: HTTPHeaders {
        get {
            return  [
                "Accept" : "application/json",
                "sn-common": "version=\(AppVersion)&app=20200901&channel=app_store"
            ]
        }
    }
    

    
    // token重连信号封装,自定义请求，包装成single
    let retryTringIn = PublishSubject<Request>()
    let retryTringOut = PublishSubject<RetryResult>()
    // 重试刷新token回收袋
    var retryDisposeBag = DisposeBag()
    // 是否正在重新尝试获取token中
    var fetchingToken = false
    
    // 初始化网络配置
    func setupNetConfigure(domain: String,codeKey: String = "code",dataKey: String = "data",messageKey: String = "message",successCode: Int,defaultParams: [String : String]? = nil, token: String,authorizationWords: String = "Bearer") {
        self.domain = domain
        self.codeKey = codeKey
        self.dataKey = dataKey
        self.messageKey = messageKey
        self.successCode = successCode
        self.defaultParams = defaultParams
        self.token = token
        self.authorizationWords = authorizationWords
        
        
       
    }
    
    // 更新网络请求token
    func updateToken(token: String) {
        self.token = token;
    }
}

class TTNet: NSObject {
    
    // 有特殊code需要处理的时候，就使用这个闭包，处理不同事件
    public typealias RequestSpecialCodeModifier = (inout TTNetModel) throws -> Void
    
    //MARK: - 请求,根据type来决定请求
    class func requst(type: HTTPMethod = .post, api: String, parameters:[String : Any]? = nil,secret: Bool = false,specialCodeModifier: RequestSpecialCodeModifier? = nil,encoding: ParameterEncoding? = nil) -> Single<TTNetModel> {
        return Single<TTNetModel>.create {(single) -> Disposable in
            
            // 拼接完整api,参数
            let fullApi = TTNetManager.shared.domain + api
            
            // 是否加密，获取完整参数
            let fullParameters = secretParams(sourceParameters: parameters,secret: secret)
            
            
            // 参数编码
            var encoding: ParameterEncoding = JSONEncoding.default
            if type == .get {
                // get 请求要使用默认编码格式
                encoding = URLEncoding.default
            }
            debugPrint("接口\(fullApi)完整参数为\(fullParameters)")
            AF.request(fullApi,method: type,parameters:fullParameters,encoding: encoding,headers: TTNetManager.shared.headers,interceptor: TTNetInterceptor()){ request in
                request.timeoutInterval = TTNetManager.shared.timeOutInterval
            }.validate().responseJSON { (response) in
                // 处理数据
                self.disposeResponse(single, response,api: fullApi,parameters: fullParameters,specialCodeModifier: specialCodeModifier)
            }
            return Disposables.create {}
        }.observeOn(MainScheduler.instance)
    }
    
    
    // 普通post网络请求
    class func normalrequst(api: String, parameters:[String : Any]? = nil,secret: Bool = false,specialCodeModifier: RequestSpecialCodeModifier? = nil,encoding: ParameterEncoding = JSONEncoding()) -> Single<TTNetModel> {
        return Single<TTNetModel>.create {(single) -> Disposable in
            
            AF.request(api,method: .post,parameters:parameters,encoding: encoding,headers: nil,interceptor: TTNetInterceptor()){ request in
                request.timeoutInterval = TTNetManager.shared.timeOutInterval
            }.validate().responseJSON { (response) in
                // 处理数据
                self.disposeResponse(single, response,api: api,parameters: parameters,specialCodeModifier: specialCodeModifier)
            }
            return Disposables.create {}
        }.observeOn(MainScheduler.instance)
    }
    
    // 处理返回的模型
    class func disposeResponse(_ single: @escaping (SingleEvent<PrimitiveSequence<SingleTrait, TTNetModel>.Element>) ->(), _ response: AFDataResponse<Any>,api: String,parameters: [String : Any]?,needSourceParams: Bool = false,specialCodeModifier: RequestSpecialCodeModifier? = nil) {
        switch response.result {
        case .success:
            // 字典转模型
            if let dataDic = response.value as? [String : Any] {
                
                // 返回模型
                var dataModel = TTNetModel.init()
                
                // 取出对应的data，key，message
                dataModel.data = dataDic[TTNetManager.shared.dataKey] as? [String : Any] ?? [String : Any]()
                dataModel.code = dataDic[TTNetManager.shared.codeKey] as? Int ?? -111111
                dataModel.message = dataDic[TTNetManager.shared.messageKey] as? String ?? ""
                
                
                // 如果需要原始参数
                if needSourceParams {
                    dataModel.sourceParams = parameters
                }
                
                
                #if DEBUG
                print("\(String(describing: JSON.init(from: response.data!)))")
                #endif
                
                // 是否完全请求成功code无异常
                if dataModel.realSuccuss {
                    single(.success(dataModel))
                }else {
                    #if DEBUG
                    print("接口报错了🔥🔥🔥\(api)\n 错误信息是: code - \(dataModel.code) - \(dataModel.message)\n 参数是\(String(describing: parameters ?? ["" : ""]))")
                    #endif
                    
                    // 非成功code
                    if specialCodeModifier != nil {
                        do {
                            try specialCodeModifier?(&dataModel)
                        } catch {
                            
                        }
                    }
                }
            }else {
                single(.error(TTNetError.init("模型解析失败了,后台需要检查数据结构")))
            }
        case .failure:
            
            if let responseBody = response.data {
                do {
                    let json = try JSON.init(data: responseBody)
                    
                    if let code: Int = json["code"].int {
                        
                        showHUD(json["error_message"].string ?? "网络报错了,请检查网络或稍后尝试")
                    }
                    
                    print(json)
                    single(.error(TTNetError.init(response.error?.errorDescription ?? "网络报错了,请检查网络或稍后尝试")))
                }catch{}
                
            }else {
                showHUD(response.error?.errorDescription ?? "网络报错了,请检查网络或稍后尝试")
                
                
                single(.error(TTNetError.init(response.error?.errorDescription ?? "网络报错了,请检查网络或稍后尝试")))
            }
        }
    }
    
    // 添加默认传给服务器的参数,与加密相关
    private class func secretParams(sourceParameters: [String : Any]?,secret: Bool) -> [String : Any]? {
        // 加密的话，就加参
        if secret {
            if sourceParameters != nil {
                var finalParamter = sourceParameters;
                finalParamter!["sign"] = self.encryption(paramaters: finalParamter!)
                return finalParamter
            }
        }else {
            return sourceParameters
        }
        return nil
    }
    
    
    //MARK: - 加密操作
    class func encryption(paramaters: [String : Any]) -> String {
        let dic = NSDictionary.init(dictionary: paramaters)
        let keyArray = dic.allKeysSorted()
        var itemsArray = [String]()
        
        for index in 0..<keyArray.count {
            let key = keyArray[index]
            let value = dic[key]!
            itemsArray.append("\(key)=\(value)")
        }
        
        // 最后再拼上一个secret
        itemsArray.append("secret=supernova")
        if itemsArray.count > 0 {
            var sign = itemsArray.joined(separator: "&") as NSString
            
            sign = sign.sha256()! as NSString
            return  sign as String
        }
        return "iOS端网络请求参数加密有错误"
    }
}
