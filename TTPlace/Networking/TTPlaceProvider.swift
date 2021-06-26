//
//  TTPlaceProvider.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/24.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

// NetworkAPI就是一个遵循TargetType协议的枚举
let provider = TTPlaceNetworking.defaultNetworking().provider


class OnlineProvider<Target> where Target: Moya.TargetType {
    fileprivate let provider: MoyaProvider<Target>
    fileprivate let online: Observable<Bool>
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
         session: Session = MoyaProvider<Target>.defaultAlamofireSession(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,online: Observable<Bool> = connectedToInternet()) {
        self.online = online
        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, session: session, plugins: plugins, trackInflights: trackInflights)
    }
    
    
    func request(_ token: Target) -> Observable<Moya.Response> {
        let actualRequest = provider.rx.request(token)
        return online
            .ignore(value: false)  // Wait until we're online
            .take(1)        // Take 1 to make sure we only invoke the API once.
            .flatMap { _ in // Turn the online state into a network request
                return actualRequest
                    .filterSuccessfulStatusCodes()
                    .do(onSuccess: { (response) in
                    }, onError: { (error) in
                        if let error = error as? MoyaError {
                            switch error {
                            case .statusCode(let response):
                                if response.statusCode == 401 {
                                    // 接口信息授权失败
                                    // Unauthorized
//                                    if AuthManager.shared.hasValidToken {
//                                        AuthManager.removeToken()
//                                        Application.shared.presentInitialScreen(in: Application.shared.window)
//                                    }
                                }
                            default: break
                            }
                        }
                    })
        }
    }
}



protocol ProductAPIType {
    var addXAuth: Bool { get }
}

// 网络协议
protocol NetworkingType {
    associatedtype T: TargetType
    var provider: OnlineProvider<T> { get }

    static func defaultNetworking() -> Self
    static func stubbingNetworking() -> Self
}


// 结构体
struct TTPlaceNetworking: NetworkingType {
    typealias T = TTPlaceAPI
    
    let provider: OnlineProvider<T>

    static func defaultNetworking() -> Self {
        return TTPlaceNetworking(provider: newProvider(plugins))
    }

    static func stubbingNetworking() -> Self {
        return TTPlaceNetworking(provider: OnlineProvider(endpointClosure: endpointsClosure(), requestClosure: TTPlaceNetworking.endpointResolver(), stubClosure: MoyaProvider.immediatelyStub, online: .just(true)))
    }

    func request(_ token: T) -> Observable<Moya.Response> {
        let actualRequest = self.provider.request(token)
        return actualRequest
    }
}


extension NetworkingType {
    static func endpointsClosure<T>(_ xAccessToken: String? = nil) -> (T) -> Endpoint where T: TargetType {
        return { target in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)

            // Sign all non-XApp, non-XAuth token requests
            return endpoint
        }
    }

    static func APIKeysBasedStubBehaviour<T>(_: T) -> Moya.StubBehavior {
        return .never
    }

    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
//        if Configs.Network.loggingEnabled == true {
//
//        }
        plugins.append(NetworkLoggerPlugin())
        return plugins
    }

    // (Endpoint<Target>, NSURLRequest -> Void) -> Void
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest() // endpoint.urlRequest
                request.httpShouldHandleCookies = false
                closure(.success(request))
            } catch {
//                logError(error.localizedDescription)
            }
        }
    }
}

private func newProvider<T>(_ plugins: [PluginType], xAccessToken: String? = nil) -> OnlineProvider<T>  {
    return OnlineProvider(endpointClosure: TTPlaceNetworking.endpointsClosure(xAccessToken),
                          requestClosure: TTPlaceNetworking.endpointResolver(),
                          stubClosure: TTPlaceNetworking.APIKeysBasedStubBehaviour,
                          plugins: plugins)
}

// MARK: - Provider support

func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject { }

    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}




/// 路径分割符
fileprivate let pathSplitSymbol: Character = ">"
extension ObservableType where Self.Element == Moya.Response {
    
    private func fetchTTNetModel(_ response: Moya.Response) -> TTNetModel? {
        // 网络模型
        var dataModel: TTNetModel?
        
        // 字典转模型
        if let dataDic = response.data.toOptionalDictionary() {
            // 取出对应的data，key，message
            dataModel?.data = dataDic[TTNetManager.shared.dataKey] as? [String : Any] ?? [String : Any]()
            dataModel?.code = dataDic[TTNetManager.shared.codeKey] as? Int ?? -111111
            dataModel?.message = dataDic[TTNetManager.shared.messageKey] as? String ?? ""
            return dataModel
        }else {
    //                single(.error(TTNetError.init("模型解析失败了,后台需要检查数据结构")))
        }
        return nil
    }

    
    
    internal func mapModel<T: HandyJSON>(_ type: T.Type, modelKey: String? = nil) -> Single<T> {
        return Single<T>.create {(single) -> Disposable in
                
            let _ = flatMap { (response) -> Single<T> in
                
                // 第一步解析获取
                if let netModel = self.fetchTTNetModel(response) {
                    
                    // 如果传入了key,就从data层往下开始解析
                    if let modelKey = modelKey {
                        // 按层级剥key
                        let keyArray = modelKey.split(separator: pathSplitSymbol)
                        var lastDic = [String : Any]()
                        
                        // 遍历到底层
                        for item in keyArray {
                            while let dic = netModel.data[String(item)] {
                                lastDic = dic as! [String : Any]
                                
                                // 能解析出来就跳出循环
                                break
                            }
                        }

                        // 如果转模型成功
                        if let model = type.model(lastDic) {
                            return Single.just(model)
                        }
                    }else {
                        // 如果转模型成功
                        if let model = type.model(netModel.data) {
                            return Single.just(model)
                        }
                    }
                }
                
                return Single.just(T())
            }
            
            
            return Disposables.create {}
        }.observeOn(MainScheduler.instance)
        
        

         
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
           
            return Single.just(T())
        }
    }
//    
//    
//    internal func mapModels<T: HandyJSON>(_ type: T.Type, modelKey: String) -> Single<[T]> {
//        return flatMap { (netModel) -> Single<[T]> in
//            
//            // 如果传入了key,就从data层往下开始解析
////            if let modelKey = modelKey {
//                let keyArray = modelKey.split(separator: pathSplitSymbol)
//                var lastDic = [Any]()
//                
//                // 遍历到底层
//                for item in keyArray {
//                    
//                    while let dic = netModel.data[String(item)] {
//                        lastDic = dic as! [Any]
//                        
//                        // 能解析出来就跳出循环,不能解析就是json字典结构有问题，检查key
//                        break
//                    }
//                }
//                
//                
//                if let lastDic = lastDic as? [[String : Any]] {
//                    
//                    // 如果转模型成功
//                    if let models = type.models(lastDic) {
//                        return Single.just(models)
//                    }
//                }
//            
//                // 否则返回一个空数组
//                return Single.just([])
//            }
//        }
//}




