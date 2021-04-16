//
//  TTNetInterceptor.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/1/22.
//

import Foundation

// 网络拦截器
class TTNetInterceptor: RequestInterceptor {
    // 是否正在重新尝试获取token中
    var fetchingToken = false {
        didSet {
            if fetchingToken {
                refreshTokenAction()
            }else {
                retryRequestAction()
            }
        }
    }
    var retryList = [Request]()
    
    // 前置拦截器填入token
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
    
    }


    // 报错后，后置拦截器决定是否重新请求
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
     
    }
    
    func refreshTokenAction() {
        
    }
    
    func retryRequestAction() {
        
    }
}


