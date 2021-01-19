//
//  TTAutoRefreshTableView.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/1/19.
//

import UIKit

class TTAutoRefreshTableView: TTTableView {
    enum TTAutoRefreshTableViewState {
        case neitherHeaderFooter // 没有刷新头也没有尾巴
        case headerAndFooter // 有刷新头和刷新尾部
        case justFooter // 只有刷新尾部
        case endReFresh //停止刷新状态
        case noData // 无数据状态
    }
    
    // 头部刷新事件
    var headerRefreshEvent = BehaviorRelay(value: 1)
    
    //  尾部刷新事件
    var footerRefreshEvent = BehaviorRelay(value: 1)
    
    // 添加刷新头刷新尾
    /**
     刷新时执行刷新信号,刷新信号去执行ViewModel里的fetchData，自动控制页码和数据源
     空页面展示
     */
    
    var state = TTAutoRefreshTableViewState.neitherHeaderFooter
    {
        didSet {
            switch self.state {
            case .neitherHeaderFooter:
                self.mj_header = nil
                self.mj_footer = nil
            case .headerAndFooter:
//                self.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {[weak self]  in guard let self = self else { return }
//                    self.headerRefreshEvent.accept(1)
//                })
//                self.addFooter()
                break
            case .justFooter:
                self.mj_header = nil
                self.addFooter()
            case .endReFresh:
                self.mj_header?.endRefreshing()
                self.mj_footer?.endRefreshing()
                
            case .noData: break
            default:break
            }
        }
    }
    
    // 添加footer
    func addFooter() {
        self.mj_footer = MJRefreshAutoFooter.init(refreshingBlock: {[weak self]  in guard let self = self else { return }
            self.footerRefreshEvent.accept(2)
        })
    }
    
    // 根据状态初始化
    init(cellClassNames: [String], style: UITableView.Style = .plain,state: TTAutoRefreshTableViewState) {
        super.init(cellClassNames: cellClassNames, style: style)
        self.state = state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
