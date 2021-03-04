//
//  TTNetInterceptor.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/1/22.
//

import Foundation

// 拦截器
final class TTNetInterceptor: RequestInterceptor {

    
    // 前置拦截器填入token
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        
        var urlRequest = urlRequest
        if TTNetManager.shared.token.count > 0 {
            // 有token加上token
            urlRequest.headers.add(.authorization(bearerToken: TTNetManager.shared.token))
            
            
            print("token是 \(TTNetManager.shared.token)")
        }

        
        
        // 如果正在刷新token，那就监听token刷新完毕信号
//        if TTNetManager.shared.fetchingToken {
//            // 先订阅，且获取到token后，重发请求
//            TTNetManager.shared.retryTringOut.subscribe {[weak self] (result) in guard let self = self else { return }
//                switch result.element {
//                 case .retry:
//                    completion(.success(urlRequest))
//                 default:
//                    session.cancelAllRequests()
//                    break
//                }
//            }.disposed(by:TTNetManager.shared.retryDisposeBag)
//        }else {
            completion(.success(urlRequest))
//        }
    }

    
    // 报错后，后置拦截器决定是否重新请求
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // 没有在刷新token,那么开始刷新token
        if !TTNetManager.shared.fetchingToken {
            TTNetManager.shared.fetchingToken = true
            
            // 先订阅，且获取到token后，重发请求
            TTNetManager.shared.retryTringOut.subscribe {[weak self] (result) in guard let self = self else { return }

                // 根据情况决定是否重发请求
                completion(result.element!)

                TTNetManager.shared.fetchingToken = false
                
                // 释放掉监听
                TTNetManager.shared.retryDisposeBag = DisposeBag()
            }.disposed(by:TTNetManager.shared.retryDisposeBag)
            
            
            // 发送刷新token信号
            TTNetManager.shared.retryTringIn.onNext(request)
        }else {
            completion(.doNotRetry)
        }
    }
}
