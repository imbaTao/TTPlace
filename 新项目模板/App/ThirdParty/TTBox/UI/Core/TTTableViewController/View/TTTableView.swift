//
//  TTTableView.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

import UIKit

// 静态列表模型
class TTTableViewStaticListModel: NSObject{
    var iconName = ""
    var mainContent = ""
    var subContent = ""
    
    // common value
    var type = 0
    var value = ""

}


class TTTableView: UITableView,TTAutoRefreshProtocol {
    var headerRefreshEvent = PublishSubject<Int>()
    var footerRefreshEvent = PublishSubject<Int>()
    var state: TTAutoRefreshState = .empty  {
        didSet {
            refreshHeaderOrFooterState(self.state)
        }
    }
    
    // 带默认的cell的cell类型数组
    lazy var cellClassNames: [String] = {
        var cellClassNames = ["TTTableViewCell"]
        return cellClassNames
    }()
    
    // 根据状态初始化
    init(cellClassNames: [String], style: UITableView.Style = .plain,state: TTAutoRefreshState) {
        super.init(frame: CGRect.zero, style: style)
        self.cellClassNames.append(contentsOf: cellClassNames)
        uiConfig()
        registerCell()
        self.state = state
        
        self.refreshHeaderOrFooterState(state)
    }

    
    init(cellClassNames:[String], style: UITableView.Style) {
        super.init(frame: CGRect.zero, style: style)
        self.cellClassNames.append(contentsOf: cellClassNames)
        uiConfig()
        registerCell()
    }
    
    init () {
        super.init(frame: CGRect(), style: .grouped)
    }

    override init(frame: CGRect = CGRect.zero, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        uiConfig()
    }
    
    
    func uiConfig() {
        // 默认背景色白色
        self.backgroundColor = .white
        
        // 隐藏横向和纵向的指示条
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        
        // 设置默认自动frame转约束为false, 目前主要用snp或者masonry
        self.translatesAutoresizingMaskIntoConstraints = false;
        
        
        if #available(iOS 11.0, *){
          
           
//            automaticallyAdjustsScrollViewInsets = false;
            
        }
        
        if #available(iOS 13.0, *) {
            automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            // Fallback on earlier versions
        }
        
        estimatedSectionHeaderHeight = 0
        estimatedSectionFooterHeight = 0
        estimatedRowHeight = UITableView.automaticDimension
        contentInsetAdjustmentBehavior = .never;
        rowHeight = UITableView.automaticDimension
        backgroundColor = .clear
        cellLayoutMarginsFollowReadableWidth = false
        keyboardDismissMode = .onDrag
        separatorColor = .white
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        separatorStyle = .none
        
        
        
    }
    
    func registerCell() {
        // 遍历传进来需要注册的类
//        for name in self.cellClassNames {
//            // 判断xib文件是否存在
//           
//            if Bundle.main.path(forResource: name, ofType: "nib") != nil {
//                // 存在注册xib
//                self.register(UINib.init(nibName: name, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: name)
//            }else {
//                // 注册cell类别 & 判断类是否存在
//                let appName = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
//                if  let cellClass: AnyClass = NSClassFromString(appName + "." + name) {
//                    self.register(cellClass,forCellReuseIdentifier: name)
//                }
//            }
//        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


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
            mj_header?.endRefreshing()
            mj_footer?.endRefreshing()
            
            // 成功刷新数据的时候，不显示尾部，自动滑动加载
            mj_footer?.isHidden = true
        case .noMore:
            mj_header?.endRefreshing()
            addFooter()
            mj_footer?.endRefreshing()
            mj_footer?.endRefreshingWithNoMoreData()
            
            // 没有更多数据的时候才显示刷新尾
            mj_footer?.isHidden = false
        case .empty:
            mj_header?.endRefreshing()
            mj_footer?.endRefreshing()
            mj_footer = nil
        case .error:
            // 单纯取消刷新
            mj_header?.endRefreshing()
            mj_footer?.endRefreshing()
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


