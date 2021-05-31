//
//  TTTimer.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/5/31.
//

import Foundation


class TTTimer: NSObject {
    static let shared = TTTimer()
    static let timer = Observable<Int>.timer(RxTimeInterval.seconds(0), period: RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
    
    
  
}
