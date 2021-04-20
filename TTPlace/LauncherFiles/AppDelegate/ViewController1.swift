//
//  ViewController1.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/10/26.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

//import UIKit
import Foundation
import RxSwift
import Alamofire
import SwiftyJSON
import Kingfisher
import RxCocoa
import HandyJSON
import SwiftyJSON


class ViewController: TTViewController {
    
}

class TTButton1: UIButton {
    
}
struct Profile: HandyJSON {
    var age: Int = 0
    var gender: Int = 1
    var hometown: Int = 1
    var latitude: Float = 0.0
    var location: String? = "暂无"
    var longitude: Float = 0.0
    var nick: String? = ""
    var photos_count: Int = 0
    var qrcode: String = ""
}

class User: HandyJSON {
    var __v: Int = 0
    var _id = ""
    var created_at: String?
    var current_token: String = ""
    var identity: Int = 0 // 这个是认证
    var mobile: String?
    var profile = Profile()
    var refresh_token: String = ""
    var register: Int = 0
    var rights: Int = 0
    var score: Int = 0
    
    
    var type: Int = 0 // 这个是身份
    var updated_at: String?
    
    // 主动禁言列表（单向）
    var muted = [User]()
    
    // 被禁言列表(单向)
    var be_muted = [User]()
    
    // 是否是加好友,微信好友发起人
    var isAddFriendInitiator = false
    
 
    required init() {
        
    }
}



class ViewController1: ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        
        let manager = TTNetManager.shared
        
        // 初始化网络管理者
        manager.setupNetConfigure(domain:"https://cc.shengu999.com", codeKey: "code", dataKey: "data", messageKey: "error_message", successCode: 0, token: "")
        
        
        
        // 加载拦截器
//        manager.interceptor = NetInterceptor()
        
        
        manager.doNotNeedTokenApi = [
            "/room/getRoomDetail"
        ]

        
        // Generally load from keychain if it exists
        let credential = OAuthCredential()

        // Create the interceptor
        let authenticator = OAuthAuthenticator()
        let interceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                    credential: credential)
        manager.interceptor2 = interceptor
        
        
        
        TTNet.requst(type:.post,api: "/room/getRoomDetail", parameters: [
            "osv": 23,
            "deviceId": "008796752342348",
            "sign": "5D2F62FCB5F74BAFAA86DE5CA2971786",
            "isE": "y",
            "appId": "qla",
            "roomId": 59875,
            "os": "android",
            "netStatus": "WIFI",
            "deviceInfos": "{\"appDeviceId\":\"00000178-e9b7-c71f-0000-00000001f5ae\",\"deviceBrand\":\"Android\",\"netInfo\":1,\"systemModel\":\"MuMu\",\"systemVersion\":\"6.0.1\"}",
            "t": 1618829992257,
            "appVersion": 10750,
            "imei": "008796752342348",
            "ip": "10.0.2.15",
            "channel": "xiaomi"
        ]).subscribe {[weak self] (model) in
        
        } onError: { (error) in
        
        }.disposed(by: rx.disposeBag)

    }
}




extension UIView {

    var inset: CGFloat {
        return 12
    }

}

extension UIColor {
    // 性别颜色， 男1，女2
   class func genderColor(_ gender: Int = 1) -> UIColor {
        if gender == 1 {
           return rgba(124, 200, 255, 1)
        }else {
          return rgba(255, 127, 182, 1)
        }
    }
    
    // 主要文本颜色
    static var mainStyleColor: UIColor {
        return #colorLiteral(red: 0.5607843137, green: 0.2509803922, blue: 0.9647058824, alpha: 1)
    }
    
    // 主要文本颜色
    static var mainTextColor: UIColor {
        return rgba(51, 51, 51, 1)
    }
    
    // 主要文本颜色2
    static var mainTextColor2: UIColor {
        return rgba(102, 102, 102, 1)
    }
    

}
