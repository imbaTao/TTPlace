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
        
//        stackView.insertArrangedSubview(collectionView, at: 0)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
      
        
        /// 刷新头
//        collectionView.bindGlobalStyle(forHeadRefreshHandler: { [weak self] in
//            self?.headerRefreshTrigger.onNext(())
//        })
        
        
//        collectionView.bindHeadRefreshHandler({ [weak self] in
//            self?.headerRefreshTrigger.onNext(())
//        }, themeColor: .none, refreshStyle: .animatableArrow)
//
//
        
       
        
        
        // 刷新尾
//        collectionView.bindGlobalStyle(forFootRefreshHandler: { [weak self] in
//            self?.footerRefreshTrigger.onNext(())
//        })
        
        // 自动刷新，在尾部
//        collectionView.footRefreshControl.autoRefreshOnFoot = true

        // 刷新头刷新尾，动画控制
//        isHeaderLoading.bind(to: collectionView.headRefreshControl.rx.isAnimating).disposed(by: rx.disposeBag)
//
//        isFooterLoading.bind(to: collectionView.footRefreshControl.rx.isAnimating).disposed(by: rx.disposeBag)



        // 报错事件
        error.subscribe(onNext: { [weak self] (error) in
//            self?.tableView.makeToast(error.description, title: error.title, image: R.image.icon_toast_warning())
            // 显示报错
            showHUD(error.localizedDescription)
        }).disposed(by: rx.disposeBag)
    }


    override func bindViewModel() {
        super.bindViewModel()
        
//        viewModel?.headerLoading.asObservable().bind(to: isHeaderLoading).disposed(by: rx.disposeBag)
//        viewModel?.footerLoading.asObservable().bind(to: isFooterLoading).disposed(by: rx.disposeBag)


        // 更新空视图
//        let updateEmptyDataSet = Observable.of(isLoading.mapToVoid().asObservable(), emptyDataSetImageTintColor.mapToVoid()).merge()
//
//        updateEmptyDataSet.subscribe(onNext: { [weak self] () in
//            self?.collectionView.reloadEmptyDataSet()
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
