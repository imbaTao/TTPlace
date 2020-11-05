//
//  HTDataTool.swift
//  HotDate
//
//  Created by Mr.hong on 2020/9/3.
//  Copyright © 2020 刘超. All rights reserved.
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


