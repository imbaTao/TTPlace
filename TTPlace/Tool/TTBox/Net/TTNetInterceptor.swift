//
//  TTNetInterceptor.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/1/22.
//

import Foundation

// 拦截器
final class TTNetInterceptor: RequestInterceptor {
    // 外部订阅这个信号
    var retryDisposeBag = DisposeBag()
    
    // 前置拦截器填入token
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
         urlRequest.headers.add(.authorization(bearerToken: TTNetManager.shared.token))
        completion(.success(urlRequest))
    }

    
    // 报错后，后置拦截器决定是否重新请求
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // 没有在刷新token,那么开始刷新token
        if !TTNetManager.shared.fetchingToken {
            TTNetManager.shared.fetchingToken = true
            
            // 外部执行获取token请求
            TTNetManager.shared.retryTringIn.onNext(request)
            
            // 获取到token后，重发请求
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
