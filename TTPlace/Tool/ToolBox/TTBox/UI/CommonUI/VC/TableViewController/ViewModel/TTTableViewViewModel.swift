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


class TTTableViewViewModel: ViewModel {
    
    // 数据状态
    enum TTTableViewViewModelDataState {
        case updated // 更新完了数据
        case noMore // 没有更多数据了
        case empty // 空数据了
        case error // 数据请求报错了
    }
    
    
    // 数据源,我默认跟HandyJson耦合了，所有下拉刷新控件模型对象必须用HandyJson
    private var _data = [HandyJSON]()
    private var data : [HandyJSON]
    {
        set {
            // 如果是初始页,那么就直接赋值
            if page == sourcePageIndex {
                _data = newValue
            }else {
                // 如果是footer刷新就拼接,所有数据
                _data.append(contentsOf: newValue)
            }
        
            
            // 空数组
            if _data.count == 0 {
                dataEvent.onNext(.empty)
            }else {
                dataEvent.onNext(.updated)
            }
            
            
            // 如果小于了一页了，就尾部停止刷新
            if newValue.count < pageSize {
                dataEvent.onNext(.noMore)
            }
            
            items.onNext(_data)
        }
        get {
          return [TTAutoRefreshBaseModel]()
        }
    }
    
    // 数据源
    var items = PublishSubject<[HandyJSON]>.init()
    
    
    // 头部刷新事件
    var refreshEvent = PublishSubject<Int>()

    // 初始页index,默认0
    private var sourcePageIndex = 0
    
    // 一页的items数量
    var pageSize = 20
    
    // viewModel的一些事件
    var dataEvent = PublishSubject<TTTableViewViewModelDataState>()
    
    // 页码,默认从0开始
//    var page = 0
    
    override func setupViewModel() {
        super.setupViewModel()
        
        // 刷新事件订阅
        refreshEvent.subscribe(onNext: {[weak self] (type) in
            // 0下拉刷新,page置为初始值，1是上拉刷新,上拉时初始化页码
            if type == 0 {
                self!.page = self!.sourcePageIndex
            }

            // 获取列表数据
            self!.fetchData {[weak self] (result, models)  in
                if result && models != nil {
                    self!.data = models!
                    
                    // 每次网络请求成功page + 1,下次上拉网络请求直接用这个page
                    self!.page += 1
                }else {
                    self!.dataEvent.onNext(.error)
                }
            }
        }).disposed(by: rx.disposeBag)
    }
    
    // 变更初始页码
    func changeSourcePageIndex(_ number: Int) {
        sourcePageIndex = number
    }
    
    // 通用获取列表数据
    func fetchData(compltetBlock: @escaping (_ result: Bool,_ models: [HandyJSON]?) -> ()) {
        
    }
    
}


class TTAutoRefreshBaseModel: HandyJSON {
    required init() {
        
    }
}
