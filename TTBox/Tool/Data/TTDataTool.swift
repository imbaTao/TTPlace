//
//  TTDataTool.swift
//  HotDate
//
//  Created by Mr.hong on 2020/9/3.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import Foundation


let unreadNotifyChatModelPath = "unreadNotifyChatModel"


func saveModelData(_ model: Any,_ path: String) {
    var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    accountPath = (accountPath as NSString).appendingPathComponent(path)
    NSKeyedArchiver.archiveRootObject(model, toFile: accountPath)
}


func fetchModelData(_ path: String) -> Any? {
    var accountPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    accountPath = (accountPath as NSString).appendingPathComponent(path)
    let model = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath)
    return model as? Any
}

class TTCacheManager: NSObject {
   
    // 缓存某种类型的模型,是否缓存成功
    class func cacheSomeData(model: HandyJSON?,key: String,sync: Bool = false) {
        if let json = model?.toJSONString() {
            UserDefaults.standard.setValue(json, forKey: key)
            if sync {
                UserDefaults.standard.synchronize()
            }
        }else {
            // 清空操作
            UserDefaults.standard.setValue("", forKey: key)
        }
    }
    
    // 获取某个缓存模型
    class func fetchCacheData<T: HandyJSON>(type: T.Type,key: String) -> T? {
        if let cacheData = UserDefaults.standard.value(forKey: key) as? String {
            if let cacheModel = type.deserialize(from: cacheData) {
                return cacheModel
            }
        }
        
        return nil
    }
}


