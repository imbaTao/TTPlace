//
//  IMUserManager.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/20.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import UIKit

class IMUserManager: NSObject,RCIMUserInfoDataSource {
   static let shared = IMUserManager()
    override  init() {
        super.init()
 
    }
    
    // 实现代理
    func getUserInfo(withUserId userId: String!, completion: ((RCUserInfo?) -> Void)!) {
        TTNet.requst(type:.get,api: "/api/v1/users/id是").mapModel(User.self).subscribe {[weak self] (model) in
            
            let userInfo = RCUserInfo.init(userId: model._id, name: model.profile.nick, portrait: model.profile.nick)
            userInfo?.extra = model.profile.toJSONString(prettyPrint: false)
            completion(userInfo)
        } onError: { (error) in
            // 给个默认的用户数据
//            let userInfo = RCUserInfo.init(userId: model._id, name: model.profile.nick, portrait: model.profile.nick)
            
        }.disposed(by: rx.disposeBag)
    }
}
