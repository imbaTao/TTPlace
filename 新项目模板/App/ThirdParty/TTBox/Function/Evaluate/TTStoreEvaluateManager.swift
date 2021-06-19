//
//  TTStoreEvaluateManager.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/6/19.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
import StoreKit

// 商店评价管理者
class TTStoreEvaluateManager: NSObject {
    static private let lastEvaluateTimeKey = "lastEvaluateTimeKey"
    
    // 评价
    class func evaluate() {
        let lastEvaluateTime = UserDefaults.standard.double(forKey: lastEvaluateTimeKey)
        
        // 上次有值
        let dateInterval = Date().timeIntervalSince1970
        
        if lastEvaluateTime > 0 {
            // 如果大于三个月，每年只能显示3次
            if dateInterval - lastEvaluateTime >= 86400 * 30 * 4 {
                showStoreView(dateInterval)
            }
        }else {
            // 首次直接评价
            showStoreView(dateInterval)
        }
    }
    
    
    private class func showStoreView(_ dateInterval: TimeInterval) {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
            UserDefaults.standard.setValue(dateInterval, forKey: lastEvaluateTimeKey)
            UserDefaults.standard.synchronize()
        } else {
            // Fallback on earlier versions
        }
    }
}
