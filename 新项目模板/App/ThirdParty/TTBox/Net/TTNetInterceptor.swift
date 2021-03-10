//
//  TTNetInterceptor.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/1/22.
//

import Foundation

// 拦截器
final class TTNetInterceptor: RequestInterceptor {
    var retryList = [Request]()
    
    // 前置拦截器填入token
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        
        var urlRequest = urlRequest
        if TTNetManager.shared.token.count > 0 && !urlRequest.url!.absoluteString.contains("api/v1/auth/refresh") {
            // 有token加上token
            urlRequest.headers.add(.authorization(bearerToken: TTNetManager.shared.token))
            print("拦截器里的token是 \(TTNetManager.shared.token)")
        }
        
        completion(.success(urlRequest))
    }

    func updateTokenInHeader(_ request: Request) {
        if var baseRequst = request.request {
            if !baseRequst.url!.absoluteString.contains("api/v1/auth/refresh") {
                baseRequst.headers.update(.authorization(bearerToken: TTNetManager.shared.token))
                print("更新headers里的token，且headers为\(request.request?.headers)")
            }
        }
    }
   
    // 报错后，后置拦截器决定是否重新请求
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        // 没有在刷新token,那么开始刷新token
        if !TTNetManager.shared.fetchingToken {
            TTNetManager.shared.fetchingToken = true
            
            // 暂停当前刷新的请求
            request.suspend()

            // 先订阅，且获取到token后，重发请求
            TTNetManager.shared.retryTringOut.subscribe {[weak self] (result) in guard let self = self else { return }

                // 更新当前请求的token后再尝试
                self.updateTokenInHeader(request)
                
                // 根据情况决定是否重发请求
                completion(result.element!)
                
                for listRequest in self.retryList {
                    self.updateTokenInHeader(listRequest)
                    // 重新请求
                    listRequest.resume()
                }
                
                // 变更标志位
                TTNetManager.shared.fetchingToken = false
                
                
                // 释放掉监听
                TTNetManager.shared.retryDisposeBag = DisposeBag()
                
                // 移除数组中的请求
                self.retryList.removeAll()
            }.disposed(by:TTNetManager.shared.retryDisposeBag)
            
            // 发送刷新token信号
            TTNetManager.shared.retryTringIn.onNext(request)
        }else {
            // 否则将其他的reques保存起来
//            completion(.doNotRetry)
            
            
            
            print("装载到数组了")
            retryList.append(request)
        }
        
    }
}
