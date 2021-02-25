//
//  AccountInfo.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/10/22.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation

// 用户账号管理者，包含用户信息，和当前账号状态等
class UserManager: NSObject {
    
    // 初始化单例
    static let shared = UserManager()
    
    // 是否登录了
    var isLogin = false;
    
    // 用户信息,一般包含token
    var user = UserInfo()
    
    // 初始化
    private override init() {
        super.init()
        
    }
}

// 方便拿到USER
var USER: UserInfo {
    get{
       return UserManager.shared.user
    }
}

// 用户信息
struct UserInfo {
    var ID = "0";
    var name = "";
}

// 有的app可以切换账号，有多个账号管理，预留这个接口
func setupAccountList() {
    
}
