//
//  TTNet.swift
//  TTBox
//
//  Created by Mr.hong on 2021/4/20.
//

import Foundation

class TTNet: NSObject {
    //MARK: - 请求,根据type来决定请求
    class func requst(type: HTTPMethod = .post, api: String, parameters:[String : Any]? = nil,secret: Bool = false,encoding: ParameterEncoding? = nil) -> Single<TTNetModel> {
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
            
            
            var headers = TTNetManager.shared.headers
            
            // 如果动态accept
            if TTNetManager.shared.dynamicAccept && type == .get{
                headers.remove(name: "Accept")
            }else {
                headers.update(name: "Accept", value: "application/json")
            }
     
            AF.request(fullApi,method: type,parameters:fullParameters,encoding: encoding,headers: headers ,interceptor: TTNetManager.shared.doNotNeedTokenApi.contains(api) || TTNetManager.shared.interceptor.credential?.refreshToken == nil ? nil : TTNetManager.shared.interceptor) { request in
                request.timeoutInterval = TTNetManager.shared.timeOutInterval
            }.validate().responseJSON { (response) in
                if TTNetManager.shared.openLog {
                    
                    if let jsonStr = response.value as? [String : Any],(jsonStr.jsonString() != nil) {
                        print("🔥接口\(fullApi) 参数为\(String(describing: fullParameters))  响应内容为 \(jsonStr))\n ------------------------ ")
                    }
                    
               
                }
                
                switch response.error {
                case .sessionInvalidated(_),.explicitlyCancelled:
                    // 网络请求取消了，就不提示处理了
                    return
                default:
                    break
                }
                
                // 处理数据
                self.disposeResponse(single, response,api: fullApi,parameters: fullParameters)
            }
            
            return Disposables.create {}
        }.observeOn(MainScheduler.instance)
    }
    
    
//    // 普通post网络请求
//    class func testRequst(api: String, parameters:[String : Any]? = nil,secret: Bool = false,queue: DispatchQueue,specialCodeModifier: RequestSpecialCodeModifier? = nil,encoding: ParameterEncoding = JSONEncoding()) -> Single<TTNetModel> {
//        return Single<TTNetModel>.create {(single) -> Disposable in
//
//
//            // 拼接完整api,参数
//            let fullApi = TTNetManager.shared.domain + api
//
//            // 是否加密，获取完整参数
//            let fullParameters = secretParams(sourceParameters: parameters,secret: secret)
//
//
//            // 参数编码
//            var encoding: ParameterEncoding = JSONEncoding.default
//            // get 请求要使用默认编码格式
//            encoding = URLEncoding.default
//            debugdebugPrint("接口\(fullApi)完整参数为\(fullParameters)")
//
//
//            AF.request(fullApi,method: .get,parameters:fullParameters,encoding: encoding,headers: nil,interceptor: TTNetManager.shared.interceptor){ request in
//                request.timeoutInterval = TTNetManager.shared.timeOutInterval
//            }.validate().response(queue: .global(), completionHandler: { (response) in
//
//
//                // 返回模型
//                var dataModel = TTNetModel.init()
//
//                single(.success(dataModel))
//                debugPrint("11111111")
//                debugPrint(response)
//            }).responseJSON { (response) in
//                // 处理数据
//                self.disposeResponse(single, response,api: api,parameters: parameters,specialCodeModifier: specialCodeModifier)
//            }
//            return Disposables.create {}
//        }.observeOn(MainScheduler.instance)
//    }
    
    
    // 普通post网络请求
//    class func normalrequst(api: String, parameters:[String : Any]? = nil,secret: Bool = false,specialCodeModifier: RequestSpecialCodeModifier? = nil,encoding: ParameterEncoding = JSONEncoding()) -> Single<TTNetModel> {
//        return Single<TTNetModel>.create {(single) -> Disposable in
//
//            AF.request(api,method: .post,parameters:parameters,encoding: encoding,headers: nil,interceptor: TTNetManager.shared.interceptor){ request in
//                request.timeoutInterval = TTNetManager.shared.timeOutInterval
//            }.validate().responseJSON { (response) in
//                // 处理数据
//                self.disposeResponse(single, response,api: api,parameters: parameters,specialCodeModifier: specialCodeModifier)
//            }
//            return Disposables.create {}
//        }.observeOn(MainScheduler.instance)
//    }
    
    // 处理返回的模型
    class func disposeResponse(_ single: @escaping (SingleEvent<PrimitiveSequence<SingleTrait, TTNetModel>.Element>) ->(), _ response: AFDataResponse<Any>,api: String,parameters: [String : Any]?,needSourceParams: Bool = false) {
        switch response.result {
        case .success:
            
            // 返回模型
            var dataModel = TTNetModel.init()
            
            // 字典转模型
            if let dataDic = response.value as? [String : Any] {

                // 取出对应的data，key，message
                dataModel.data = dataDic[TTNetManager.shared.dataKey] as? [String : Any] ?? [String : Any]()
                dataModel.code = dataDic[TTNetManager.shared.codeKey] as? Int ?? -111111
                dataModel.message = dataDic[TTNetManager.shared.messageKey] as? String ?? ""
                
                
                // 如果需要原始参数
                if needSourceParams {
                    dataModel.sourceParams = parameters
                }
                
                
                // 是否完全请求成功code无异常
                if dataModel.realSuccuss {
                    single(.success(dataModel))
                }else {
                    if TTNetManager.shared.openLog {
                        print("接口报错了🔥🔥🔥\(api)\n 错误信息是: code - \(dataModel.code) - \(dataModel.message)\n 参数是\(String(describing: parameters ?? ["" : ""]))")
                    }
                    single(.error(TTNetError.init(dataModel.message, dataModel.code)))
                }
            }else {
                single(.error(TTNetError.init("模型解析失败了,后台需要检查数据结构")))
            }
            
            TTNetManager.shared.responseSuccessSingle.onNext((response,dataModel))
        case .failure:
            // 先判断网络状态
            let defaltErrorMessage = "网络报错了,请检查网络或稍后尝试~"
            switch TTNetManager.shared.netStatus {
            case .none:
                showError(defaltErrorMessage)
                single(.error(TTNetError.init(defaltErrorMessage)))
                return
            default:
                break
            }
            
            let dataModel = TTNetModel()
            dataModel.message = defaltErrorMessage
            
            if let dataDic = response.data?.toDictionary()  {
                // 取出对应的data，key，message
                dataModel.code = dataDic[TTNetManager.shared.codeKey] as? Int ?? -111191
                if let message = dataDic[TTNetManager.shared.errorMessageKey] as? String {
                    dataModel.message = message
                }
            }
            
            // 如果默认消息,那么就赋值error
            if dataModel.message == defaltErrorMessage {
                #if DEBUG
                // debug模式把message恢复
                dataModel.message = response.description
                print("网络报错\(dataModel.message)")
                #endif
            }
            
            single(.error(TTNetError.init(dataModel.message,dataModel.code)))
      
            
            // 将每一次成功的请求传出去
            TTNetManager.shared.responseFailSingle.onNext((response,dataModel))
            
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


