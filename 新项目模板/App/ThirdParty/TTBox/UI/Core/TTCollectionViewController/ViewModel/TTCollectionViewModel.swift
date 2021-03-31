//
//  TTCollectionViewModel.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/15.
//

import Foundation


// 数据状态
enum TTAutoRefreshDataState {
    case updated // 更新完了数据
    case noMore // 没有更多数据了
    case empty // 空数据了
    case error // 数据请求报错了
}

class TTAutoRefreshViewModel: ViewModel {
    // 数据源,我默认跟HandyJson耦合了，所有下拉刷新控件模型对象必须用HandyJson
    private var _data : [HandyJSON]
    {
        set {
            // 如果是初始页,那么就直接赋值
            if page == sourcePageIndex {
                data = newValue
            }else {
                // 如果是footer刷新就拼接,所有数据
                data.append(contentsOf: newValue)
            }
        
            
            // 空数组
            if data.count == 0 {
                dataEvent.onNext(.empty)
            }else if newValue.count < pageSize {
                // 如果小于了一页了，就尾部停止刷新
                dataEvent.onNext(.noMore)
            }else if data.count == pageSize{
                // 否则就是大于等于一页，就是更新
                dataEvent.onNext(.updated)
            }
            
            items.onNext(data)
        }
        get {
          return data
        }
    }
    

    // 数据源
    var items = PublishSubject<[HandyJSON]>.init()

    // 刷新头或者刷新尾刷新事件
    var refreshEvent = PublishSubject<Int>()

    // 初始页index,默认0
    private var sourcePageIndex = 0
    
    // 一页的items数量
    var pageSize = 20
    
    // viewModel的一些事件
    var dataEvent = PublishSubject<TTAutoRefreshDataState>()
    
    // 页码,默认从0开始
   private var dataSourceType = 0
    
    override func setupViewModel() {
        super.setupViewModel()
        
        // 刷新事件订阅
        refreshEvent.subscribe(onNext: {[weak self]  (refreshType) in guard let self = self else { return }
            self.disposePlainDataSource(refreshType)
        },onError: { (error) in
            self.dataEvent.onNext(.error)
        }).disposed(by: rx.disposeBag)
    }
    
    // 处理平铺类型数据源
    func disposePlainDataSource(_ refreshType: Int)  {
        // 0下拉刷新,page置为初始值，1是上拉刷新,上拉时初始化页码
        if refreshType == 0 {
            self.page = self.sourcePageIndex
        }

        // 获取列表数据
        self.fetchData {[weak self] (result, models)  in guard let self = self else { return }
            if result && models != nil {
                // 触发计算属性
                self._data = models!
                
                // 每次网络请求成功page + 1,下次上拉网络请求直接用这个page
                self.page += 1
            }else {
                self.dataEvent.onNext(.error)
            }
        }
    }
    
    // 变更初始页码
    func changeSourcePageIndex(_ number: Int) {
        sourcePageIndex = number
    }
    
    // 通用获取列表数据
    func fetchData(compltetBlock: @escaping (_ result: Bool,_ models: [HandyJSON]?) -> ()) {
        
    }
}



