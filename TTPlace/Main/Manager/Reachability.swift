//
//  Reachability.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 1/4/17.
//  Copyright © 2017 Khoren Markosyan. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

// An observable that completes when the app gets online (possibly completes immediately).
func connectedToInternet() -> Observable<Bool> {
    return ReachabilityManager.shared.reach
}

private class ReachabilityManager: NSObject {

    static let shared = ReachabilityManager()

    let reachSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    var reach: Observable<Bool> {
        return reachSubject.asObservable()
    }
    
    // 网络状态
    var netStatus = YYReachabilityStatus.wiFi
    private let reachability =  YYReachability()

    override init() {
        super.init()
        reachability.notifyBlock = { [weak self]  (reachability) in guard let self = self else { return }
//                var message = ""
                switch reachability.status {
                case .none:
//                    message = "无法连接网络,请检查..."
                    self.reachSubject.onNext(false)
                case .WWAN:
//                    message = "蜂窝移动网络,注意节省流量..."
                    self.reachSubject.onNext(true)
                case .wiFi:
//                    message = "WIFI-网络,使劲造吧..."
                    self.reachSubject.onNext(true)
                default:
                    break
                }
            

            // 赋值网络状态
//            self.netStatus = reachability.status
        }
        
        
        
        NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { (status) in
            switch status {
            case .notReachable:
                self.reachSubject.onNext(false)
            case .reachable:
                self.reachSubject.onNext(true)
            case .unknown:
                self.reachSubject.onNext(false)
            }
        })
    }
}
