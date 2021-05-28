//
//  TTNetAuthAuthenticator.swift
//  TTBox
//
//  Created by Mr.hong on 2021/4/20.
//

import Foundation

// 验证头
struct TTAuthCredential: AuthenticationCredential {
    var accessToken = UserDefaults.standard.string(forKey: "a_ccess_Token") ?? "" {
        didSet {
            UserDefaults.standard.setValue(accessToken, forKey: "a_ccess_Token")
            UserDefaults.standard.synchronize()
        }
    }
    var refreshToken = UserDefaults.standard.string(forKey: "re_fresh_Token") ?? "" {
        didSet {
            UserDefaults.standard.setValue(refreshToken, forKey: "re_fresh_Token")
            UserDefaults.standard.synchronize()
        }
    }
    
    var userID: String = ""
    var expiration: Date = Date()
    
    // Require refresh if within 5 minutes of expiration
    var requiresRefresh: Bool { false }
}





class TTAuthenticator: Authenticator{
    var credential: TTAuthCredential!
    init(_ credential: TTAuthCredential = TTAuthCredential()) {
        self.credential = credential
    }
    
    
    func apply(_ credential: TTAuthCredential, to urlRequest: inout URLRequest) {
        // 添加头部
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
    }
    
    func refresh(_ credential: TTAuthCredential, for session: Session, completion: @escaping (Result<TTAuthCredential, Error>) -> Void) {
        // 刷新token
        /// block回调后调用completion
        ///
    }

    
    func didRequest(_ urlRequest: URLRequest,
                    with response: HTTPURLResponse,
                    failDueToAuthenticationError error: Error) -> Bool {

        // If authentication server CANNOT invalidate credentials, return `false`
        //        return false
        
        // If authentication server CAN invalidate credentials, then inspect the response matching against what the
        // authentication server returns as an authentication failure. This is generally a 401 along with a custom
        // header value.
        
        // 后台规定，401是用户身份验证失败
        return   response.statusCode == 401
    }
    
    
    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: TTAuthCredential) -> Bool {
        
        // 效验token是否是当前的token
        // If authentication server CANNOT invalidate credentials, return `true`
        // If authentication server CAN invalidate credentials, then compare the "Authorization" header value in the
        // `URLRequest` against the Bearer token generated with the access token of the `Credential`.
        let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        return urlRequest.headers["Authorization"] == bearerToken
    }
}
