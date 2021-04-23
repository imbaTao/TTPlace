//
//  TTEnvironmentManager.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/4/23.
//

import Foundation
//enum TTEnvironmentStatus {
//    case debug
//    case release
//}


struct TTEnvironmentScene {
    // 域名选中
    var domainBit = 0
    var rongBit = 0
    var h5Bit = 0
}

class TTEnvironmentManager: NSObject {
    static let shared = TTEnvironmentManager()

    // 当前环境序列编号,0默认正式服
    var scene = TTEnvironmentScene()
    
    required override init() {
        super.init()
    }
    
    // 域名
    var domains = [String]()
    var domain: String {
        get {
            domains[scene.domainBit]
        }
    }
    


    // 融云key
    var rongKeys = [String]()
    var rongKey: String {
        get {
           return rongKeys[scene.rongBit]
        }
    }
    
    // H5的域名
    var h5Domains = [String]()
    var h5Domain: String! {
        get {
            return h5Domains[scene.h5Bit]
        }
    }
  
}
