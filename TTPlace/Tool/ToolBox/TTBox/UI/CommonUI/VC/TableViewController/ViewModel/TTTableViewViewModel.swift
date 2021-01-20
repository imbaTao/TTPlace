//
//  TTTableViewViewModel.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit
import RxSwift
import HandyJSON

class TTAutoRefreshBaseModel: HandyJSON {
    required init() {
        
    }
}

class TTTableViewViewModel: ViewModel {
    
    // 数据状态
    enum TTTableViewViewModelDataState {
        case updated // 更新完了数据
        case noMore // 没有更多数据了
        case empty // 空数据了
    }
    
    
    // 数据源,我默认跟HandyJson耦合了，所有下拉刷新控件模型对象必须用HandyJson
    private var _data = [TTAutoRefreshBaseModel]()
    var data : [TTAutoRefreshBaseModel]
    {
        set {
            // 如果是初始页,那么就直接赋值
            if page == sourcePageIndex {
                _data = newValue
            }else {
                // 如果是footer刷新就拼接,所有数据
                _data.append(contentsOf: newValue)
               
                // 如果小于了一页了，就尾部停止刷新
                if newValue.count < pageSize {
                    dataEvent.onNext(.noMore)
                }
            }
            
            // 空数组
            if _data.count == 0 {
                dataEvent.onNext(.empty)
            }else {
                dataEvent.onNext(.updated)
            }
        }
        get {
          return [TTAutoRefreshBaseModel]()
        }
    }
    
    // 头部刷新事件
    var refreshEvent = PublishSubject<Int>.init()

    // 初始页index,默认0
    private var sourcePageIndex = 0
    
    // 一页的items数量
    var pageSize = 0
    
    // viewModel的一些事件
    var dataEvent = PublishSubject<TTTableViewViewModelDataState>()
    
    // 页码,默认从0开始
//    var page = 0
    
    
    override func setupViewModel() {
        super.setupViewModel()
        
        // 刷新事件订阅
        refreshEvent.subscribe(onNext: {[weak self] (type) in guard let self = self else { return }
            // 下拉刷新
            if type == 0 {
                self.page = 0
            }
            
            // 获取数据
            self.fetchData().subscribe { (netModel) in
                self.page += 1
            } onError: { (error) in
            }.disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)
        
    }
    
    // 变更初始页码
    func changeSourcePageIndex(_ number: Int) {
        sourcePageIndex = number
    }
    
    // 通用获取列表数据
    func fetchData() -> Single<[AnyClass]> {
        return Single.just([])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
