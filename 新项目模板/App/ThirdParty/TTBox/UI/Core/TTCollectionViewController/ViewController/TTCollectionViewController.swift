//
//  TTCollectionViewController.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/15.
//

import Foundation

/// MARK: - 自动刷新协议
protocol BindAutoRefresh: TTViewController {
    // 主要刷新视图
    var mainRefreshView: UIScrollView&TTAutoRefreshProtocol {get}
    
    // 绑定刷新头/尾事件
    func bindRefreshHeaderOrFooter()
    
    // 开始刷新，有头部刷新优先头部，反之尾部
    func beginRefresh()
}

extension BindAutoRefresh {
    func bindRefreshHeaderOrFooter() {
        // 绑定信号等
        if let viewModel = viewModel as? TTAutoRefreshViewModel {
            
            // 下拉刷新绑定vm的刷新
            mainRefreshView.headerRefreshEvent.bind(to: viewModel.refreshEvent).disposed(by: rx.disposeBag)
            mainRefreshView.footerRefreshEvent.bind(to: viewModel.refreshEvent).disposed(by: rx.disposeBag)
            
            // vm网络请求产生的事件
            viewModel.dataEvent.subscribe(onNext: {[weak self] (state) in guard let self = self else { return }
                switch state {
                case .noMore:
                    self.mainRefreshView.refreshState = .noMore
                case .updated:
                    self.mainRefreshView.refreshState = .endReFresh
                case .error:
                    self.mainRefreshView.refreshState = .error
                case .empty:
                    self.mainRefreshView.refreshState = .empty
                }
            },onError: { (error) in
                // 网络请求报错
                self.mainRefreshView.refreshState = .error
            }).disposed(by: rx.disposeBag)
        }
        
        
        
        // 头部结束刷新回调
        mainRefreshView.headerEndRefreshEvent.subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            self.mainRefreshView.reloadEmptyDataSet()
        }).disposed(by: rx.disposeBag)
        
        // 尾部结束刷新回调
        mainRefreshView.footerEndRefreshEvent.subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            self.mainRefreshView.reloadEmptyDataSet()
        }).disposed(by: rx.disposeBag)
        

        // 默认开始刷新
        beginRefresh()
        
        // 网络监听
        netStatusObserver()
    }
    
    
    
    // 开始刷新
    func beginRefresh() {
        if mainRefreshView.mj_header != nil {
            mainRefreshView.mj_header?.beginRefreshing()
            return
        }
        
        if mainRefreshView.mj_footer != nil {
            mainRefreshView.mj_footer?.beginRefreshing()
            return
        }
    }
    
    // 监听网络状态
    func netStatusObserver() {
        TTNetManager.shared.netStatutsSingle.subscribe(onNext: {[weak self] (status) in guard let self = self else { return }
            // 网络状态变了,刷新视图
            self.mainRefreshView.reloadEmptyDataSet()
        }).disposed(by: rx.disposeBag)
    }
    
}

class TTCollectionViewController: TTViewController,BindAutoRefresh,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    // 有刷新控件的视图
    var mainRefreshView: UIScrollView & TTAutoRefreshProtocol {
        return collectionView
    }
    
    lazy var collectionView: TTCollectionView = {
        let view = TTCollectionView()
        return view
    }()
    
    var isNeedShowEmptyData = false {
        didSet {
            collectionView.emptyDataSetSource = isNeedShowEmptyData ? self : nil
            collectionView.emptyDataSetDelegate = isNeedShowEmptyData ? self : nil
            // 刷新empty数据
            collectionView.reloadEmptyDataSet()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func makeUI() {
        super.makeUI()
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // config
        // 默认有刷新头
        mainRefreshView.refreshState = .justHeader
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        bindRefreshHeaderOrFooter()
    }
    
    
    override func reloadDataSource() {
        super.reloadDataSource()
        self.beginRefresh()
    }
}

//MARK: - 空视图
extension TTCollectionViewController {
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let content: String!
        switch TTNetManager.shared.netStatus {
        case .unknown,.notReachable:
            // 无网络
            content = TTTableViewConfigManager.shared.notNetworkemptyText
        case .reachable(.cellular),.reachable(.ethernetOrWiFi):
            // 有网络,为无内容文本
            content = TTTableViewConfigManager.shared.notDataEmptyText
        }
        
        let desAtt = NSMutableAttributedString.init(string: content)
        
        // 设置字体颜色
        desAtt.font = TTTableViewConfigManager.shared.desFont
        desAtt.color = TTTableViewConfigManager.shared.desColor
        return desAtt
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return TTTableViewConfigManager.shared.notDataEmptyIcon
    }
    
    // 图片渲染色
    //    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
    //        return .gray
    //    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }
    
    
    // 按钮背景色@objc(buttonImageForEmptyDataSet:forState:)
    func buttonImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> UIImage! {
        switch TTNetManager.shared.netStatus {
        case .unknown,.notReachable:
            // 无网络
            return TTTableViewConfigManager.shared.buttonBackgroundImage
        case .reachable(.cellular),.reachable(.ethernetOrWiFi):
            // 有网络,为无内容文本
            return UIImage()
        }
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 0
    }
    
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        
        // 如果本来就可见，就直接可见
        if scrollView.isEmptyDataSetVisible {
            return true
        }
        
        // 有头或者尾，在刷新中就不显示空页面
        if let header = scrollView.mj_header {
            if header.state == .refreshing {
                return false
            }
        }
        
        if let footer = scrollView.mj_footer {
            if footer.state == .refreshing {
                return false
            }
        }
        return true
    }
    
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let content: String!
        switch TTNetManager.shared.netStatus {
        case .unknown,.notReachable:
            // 无网络
            content = TTTableViewConfigManager.shared.buttonTitle
        case .reachable(.cellular),.reachable(.ethernetOrWiFi):
            // 有网络,设置按钮为空
            content = ""
        }
        
        let buttonTitleAtt = NSMutableAttributedString.init(string: content)
        
        // 设置字体颜色
        buttonTitleAtt.font = TTTableViewConfigManager.shared.buttonFont
        buttonTitleAtt.color = TTTableViewConfigManager.shared.buttonTitleColor
        return buttonTitleAtt
    }
}



class TTAutoRefreshCollectionViewController: TTCollectionViewController {
    override func makeUI() {
        super.makeUI()
        isNeedShowEmptyData = true
        
        // 默认有刷新头
        mainRefreshView.refreshState = .justHeader
    }
}
