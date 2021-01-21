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
    }
    

}
