//
//  AccountInfo.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/10/22.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation

// 用户账号信息模型，包含用户信息，和当前账号状态等
struct AccountInfo {
  var isLogin = false;
  var user = UserInfo()
}

// 用户信息
struct UserInfo {
  var ID = "0";
  var name = "";
}

// 初始化用户信息,这个对象是必须存在的,设想每个互联网app主体都得有用户管理
var Account = setupAccountInfo()
func setupAccountInfo() -> AccountInfo{
    return AccountInfo();
}

var USER: UserInfo {
    get {
       return Account.user
    }
}

// 有的app可以切换账号，有多个账号管理，预留这个接口
func setupAccountList() {
    
}
