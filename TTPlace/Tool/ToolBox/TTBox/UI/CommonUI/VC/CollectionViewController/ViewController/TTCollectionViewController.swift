//
//  TTCollectionViewController.swift
//  Yuhun
//
//  Created by Mr.hong on 2020/12/15.
//

import Foundation

class TTCollectionViewController: ViewController {
    
    lazy var collectionView: TTCollectionView = {
        let view = TTCollectionView()
        view.emptyDataSetSource = self
        view.emptyDataSetDelegate = self
        return view
    }()
    
    
    
    // 头部触发器
    let headerRefreshTrigger = PublishSubject<Void>()

    // 尾部触发器
    let footerRefreshTrigger = PublishSubject<Void>()


    // 是否在刷新中信号
    let isHeaderLoading = BehaviorRelay(value: false)
    
    // 尾部是否在刷新
    let isFooterLoading = BehaviorRelay(value: false)


    //    var clearsSelectionOnViewWillAppear = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    //        if clearsSelectionOnViewWillAppear == true {
    //            deselectSelectedRow()
    //        }
    }

    override func makeUI() {
        super.makeUI()

        stackView.spacing = 0
        stackView.insertArrangedSubview(collectionView, at: 0)
        
        /// 刷新头
        let header = MJRefreshNormalHeader.init(refreshingBlock: { [weak self] in
            self?.headerRefreshTrigger.onNext(())
        })
        collectionView.mj_header = header
        
        // 刷新尾
        let footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { [weak self] in
            self?.footerRefreshTrigger.onNext(())
        })
        collectionView.mj_footer = footer
        

        // 刷新头刷新尾，动画控制
    //        isHeaderLoading.bind(to: tableView.headRefreshControl.rx.isAnimating).disposed(by: rx.disposeBag)
        
    //        isFooterLoading.bind(to: tableView.footRefreshControl.rx.isAnimating).disposed(by: rx.disposeBag)

        // 自动刷新，在尾部
    //        tableView.footRefreshControl.autoRefreshOnFoot = true

        // 报错事件
    //        error.subscribe(onNext: { [weak self] (error) in
    //            self?.tableView.makeToast(error.description, title: error.title, image: R.image.icon_toast_warning())
    //        }).disposed(by: rx.disposeBag)
        
    }

    func updateUI() {
        
    }

    override func bindViewModel() {
        super.bindViewModel()

    //        viewModel?.headerLoading.asObservable().bind(to: isHeaderLoading).disposed(by: rx.disposeBag)
    //
    //
    //        viewModel?.footerLoading.asObservable().bind(to: isFooterLoading).disposed(by: rx.disposeBag)


        // 更新空视图
    //        let updateEmptyDataSet = Observable.of(isLoading.mapToVoid().asObservable(), emptyDataSetImageTintColor.mapToVoid(), languageChanged.asObservable()).merge()
        
    //        updateEmptyDataSet.subscribe(onNext: { [weak self] () in
    //            self?.tableView.reloadEmptyDataSet()
    //        }).disposed(by: rx.disposeBag)
    }



    //extension TableViewController: UITableViewDelegate {
    //
    //    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    //        if let view = view as? UITableViewHeaderFooterView {
    //            view.textLabel?.font = UIFont.systemFont(ofSize: 15)
    //            themeService.rx
    //                .bind({ $0.text }, to: view.textLabel!.rx.textColor)
    //                .bind({ $0.primaryDark }, to: view.contentView.rx.backgroundColor)
    //                .disposed(by: rx.disposeBag)
    //        }
    //    }
    //}




    //extension Reactive where Base: KafkaRefreshControl {
    //
    //    public var isAnimating: Binder<Bool> {
    //        return Binder(self.base) { refreshControl, active in
    //            if active {
    ////                refreshControl.beginRefreshing()
    //            } else {
    //                refreshControl.endRefreshing()
    //            }
    //        }
    //    }
    //}
}

extension TTTableViewController {

    
//    func deselectSelectedRow() {
//        if let selectedIndexPaths = tableView.indexPathsForSelectedRows {
//            selectedIndexPaths.forEach({ (indexPath) in
//                tableView.deselectRow(at: indexPath, animated: false)
//            })
//        }
//    }
}
