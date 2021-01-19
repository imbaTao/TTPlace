//
//  TTTableViewViewModel.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit
import RxSwift

class TTTableViewViewModel: NSObject {
    
    // 头部刷新事件
    var refreshEvent = BehaviorRelay(value: 1)
    
    // 刷新结束事件
    var endRefreshEvent = BehaviorRelay(value: false)
    
    // 数据源
    var data = [AnyClass]()
    
    // 页码,默认从0开始
    var page = 0
    
    override init() {
        super.init()
        
        // 刷新事件订阅
        refreshEvent.subscribe(onNext: {[weak self] (type) in guard let self = self else { return }
            
            // 下拉刷新
            if type == 0 {
                self.page = 0
            }else {
            // 上拉刷新
                self.page += 1
            }
            
            // 获取数据
            self.fetchData().subscribe { (netModel) in
                // 刷新结束
                self.endRefreshEvent.accept(true)
            } onError: { (error) in
                
                // 刷新结束
                self.endRefreshEvent.accept(true)
            }.disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 通用获取列表数据
    func fetchData() -> Single<TTNetModel> {
        return Single<TTNetModel>.create {(single) -> Disposable in
            
            
            single(.success(TTNetModel()))
            return Disposables.create {}
        }.observeOn(MainScheduler.instance)
    }
    
}
