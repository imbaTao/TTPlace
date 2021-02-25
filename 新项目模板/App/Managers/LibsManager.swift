//
//  LibsManager.swift
//  TTNew
//
//  Created by Mr.hong on 2020/11/23.
//

import Foundation
//import IQKeyboardManagerSwift
import Kingfisher



class LibsManager: NSObject {
    static let shared = LibsManager()
    
    
    // 初始化
    private override init() {
        super.init()
        
    }
    
    
    // 初始化三方库
    func setupLibs() {
        setupKeyboardManager()
        setupKingfisher()
    }
    
    
    // 初始化键盘管理
    func setupKeyboardManager() {
//        IQKeyboardManager.shared.enable = true
    }

    
    // 初始设置Kingfisher
    func setupKingfisher() {
        // Set maximum disk cache size for default cache. Default value is 0, which means no limit.
        ImageCache.default.diskStorage.config.sizeLimit = UInt(500 * 1024 * 1024) // 500 MB

        // Set longest time duration of the cache being stored in disk. Default value is 1 week
        ImageCache.default.diskStorage.config.expiration = .days(7) // 1 week

        // Set timeout duration for default image downloader. Default value is 15 sec.
        ImageDownloader.default.downloadTimeout = 15.0 // 15 sec
    }
}

