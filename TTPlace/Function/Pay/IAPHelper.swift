//
//  IAPHelper.swift
//  IAP
//
//  Created by lin bo on 2019/5/13.
//  Copyright © 2019 appTech. All rights reserved.
//

import UIKit
import StoreKit

/// 商品列表
enum PayType: String {
    case pay06 = "Pay_Coin06"
    case pay98 = "Pay_Coin061"
    case pay148 = "Pay_Coin062"
    case pay198 = "Pay_Coin063"
    case pay248 = "ACG_PAY_244"
    case pay298 = "ACG_PAY_295"

    
    // 返回定价
    func price() -> Int {
        switch self {
        case .pay06: return 6
        case .pay98: return 98
        case .pay148: return 148
        case .pay198: return 198
        case .pay248: return 248
        case .pay298: return 298
        }
    }
}

/// 回调状态
enum IAPProgress: Int {
    
    /// 初始状态
    case none
    /// 开始
    case started
    /// 购买中
    case purchasing
    
    /// 支付成功
    case purchased
    /// 失败
    case payFailed
    /// 重复购买
    case payRestored
    /// 状态未确认
    case payDeferred
    /// 其他
    
    case payOther
    /// 开始后端校验
    case checking
    /// 后端校验成功
    case checkedSuccess
    /// 后端校验失败
    case checkedFailed

}

enum IAPPayCheck {
    
    case busy /// 有支付正在进行
    case notInit /// 未初始化
    case initFailed /// 初始化失败
    case notFound /// 没有找到该商品，中断
    case systemFailed /// 系统检测失败
    case ok /// 可以进行

}

class IAPHelper: NSObject {
    
    static let shared = IAPHelper()
    
    /// 检测初始化回调
    fileprivate var checkBlock: ((_ b: IAPPayCheck) -> ())?
    /// 支付过程回调
    var resultBlock: ((_ type: IAPProgress, _ pID: PayType?) -> ())?
    
    /// 是否正在支付
    fileprivate var isBusy: Bool {
        get {
            switch progress {
            case .none:
                return false
            default:
                return true
            }
        }
    }
   
    /// 购买的状态
    fileprivate var progress: IAPProgress = .none {
        didSet {
            /// 状态改变回调
            if let block = resultBlock {
                block(progress, currentPID)
            }
        }
    }
    
    /// 当前付费的ID
    fileprivate var currentPID: PayType?
    /// 商品列表
    fileprivate var productList: [SKProduct]?

    /// 初始化配置，请求商品
    func config() {
        SKPaymentQueue.default().add(self)
        requestAllProduct()
    }
    
    
    /// 初始化，请求商品列表
    func initPayments(_ block: @escaping ((_ b: IAPPayCheck) -> ())) {
        config()
        
        let c = checkPayments()
        
        if c == .notInit {
            
            requestAllProduct()
            checkBlock = block

        }else {
            
            block(c)
        }
    }
    
    /// 检测支付环境，非.ok不允许充值
    func checkPayments() -> IAPPayCheck {
        
        guard isBusy == false else {
            return .busy
        }
        
        guard let plist = productList, !plist.isEmpty else {
            return .notInit
        }
        
        guard SKPaymentQueue.canMakePayments() else {
            return .systemFailed
        }
        
        return .ok
    }
    
    /// 请求商品列表
    private func requestAllProduct() {
        
        let set: Set<String> = [PayType.pay06.rawValue]
        
        let request = SKProductsRequest(productIdentifiers: set)
        request.delegate = self
        request.start()
    }
    
    /// 支付商品
    @discardableResult
    func pay(pID: PayType) -> IAPPayCheck {
        
        let c = checkPayments()
        
        if c == .ok {
            
            guard let plist = productList, !plist.isEmpty else {
                return .notInit
            }

            let pdts = plist.filter {
                return $0.productIdentifier == pID.rawValue
            }
            
            guard let product = pdts.first else {
                return .notFound
            }
            
            currentPID = pID
            requestProduct(pdt: product)
        }
        
        return c
    }
    
    /// 请求充值
    fileprivate func requestProduct(pdt: SKProduct) {
        
        progress = .started

        let pay: SKMutablePayment = SKMutablePayment(product: pdt)
        SKPaymentQueue.default().add(pay)
        
    }
    
    /// 重置
    fileprivate func payFinish() {
        currentPID = nil
        progress = .none
    }
    
    // 恢复事件
    func restoreAction() {
 
        SKPaymentQueue.default().restoreCompletedTransactions()
        
    }
    
    /// 充值完成后给后台校验
    func completeTransaction(_ checkList: [SKPaymentTransaction]) {
        
        if resultBlock == nil {
//            showAlert("充值校验中...")
        }
//        //ALog("充值校验中...")
        progress = .checking
        
        guard let rURL = Bundle.main.appStoreReceiptURL, let data = try? Data(contentsOf: rURL) else {
//            //ALog("appStoreReceiptURL error")
            
            progress = .checkedFailed
            payFinish()
            return
        }
        
        let str = data.base64EncodedString()
        print(str)
        
        print(checkList)
        
        
        // 后台检测url，成功后删除这个订单
        
//        OrderServer.shared.requestCheckIAP(str) { [weak self] (code, msg, result) in
//
//            guard let helper = self else {
//                return
//            }
//
//            if result { // 成功则删除
//                checkList.forEach({ (transaction) in
//                    SKPaymentQueue.default().finishTransaction(transaction)
//                })
//            }
//
//            if helper.resultBlock == nil {
//                showAlert(result ? "校验成功" : "校验失败")
//            }
//            //ALog(result ? "充值成功" : "充值失败")
//
//            helper.progress = result ? .checkedSuccess : .checkedFailed
//            helper.payFinish()
//        }
    }
}

// MARK: - SKProductsRequestDelegate
extension IAPHelper: SKProductsRequestDelegate {
    
    // 获取商品列表
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        print("---IAP---")

        if currentPID == nil {
            // 列表赋值
            productList = response.products
        }
    }
    
    
    // 请求完成
    func requestDidFinish(_ request: SKRequest) {
//        print("---IAP---")

        if currentPID == nil {
            
            if let block = checkBlock {
                
                if let pList = productList, !pList.isEmpty {
                    block(.ok)
                }else {
                    block(.initFailed)
                }
                checkBlock = nil
            }
        }
    }
    
    // 获取失败
    func request(_ request: SKRequest, didFailWithError error: Error) {
//        print("---IAP---")

        if currentPID == nil {
            
            if let block = checkBlock {
                block(.initFailed)
                checkBlock = nil
            }
        }
    }
}

// MARK: - SKPaymentTransactionObserver
extension IAPHelper: SKPaymentTransactionObserver {
    

    
//    restoreCompletedTransactionsFailedWithError
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedDownloads downloads: [SKDownload]) {
//        print("---IAP---")
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
//        print("---IAP---")
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        print("---IAP---")

        var checkList: [SKPaymentTransaction] = []
        var type: IAPProgress = progress

        for transaction in transactions {
            
            //ALog("支付结果: \(transaction.description)")

            let pid = transaction.payment.productIdentifier
            switch transaction.transactionState {
                
            case .purchasing:
                
                //ALog("支付中:\(pid)")
                type = .purchasing

            case .purchased:
                
                checkList.append(transaction)
                //ALog("支付成功:\(pid)")
                type = .purchased

            case .failed:
                
                //ALog("支付失败:\(pid)")
                type = .payFailed
                SKPaymentQueue.default().finishTransaction(transaction)

            case .restored:
                
                checkList.append(transaction)
                //ALog("支付已购买过:\(pid)")
                type = .payRestored

            case .deferred:
                
                //ALog("支付不确认:\(pid)")
                type = .payDeferred
                SKPaymentQueue.default().finishTransaction(transaction)

            @unknown default:
                
                //ALog("支付未知状态:\(pid)")
                type = .payOther
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
        
        progress = type
        
        if !checkList.isEmpty {
            // 有内购已经完成
            completeTransaction(checkList)
            
        }else if type == .purchasing {
            // 正常情况：内购正在支付
            // 特殊情况：若该商品已购买，未执行finishTransaction，系统会提示（免费恢复项目），回调中断
            // 解决方法：在应用开启的时候捕捉到restored状态的商品，提交后台校验后执行finishTransaction

        }else { // 其他状态
            
            payFinish()
        }
    }

    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("---IAP---")
        
     
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        print("---IAP---")
    }
    
    
    
    
    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        print("---IAP---")
        return true
    }
}
