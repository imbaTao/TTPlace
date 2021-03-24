//
//  TTAutoRefreshTableViewController.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/1/20.
//

import UIKit

class TTTableViewConfigManager: NSObject {
    static let shared = TTTableViewConfigManager()

    
    // 标题字体
    var titleFont = UIFont()
    var titleColor = UIColor()
    
    // 描述字体
    var desFont = UIFont()
    var desColor = UIColor()
    
    // 按钮字体
    var buttonFont = UIFont()
    var buttonTitleColor = UIColor()
    var buttonTitle = "重新加载"
    var buttonBackgroundImage = UIImage()
 
    
    // 无网络连接空页面占位图
    var notNetworkEmptyIcon = UIImage()
    var notNetworkemptyText = "对不起网络好像故障了~"
    
    
    
    // 无数据空页面占位图
    var notDataEmptyIcon = UIImage()
    var notDataEmptyText = "暂时还没有房间去其他地方逛逛～"
    
}


class TTAutoRefreshTableViewController: TTTableViewController,DZNEmptyDataSetDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = TTTableViewViewModel()
        }
        // Do any additional setup after loading the view.
    }
    
    override func makeUI() {
        super.makeUI()
        tableView = TTAutoRefreshTableView.init(cellClassNames: [""], style: .plain, state: .headerAndFooter)
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func bindViewModel() {
        super.bindViewModel()
        
        // 绑定信号等
        if let tableView = tableView as? TTAutoRefreshTableView {
            
           if let viewModel = viewModel as? TTTableViewViewModel {
                
            // 下拉刷新绑定vm的刷新
            tableView.headerRefreshEvent.bind(to: viewModel.refreshEvent).disposed(by: rx.disposeBag)
            tableView.footerRefreshEvent.bind(to: viewModel.refreshEvent).disposed(by: rx.disposeBag)
                
                // vm网络请求产生的事件
                 viewModel.dataEvent.subscribe(onNext: {[weak self] (state) in guard let self = self else { return }
                     switch state {
                         case .noMore:
                         tableView.state = .noMore
                         case .updated:
                         tableView.state = .endReFresh
                         case .error:
                         tableView.state = .endReFresh
                     case .empty:
                          tableView.state = .empty
                     default:break
                     }
                 },onError: { (error) in
                    // 网络请求报错
                    tableView.state = .empty
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


//MARK: - 空视图
extension TTAutoRefreshTableViewController: DZNEmptyDataSetSource {
    // 标题,一般不用
//    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
//        return NSAttributedString(string: TTTableViewConfigManager.shared.notDataEmptyText)
//    }

    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: TTTableViewConfigManager.shared.notDataEmptyText + "描述")
    }

    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return TTTableViewConfigManager.shared.notDataEmptyIcon
    }

    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .gray
    }

    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -60
    }
}

extension TTAutoRefreshTableViewController {

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return false
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        loadData()
    }
}
