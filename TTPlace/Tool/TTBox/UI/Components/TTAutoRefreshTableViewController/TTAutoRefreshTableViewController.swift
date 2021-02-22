//
//  TTAutoRefreshTableViewController.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/1/20.
//

import UIKit

class TTAutoRefreshTableViewController: TTTableViewController {

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
        addSubview(tableView)
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
}


//MARK: - 空视图
//extension TTViewController: DZNEmptyDataSetSource {
//
//    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
//        return NSAttributedString(string: emptyDataSetTitle)
//    }
//
//    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
//        return NSAttributedString(string: emptyDataSetDescription)
//    }
//
//    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
//        return emptyDataSetImage
//    }
//
//    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
//        return emptyDataSetImageTintColor.value
//    }
//
//    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
//        return .clear
//    }
//
//    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
//        return -60
//    }
//}
//
//extension ViewController: DZNEmptyDataSetDelegate {
//
//    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
//        return !isLoading.value
//    }
//
//    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
//        return true
//    }
//
//    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
//        emptyDataSetButtonTap.onNext(())
//    }
//
//    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
//        return NSAttributedString.init(string: "点击按钮")
//    }
//}
