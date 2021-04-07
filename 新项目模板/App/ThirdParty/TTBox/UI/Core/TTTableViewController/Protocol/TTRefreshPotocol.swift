//
//  File.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/3/29.
//

import Foundation


enum TTAutoRefreshState {
    case neitherHeaderFooter // 没有刷新头也没有尾巴
    case headerAndFooter // 有刷新头和刷新尾部
    case justHeader // 只有刷新头
    case justFooter // 只有刷新尾部
    case endReFresh //停止刷新状态,没有刷新头要加刷新头和刷新尾部
    case noMore // 无更多数据
    case empty // 无数据状态
    case error // 报错状态
}


// 自动刷新协议
protocol TTAutoRefreshProtocol: UIScrollView {
    // 头部刷新事件
    var headerRefreshEvent: PublishSubject<Int> { get set }
    
    //  尾部刷新事件
    var footerRefreshEvent: PublishSubject<Int> { get set }
    
    
    
    
    // 头部刷新结束事件
    var headerEndRefreshEvent: PublishSubject<()> { get set }
    
    //  尾部刷新结束事件
    var footerEndRefreshEvent: PublishSubject<()> { get set }
    
    
    
    
    // 刷新控件状态
    func refreshHeaderOrFooterState(_ state: TTAutoRefreshState)
    
    /**
     刷新时执行刷新信号,刷新信号去执行ViewModel里的fetchData，自动控制页码和数据源
     空页面展示
     */
    var state: TTAutoRefreshState { get set }
    
    
    // 添加footer
    func addFooter()
}

extension TTAutoRefreshProtocol {
    func refreshHeaderOrFooterState(_ state: TTAutoRefreshState)  {
        switch state {
        case .neitherHeaderFooter:
            mj_header = nil
            mj_footer = nil
        case .headerAndFooter:
            addHeader()
            addFooter()
        case .justHeader:
            mj_footer = nil
            addHeader()
        case .justFooter:
            mj_header = nil
            addFooter()
        case .endReFresh:
            mj_header?.endRefreshing(completionBlock: { [weak self]  in guard let self = self else { return }
                self.headerEndRefreshEvent.onNext(())
            })
            
            addFooter()
            mj_footer?.endRefreshing(completionBlock: { [weak self]  in guard let self = self else { return }
                self.footerEndRefreshEvent.onNext(())
            })
        case .noMore:
            // 防止没有尾部
            addFooter()
            self.mj_footer!.endRefreshingWithNoMoreData()
            
            mj_header?.endRefreshing(completionBlock: { [weak self]  in guard let self = self else { return }
                self.headerEndRefreshEvent.onNext(())
            })
            
            
            // 没有更多数据的时候才显示刷新尾
            mj_footer?.isHidden = false
        case .empty:
            mj_header?.endRefreshing(completionBlock: { [weak self]  in guard let self = self else { return }
                self.headerEndRefreshEvent.onNext(())
            })
            
            addFooter()
            self.mj_footer!.endRefreshingWithNoMoreData()
        case .error:
            
            addFooter()
            self.mj_footer!.endRefreshingWithNoMoreData()
            
            // 单纯取消刷新
            mj_header?.endRefreshing(completionBlock: { [weak self]  in guard let self = self else { return }
                self.headerEndRefreshEvent.onNext(())
            })
        }
    }
    
    func addHeader() {
        if self.mj_header == nil {
            self.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {[weak self]  in guard let self = self else { return }
                print("头部刷新事件")
                self.headerRefreshEvent.onNext((0))
            })
            
        }
    }
    
    func addFooter() {
        // 尾部默认开始是隐藏的
        if mj_footer == nil {
            if let footerClass = TTTableViewConfigManager.shared.refreshFooterClass {
                let footer = footerClass.init(refreshingBlock: {[weak self]  in guard let self = self else { return }
                    print("尾部刷新事件")
                    self.footerRefreshEvent.onNext((1))
                })
                
                mj_footer = footer
            }
        }
    }
}

