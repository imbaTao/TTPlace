//
//  LatestVisitorsVC.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/19.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import UIKit

class LatestVisitorsViewModel: TTTableViewViewModel {
    override func fetchData(compltetBlock: @escaping (Bool, [HandyJSON]?) -> ()) {
        
        
//        /api/v1/users/:id/visitors
//        compltetBlock(true,)
    }
}

class LatestVisitorsVC: TTAutoRefreshTableViewController {
    var _viewModel: TTTableViewViewModel {
        return viewModel as! TTTableViewViewModel
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func makeUI() {
        super.makeUI()
        
        
        
        // config
        title = "最近访客"
        tableView.register(nibWithCellClass: LatestVisitorsTableViewCell.self)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        //创建数据源
//        let dataSource = RxTableViewSectionedReloadDataSource
//                  <SectionModel<String, [TTTableViewCellViewModel]>>(configureCell: {
//                      (dataSource, tv, indexPath, element) in
//                      let cell = tv.dequeueReusableCell(withClass: UITableViewCell.self, for: indexPath)
//                      return cell
//            })
        
        // 模型
//        if let viewModel = viewModel as? LatestVisitorsViewModel {
////            viewModel.groupItems.bind(to: tableView)
//            viewModel.groupItems.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
//        }
//
        //设置代理
        tableView.rx.setDataSource(self).disposed(by: rx.disposeBag)
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }
    
    
    // DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return _viewModel.data.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.color(.clear)
        view.frame = .init(x: 0, y: 0, width: SCREEN_W, height: 10)
        return view
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

}

class TTNormalTableViewController: ViewController,UITableViewDelegate,UITableViewDataSource {
    var _viewModel = TTTableViewViewModel()
    var tableView = TTTableView.init(style: .grouped)

    override func makeUI() {
        super.makeUI()
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        // config
        padding = .init(inset: inset)
        
        tableView.dataSource = self
        tableView.delegate = self
    }



    //MARK: - dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return _viewModel.data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: UITableViewCell.self)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView.color(.clear)
        view.frame = .init(x: 0, y: 0, width: SCREEN_W, height: 10)
        return view
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}
