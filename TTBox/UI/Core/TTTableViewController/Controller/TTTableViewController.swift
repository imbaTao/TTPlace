//
//  TTCommonTableViewController.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.



import UIKit

//,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource

class TTTableViewController: TTViewController,UITableViewDelegate, UIScrollViewDelegate {
    // 头部刷新开关
    let headerRefreshTrigger = PublishSubject<Void>()
    
    // 尾部刷新开关
    let footerRefreshTrigger = PublishSubject<Void>()
    
    // 是否在刷新头部
    let isHeaderLoading = BehaviorRelay(value: false)
    
    // 是否在刷新尾部
    let isFooterLoading = BehaviorRelay(value: false)
    
    lazy var tableView: TTTableView = {
        let tableView = TTTableView.init(cellClassNames: [""], style: .grouped)
//        tableView.emptyDataSetSource = self
//        tableView.emptyDataSetDelegate = self
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
        return tableView
    }()

    var isNeedShowEmptyData = false {
        didSet {
//            DispatchQueue.main.asyncAfter(deadline: .now()) {
//                self.tableView.emptyDataSetSource =  self.isNeedShowEmptyData ? self : nil
//                self.tableView.emptyDataSetDelegate =  self.isNeedShowEmptyData ? self : nil
//
//                // 刷新empty数据
////                self.tableView.reloadEmptyDataSet()
//            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        super.makeUI()
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        // 防止viewModel为nil
        if viewModel == nil {
            viewModel = TTViewModel()
        }
        
        

        
        
        // 绑定信号等
        if let viewModel = viewModel as? TTTableViewViewModel  {
            viewModel.headerLoading.asObservable().bind(to: isHeaderLoading).disposed(by: rx.disposeBag)
            viewModel.footerLoading.asObservable().bind(to: isFooterLoading).disposed(by: rx.disposeBag)
            
            // 下拉刷新事件
            tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {[weak self]  in guard let self = self else { return }
                self.headerRefreshTrigger.onNext(())
            })
            
            
            // 上拉刷新事件
//            tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {[weak self]  in guard let self = self else { return }
//                print("尾部刷新事件")
//                self.footerRefreshTrigger.onNext(())
//            })
            
            // 正在刷新对象信号，绑定mj的header/footer的控制
            isHeaderLoading.bind(to: tableView.mj_header!.rx.isAnimating).disposed(by: rx.disposeBag)
//            isFooterLoading.bind(to: tableView.mj_footer!.rx.isAnimating).disposed(by: rx.disposeBag)

            // 刷新empty事件
            let updateEmptyDataSet = Observable.of(isLoading.mapToVoid().asObservable()).merge()
            updateEmptyDataSet.subscribe(onNext: { [weak self] () in
//                self?.tableView.reloadEmptyDataSet()
            }).disposed(by: rx.disposeBag)
            
        
            
            // 下拉刷新绑定vm的刷新
//            tableView.headerRefreshEvent.bind(to: viewModel.refreshEvent).disposed(by: rx.disposeBag)
//            tableView.footerRefreshEvent.bind(to: viewModel.refreshEvent).disposed(by: rx.disposeBag)
            
            // vm网络请求产生的事件
//            viewModel.dataEvent.subscribe(onNext: {[weak self] (state) in guard let self = self else { return }
//                switch state {
//                case .noMore:
//                    self.tableView.refreshState = .noMore
//                case .updated:
//                    self.tableView.refreshState = .hasMoreData
//                case .error:
//                    self.tableView.refreshState = .endReFresh
//                case .empty:
//                    self.tableView.refreshState = .empty
//                default:break
//                }
//            },onError: { (error) in
//                // 网络请求报错
//                self.tableView.refreshState = .empty
//            }).disposed(by: rx.disposeBag)

        }
        
        
        
        // 默认下拉刷新
//        beginRefresh()
    }
    
    // 开始刷新
    func beginRefresh() {
        if tableView.mj_header != nil {
            tableView.mj_header?.beginRefreshing()
            return
        }
        
        if tableView.mj_footer != nil {
            tableView.mj_footer?.beginRefreshing()
            return
        }
    }
    
    // 重新加载网络数据
    func loadData() {
        
    }
}


extension Reactive where Base: MJRefreshComponent {
    public var isAnimating: Binder<Bool> {
        return Binder(self.base) { refreshControl, active in
            if active {
//                refreshControl.beginRefreshing()
            } else {
                refreshControl.endRefreshing()
            }
        }
    }
}



extension TTTableViewController {
    
    // 间距
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.color(.clear)
    }
    
    // 组高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    // 间距
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView.color(.clear)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}

// MARK: - emptyDataSource
extension TTTableViewController {
    
    //    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
    //        return NSAttributedString(string: TTTableViewConfigManager.shared.notDataEmptyText)
    //    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let content: String = ""
//        switch TTNetManager.shared.netStatus {
//        case .none:
//            // 无网络
//            content = TTTableViewConfigManager.shared.notNetworkemptyText
//        case .WWAN,.wiFi:
//            // 有网络,为无内容文本
//            content = emptyContentText()
//        }
//
        let desAtt = NSMutableAttributedString.init(string: content)
        
        // 设置字体颜色
//        desAtt.font = TTTableViewConfigManager.shared.desFont
//        desAtt.color = TTTableViewConfigManager.shared.desColor
        return desAtt
    }
    
    
    // 子类复写
    @objc func emptyContentText() -> String {
        return TTTableViewConfigManager.shared.notDataEmptyText
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return TTTableViewConfigManager.shared.notDataEmptyIcon
    }
    
    // 图片渲染色
    //    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
    //        return .gray
    //    }
    
//    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
//        return .clear
//    }
    
    
    // 按钮背景色@objc(buttonImageForEmptyDataSet:forState:)
    func buttonImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> UIImage! {
//        switch TTNetManager.shared.netStatus {
//        case .none:
//            // 无网络
//            return TTTableViewConfigManager.shared.buttonBackgroundImage
//        case .WWAN,.wiFi:
//            // 有网络,为无内容文本
//            return UIImage()
//        }
        
        return UIImage()
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 0
    }
    
//
//    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
//        // 有头或者尾，在刷新中就不显示空页面
//        if let header = scrollView.mj_header {
//            if header.state == .refreshing || header.state == .willRefresh {
//                return false
//            }
//        }
//
//        if let footer = scrollView.mj_footer {
//            if footer.state == .refreshing || footer.state == .willRefresh {
//                return false
//            }
//        }
//
//        // 如果本来就可见，就直接可见
//        if scrollView.emptyDataViewIsShow() {
//            return true
//        }
//
//        return true
//    }
//
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let content: String = ""
//        switch TTNetManager.shared.netStatus {
//        case .none:
//            // 无网络
//            content = TTTableViewConfigManager.shared.buttonTitle
//        case .WWAN,.wiFi:
//            // 有网络,设置按钮为空
//            content = ""
//        }
        
        let buttonTitleAtt = NSMutableAttributedString.init(string: content)
        
        // 设置字体颜色
//        buttonTitleAtt.font = TTTableViewConfigManager.shared.buttonFont
//        buttonTitleAtt.color = TTTableViewConfigManager.shared.buttonTitleColor
        return buttonTitleAtt
    }
}
