//
//  TTNet.swift
//  TTBox
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
    
    // 消息key默认message
    var errorMessageKey = "error_message"
    
    // 成功code，默认200
    var successCode = 200
    
    // 默认需要添加参数
    var defaultParams: [String : Any]?
    
    // 网络请求token
//    var token =  ""
    
    // 初始化超时时间，默认10秒
    var timeOutInterval = 10.0
    
    // 授权头关键词
    var authorizationWords = ""
    
    // 拦截器,有需要再用
//    var interceptor: TTNetInterceptor?
    
    var authenticator = TTAuthenticator()
    
    // 无需token的api
    var doNotNeedTokenApi = [""]
    
    
    
    // token刷新用的授权器，处理复杂token刷新状况
    lazy var interceptor: AuthenticationInterceptor<TTAuthenticator> = {
        let a = AuthenticationInterceptor(authenticator: authenticator, credential: authenticator.credential, refreshWindow: .init(interval: TTNetManager.shared.timeOutInterval, maximumAttempts: 1))
        return a
    }()

    
    // 头部
    var headers: HTTPHeaders  =  [
        "Accept" : "application/json",
        "sn-common": "version=\(AppVersion)&app=20200901&channel=app_store"
    ]
    
    
    // 是否需要带上Accept
    var dynamicAccept: Bool = false
    
    // 服务器时间,为本地时间戳 * 1000
    var serverTime: TimeInterval = Date().timeIntervalSince1970 * 1000.0
        
    // 网络请求成功结果全局传出去
    let responseSuccessSingle = PublishSubject<(AFDataResponse<Any>,TTNetModel)>()
    
    // 网络请求失败结果全局传出去
    let responseFailSingle = PublishSubject<(AFDataResponse<Any>,TTNetModel)>()
    
    
    // 网络管理者
    var networkManager: YYReachability!
    // 网络状态
    var netStatus = YYReachabilityStatus.wiFi
    {
        didSet {
            netStatutsSingle.onNext(self.netStatus)
        }
    }
    
    // 网络状态信号
    let netStatutsSingle = PublishSubject<YYReachabilityStatus>()
    
    // 是否打开log
    var openLog: Bool{
        #if DEBUG
        return true
        #endif
        return false
    }
    
    // 初始化网络配置
    func setupNetConfigure(domain: String,codeKey: String = "code",dataKey: String = "data",messageKey: String = "message",errorMessageKey: String = "error_message",successCode: Int,defaultParams: [String : String]? = nil, token: String,authorizationWords: String = "Bearer") {
        self.domain = domain
        self.codeKey = codeKey
        self.dataKey = dataKey
        self.messageKey = messageKey
        self.errorMessageKey = errorMessageKey
        self.successCode = successCode
        self.defaultParams = defaultParams
        self.authorizationWords = authorizationWords
        
        

        // 每秒加服务器时间
        Observable<Int>.timer(RxTimeInterval.seconds(0), period: RxTimeInterval.seconds(1), scheduler: MainScheduler.instance).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            
            // 服务器时间是时间戳 * 1000,所以步进是1000
            self.serverTime += 1000
        }).disposed(by: rx.disposeBag)
        
        
        networkManager = YYReachability.init()
        networkManager.notifyBlock = { [weak self]  (reachability) in guard let self = self else { return }
                var message = ""
                switch reachability.status {
                case .none:
                    message = "无法连接网络,请检查..."
                case .WWAN:
                    message = "蜂窝移动网络,注意节省流量..."
                case .wiFi:
                    message = "WIFI-网络,使劲造吧..."
                default:
                    break
                }
            // 赋值网络状态
            self.netStatus = reachability.status
        }

    }
}

extension TTNetManager {
    // 快速取token
    var accessToken: String {
        return authenticator.credential.accessToken
    }
    
    var refreshToken: String {
        return authenticator.credential.refreshToken
    }
    
    func updateToken(accessToken: String,refreshToken: String) {
        authenticator.credential.accessToken = accessToken
        authenticator.credential.refreshToken = refreshToken
        
        // 更新并赋值
        interceptor.credential = authenticator.credential
    }
    
    // 清除token
    func clearToken() {
        updateToken(accessToken: "", refreshToken: "")
    }
}


