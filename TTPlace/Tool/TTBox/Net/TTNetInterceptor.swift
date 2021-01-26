//
//  TTNetInterceptor.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/1/22.
//

import Foundation

// 拦截器
final class TTNetInterceptor: RequestInterceptor {
    
//    enum TTNetInterceptorState {
//        case decideRetry // 决定重试上次请求
//        case decideDoNotRetry // 决定不要重试上次请求
//        case decideDoNotRetryWithError(error: TTNetError) // 决定不要重试且直接发送个错误
//    }
    
    // 外部订阅这个信号
    var retryDisposeBag = DisposeBag()
    

    
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
         urlRequest.headers.add(.authorization(bearerToken: TTNetManager.shared.token))
        completion(.success(urlRequest))
    }

    
    // 报错后会进入retry
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if !TTNetManager.shared.fetchingToken {
            TTNetManager.shared.fetchingToken = true
            TTNetManager.shared.retryTringIn.onNext(request)
            
            
            // 订阅消息token刷新完后的事件
            TTNetManager.shared.retryTringOut.subscribe {[weak self] (result) in guard let self = self else { return }

                // 根据情况决定是否重发请求
                completion(result.element!)

                TTNetManager.shared.fetchingToken = false
                
                // 释放掉监听
                self.retryDisposeBag = DisposeBag()
            }.disposed(by:retryDisposeBag)
        }else {
            completion(.doNotRetry)
        }
    }
}
