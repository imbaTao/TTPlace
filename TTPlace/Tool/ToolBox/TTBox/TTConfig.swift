//
//  TTConfig.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/1/25.


import Foundation

// 全局设置单例
class TTConfig: NSObject {
    static let shard = TTConfig()
    
    
    
    // tableViewModel,start page,pageSize
    var startPage = 0
    var pageSize = 20
    var pageKeyName = "page"
    var pageSizeKeyName = "pageSize"
}
