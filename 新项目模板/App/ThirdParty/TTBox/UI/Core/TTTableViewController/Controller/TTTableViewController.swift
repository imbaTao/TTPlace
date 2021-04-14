//
//  TTCommonTableViewController.swift
//  TTSwiftLearn
//
//  Created by hong on 2020/1/8.
//  Copyright © 2020 Mr.hong. All rights reserved.



import UIKit

class TTTableViewController: TTViewController,UITableViewDataSource,UITableViewDelegate, UIScrollViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource {
    lazy var tableView: TTTableView = {
        let view = TTTableView.init(cellClassNames: [""], style: .grouped, state: .neitherHeaderFooter)
        return view
    }()
    
    var isNeedShowEmptyData = false {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.tableView.emptyDataSetSource =  self.isNeedShowEmptyData ? self : nil
                self.tableView.emptyDataSetDelegate =  self.isNeedShowEmptyData ? self : nil
                // 刷新empty数据
//                self.tableView.reloadEmptyDataSet()
            }
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
            viewModel = TTTableViewViewModel()
        }
        
        // 绑定信号等
        if let tableView = tableView as? TTTableView {
            
            if let viewModel = viewModel as? TTTableViewViewModel {
                
                // 下拉刷新绑定vm的刷新
                tableView.headerRefreshEvent.bind(to: viewModel.refreshEvent).disposed(by: rx.disposeBag)
                tableView.footerRefreshEvent.bind(to: viewModel.refreshEvent).disposed(by: rx.disposeBag)
                
                // vm网络请求产生的事件
                viewModel.dataEvent.subscribe(onNext: {[weak self] (state) in guard let self = self else { return }
                    switch state {
                    case .noMore:
                        tableView.refreshState = .noMore
                    case .updated:
                        tableView.refreshState = .endReFresh
                    case .error:
                        tableView.refreshState = .endReFresh
                    case .empty:
                        tableView.refreshState = .empty
                    default:break
                    }
                },onError: { (error) in
                    // 网络请求报错
                    tableView.refreshState = .empty
                }).disposed(by: rx.disposeBag)
            }
        }
        
        // 默认下拉刷新
        beginRefresh()
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


extension TTTableViewController {
    // 默认的代理/数据源,子类随时复写
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
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

/// MARK: - emptyDataSource
extension TTTableViewController {
    
    //    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
    //        return NSAttributedString(string: TTTableViewConfigManager.shared.notDataEmptyText)
    //    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let content: String!
        switch TTNetManager.shared.netStatus {
        case .unknown,.notReachable:
            // 无网络
            content = TTTableViewConfigManager.shared.notNetworkemptyText
        case .reachable(.cellular),.reachable(.ethernetOrWiFi):
            // 有网络,为无内容文本
            content = emptyContentText()
        }
        
        let desAtt = NSMutableAttributedString.init(string: content)
        
        // 设置字体颜色
        desAtt.font = TTTableViewConfigManager.shared.desFont
        desAtt.color = TTTableViewConfigManager.shared.desColor
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
  

        
        // 有头或者尾，在刷新中就不显示空页面
        if let header = scrollView.mj_header {
            if header.state == .refreshing || header.state == .willRefresh {
                return false
            }
        }
        
        if let footer = scrollView.mj_footer {
            if footer.state == .refreshing || footer.state == .willRefresh {
                return false
            }
        }
        
        // 如果本来就可见，就直接可见
        if scrollView.emptyDataViewIsShow() {
            return true
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
