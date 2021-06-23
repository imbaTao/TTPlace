////
////  TTNewTableViewController.swift
////  TTPlace
////
////  Created by Mr.hong on 2021/6/11.
////  Copyright © 2021 Mr.hong. All rights reserved.
////
//
//import Foundation
//
//class TTTableViewViewModel: TTAutoRefreshViewModel {
////    // 默认组模式
////    var style = UITableView.Style.grouped
////
////    // 装类名
////    var cellClassNames = [UITableViewCell.self]
////
////    // 组头高度
////    var sectionHeaderHeight: CGFloat = 0.01
////
////    // 组尾高度
////    var sectionFooterHeight: CGFloat = 0.01
////
////    func fetchDataModel<T: HandyJSON>(type: T.Type,indexPath: IndexPath) -> T {
////        let model = data[indexPath.section]
////        return model as! T
////    }
//}
//
//
//class SubVCModel: HandyJSON {
//
//    required init() {
//
//    }
//}
//
//
//
//class SubVC: TTStaticTableViewController {
//    var vm: SubVCViewModel {
//       return _vm as! SubVCViewModel
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//
//    override func bindViewModel() {
//        super.bindViewModel()
//
//    }
//
////    override func configCell(_ tableView: TTTableView, _ indexPath: IndexPath) -> UITableViewCell? {
////        let model = vm.fetchDataModel(type: SubVCModel.self, indexPath: indexPath)
////
////        switch indexPath.section {
////        case 0:
////
////        case 1:
////
////        case 2:
////
////        default:
////            break
////        }
////        return UITableViewCell()
////    }
//}
//
//class SubVCViewModel: TTTableViewViewModel {
//
//}
//
//
//
//
//// 静态tableView列表
//class TTStaticTableViewController: ViewController,UITableViewDelegate,UITableViewDataSource {
//    var _vm = TTTableViewViewModel()
//
//    lazy var tableView: TTTableView = {
//        // 默认就是组模式
//        var tableView = TTTableView.init(frame: .zero, style: self._vm.style)
//
//        // 注册
//        for cellClass in self._vm.cellClassNames {
//            tableView.register(cellWithClass: cellClass)
//        }
//
//        // 签代理
//        tableView.delegate = self
//        tableView.dataSource = self
//        return tableView
//    }()
//
//    init(configViewModel: (TTTableViewViewModel) -> ()) {
//        configViewModel(self._vm)
//        super.init(self._vm)
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addSubview(tableView)
//        tableView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
//    }
//
//    // 子类复写
//    func configCell(_ tableView: TTTableView,_ indexPath: IndexPath) -> UITableViewCell? {
//        return nil
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//
//extension TTStaticTableViewController {
//    /// MARK: - delegate
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return _vm.data.count
//    }
//
//    // 返回什么样的tableView
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = self.configCell(self.tableView, indexPath) {
//            return cell
//        }
//
//        assert(false, "请配置configCellBlock")
//        return UITableViewCell()
//    }
//
//
//
//
//    // 默认头部高度
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return _vm.sectionHeaderHeight
//    }
//
//    // 默认没有头部视图
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return nil
//    }
//
//    // 默认尾部高度
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return _vm.sectionFooterHeight
//    }
//
//    // 默认尾部视图
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return nil
//    }
//}
//
//
