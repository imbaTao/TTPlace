//
//  TTPlaceAPI.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/24.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
@_exported import Moya












enum TTPlaceAPI {
    case publishArticle(content: String)
}




extension TTPlaceAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .publishArticle(let content):
            return URL.init(string: "")!
        default:
            return TTNetManager.shared.domain.url!
            break
        }
    }
    
    var path: String {
        switch self {
        case .publishArticle:
            return ""
        default:
            break
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .publishArticle:
            return .post
        default:
            return .get
            break
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
//        if let token = AuthManager.shared.token {
//            switch token.type() {
//            case .basic(let token):
//                return ["Authorization": "Basic \(token)"]
//            }
//        }
        
        switch self {
        default:
            return ["Authorization": "Basic \("")"]
        }
        
        return nil
    }
}
